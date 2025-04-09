package fitralpark.diet.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;
import fitralpark.diet.dto.DietDTO;


/**
 * 데이터베이스와 상호작용하여 식단 데이터를 관리하는 DAO 클래스입니다.
 * DataSource를 통해 DB 연결을 관리하며, 다양한 CRUD 작업을 제공합니다.
 */

public class DietDAO {
    private final DataSource dataSource; // DataSource 주입
    
    /**
     * 기본 생성자. JNDI를 통해 DataSource를 초기화합니다.
     *
     * @throws RuntimeException DB 연결 실패 시 발생
     */

    public DietDAO() {
        try {
            Context ctx = new InitialContext();
            Context env = (Context) ctx.lookup("java:comp/env");
            dataSource = (DataSource) env.lookup("jdbc/pool");
        } catch (NamingException e) {
            throw new RuntimeException("DB 연결 실패", e);
        }
    }

    /**
     * 특정 범위의 식단 데이터를 조회합니다.
     *
     * @param begin 조회 시작 인덱스
     * @param end 조회 종료 인덱스
     * @param memberId 회원 ID
     * @return 조회된 식단 목록
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public List<DietDTO> getDiets(int begin, int end, String memberId) {
        String sql = """
                    SELECT * FROM (
                        SELECT a.*, ROWNUM rnum FROM (
                            SELECT
                                d.diet_no,
                                d.diet_name,
                                TO_CHAR(d.regdate, 'YYYY-MM-DD') AS regdate,
                                d.diet_total_kcal,
                                d.meal_classify,
                                d.creator_id,
                                NVL(b.diet_bookmark_no, 0) AS diet_bookmark_no,
                                b.diet_bookmark_no AS aaa,
                                COALESCE(f.food_name, cf.custom_food_name) AS food_name,
                                COALESCE(irdfn.enerc, cf.kcal_per_unit) AS enerc,
                                COALESCE(REGEXP_REPLACE(irdfn.food_size, '[^0-9]', ''), '100') AS food_size
                            FROM diet d
                            LEFT JOIN diet_bookmark b
                                ON d.diet_no = b.diet_no
                                AND b.member_id = ?
                            LEFT JOIN diet_food_list dl
                                ON d.diet_no = dl.diet_no
                            LEFT JOIN food f
                                ON dl.food_no = f.food_no
                                AND dl.food_creation_type = 0
                            LEFT JOIN individual_diet_record_food_nutrient irdfn
                                ON f.food_cd = irdfn.food_cd
                            LEFT JOIN custom_food cf
                                ON dl.custom_food_no = cf.custom_food_no
                                AND dl.food_creation_type = 1
                        ) a WHERE ROWNUM <= ?
                    ) WHERE rnum >= ?
                """;

        List<DietDTO> diets = new ArrayList<>();

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 파라미터 바인딩 (SQL Injection 방지)
            pstmt.setString(1, "hong"); // member_id
            pstmt.setInt(2, end); // ROWNUM <= end
            pstmt.setInt(3, begin); // rnum >= begin

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {

                    DietDTO diet = new DietDTO(rs.getInt("diet_no"), rs.getString("diet_name"), rs.getString("regdate"),
                            rs.getInt("diet_total_kcal"), rs.getString("meal_classify"), rs.getString("creator_id"),
                            rs.getInt("diet_bookmark_no"), rs.getString("food_name"), rs.getDouble("enerc"),
                            Integer.parseInt(rs.getString("food_size")) // int 변환
                    );
                    diets.add(diet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("식단 조회 오류", e);
        }
        return diets.isEmpty() ? new ArrayList<>() : diets; // null 대신 빈 리스트 반환
    }

    /**
     * 특정 회원의 식단 즐겨찾기를 반환합니다.
     *
     * @param memberId 회원 ID
     * @return 총 식단 수
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public int getTotalCount(String memberId) {
        String sql = """
                    SELECT COUNT(*)
                    FROM diet d
                    LEFT JOIN diet_bookmark b
                        ON d.diet_no = b.diet_no
                        AND b.member_id = ?
                """;

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("총 레코드 수 조회 실패", e);
        }
        return 0;
    }

    
    /**
     * 특정 식단 번호에 해당하는 이름을 반환합니다.
     *
     * @param dietNo 식단 번호
     * @return 식단 이름 (없을 경우 "Unknown Diet")
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public String getDietName(int dietNo) {
        String sql = "SELECT diet_name FROM diet WHERE diet_no = ?";

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("diet_name");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("식단명 조회 오류", e);
        }

        return "Unknown Diet";
    }

    /**
     * 특정 식단 번호에 포함된 음식 상세 정보를 조회합니다.
     *
     * @param dietNo 식단 번호
     * @return 음식 상세 정보 목록 (음식명, 열량, 음식 크기 포함)
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public List<Map<String, Object>> getFoodDetails(int dietNo) {
        String sql = """
                            SELECT
                            COALESCE(f.food_name, cf.custom_food_name) AS food_name,
                            COALESCE(irdfn.enerc, cf.kcal_per_unit) AS enerc,
                            COALESCE(
                                TO_NUMBER(REGEXP_REPLACE(irdfn.NUT_CON_STR_QUA, '[^0-9]', '')),
                                cf.food_size,
                                100
                            ) AS food_size
                        FROM diet_food_list dl
                        LEFT JOIN food f
                            ON dl.food_no = f.food_no
                            AND dl.food_creation_type = 0
                        LEFT JOIN individual_diet_record_food_nutrient irdfn
                            ON f.food_cd = irdfn.food_cd
                        LEFT JOIN custom_food cf
                            ON dl.custom_food_no = cf.custom_food_no
                            AND dl.food_creation_type = 1
                        WHERE dl.diet_no = ?
                """;

        List<Map<String, Object>> foods = new ArrayList<>();

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> foodDetailMap = new HashMap<>();
                    foodDetailMap.put("food_name", rs.getString("food_name"));
                    foodDetailMap.put("enerc", rs.getInt("enerc"));
                    foodDetailMap.put("food_size", rs.getInt("food_size"));

                    foods.add(foodDetailMap);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("음식 상세정보 조회 오류", e);
        }

        return foods;
    }

    /**
     * 다양한 조건을 기반으로 식단을 검색합니다.
     *
     * @param calorieMin 최소 칼로리
     * @param calorieMax 최대 칼로리
     * @param mealClassify 식사 분류 (아침, 점심 등)
     * @param searchTerm 검색어
     * @param favoriteFilter 즐겨찾기 필터 여부
     * @param myMealFilter 내가 만든 식단 필터 여부
     * @param memberId 회원 ID
     * @param begin 조회 시작 인덱스
     * @param end 조회 종료 인덱스
     * @return 검색된 식단 목록
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public List<DietDTO> searchDiets(int calorieMin, int calorieMax, String mealClassify, String searchTerm,
            boolean favoriteFilter, boolean myMealFilter, String memberId, int begin, int end) {
        String sql = """

                SELECT
                    d.diet_no,
                    d.diet_name,
                    TO_CHAR(d.regdate, 'YYYY-MM-DD') AS regdate,
                    d.diet_total_kcal,
                    d.meal_classify,
                    d.creator_id,
                    NVL(b.diet_bookmark_no, 0) AS diet_bookmark_no
                FROM diet d
                LEFT JOIN diet_bookmark b
                    ON d.diet_no = b.diet_no
                    AND b.member_id = ?
                WHERE d.diet_total_kcal BETWEEN ? AND ?
                  AND (d.meal_classify = ?)
                  AND (d.diet_name LIKE '%'|| ? ||'%')

                """;

        List<DietDTO> diets = new ArrayList<>();
        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            pstmt.setInt(2, calorieMin);
            pstmt.setInt(3, calorieMax);
            pstmt.setString(4, mealClassify);
            pstmt.setString(5, searchTerm);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DietDTO diet = new DietDTO(rs.getInt("diet_no"), rs.getString("diet_name"), rs.getString("regdate"),
                            rs.getInt("diet_total_kcal"), rs.getString("meal_classify"), rs.getString("creator_id"),
                            rs.getInt("diet_bookmark_no"));
                    diets.add(diet);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("검색 오류", e);
        }
        return diets;
    }


    /**
     * 즐겨찾기를 추가하거나 제거합니다.
     *
     * @param dietNo 식단 번호
     * @param memberId 회원 ID
     */
    public void editBookmark(String dietNo, String memberId) {

        try {

            Connection conn = dataSource.getConnection();

            String sql = "select count(*) as cnt from diet_bookmark where diet_no = ? and member_id = ?";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dietNo);
            pstmt.setString(2, memberId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                System.out.println(rs.getInt("cnt"));
                if (rs.getInt("cnt") > 0) {

                    // delete bookmark
                    deleteBookmark(dietNo, memberId);

                } else {

                    // add bookmark
                    addBookmark(dietNo, memberId);

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
    /**
     * 특정 식단 번호와 회원 ID를 기반으로 즐겨찾기를 추가합니다.
     *
     * @param dietNo 식단 번호
     * @param memberId 회원 ID
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public void addBookmark(String dietNo, String memberId) {
        String sql = "INSERT INTO diet_bookmark (DIET_BOOKMARK_NO, diet_no, member_id, regdate) VALUES (seq_diet_bookmark.nextVal, ?, ?, SYSDATE)";

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dietNo);
            pstmt.setString(2, memberId);
            System.out.println("result: " + pstmt.executeUpdate());

        } catch (SQLException e) {
            throw new RuntimeException("즐겨찾기 추가 오류", e);
        }
    }
    
    /**
     * 특정 식단 번호와 회원 ID를 기반으로 즐겨찾기를 제거합니다.
     *
     * @param dietNo 식단 번호
     * @param memberId 회원 ID
     * @throws RuntimeException SQL 실행 중 오류 발생 시
     */
    public void deleteBookmark(String dietNo, String memberId) {
        String sql = "DELETE FROM diet_bookmark WHERE diet_no = ? AND member_id = ?";

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dietNo);
            pstmt.setString(2, memberId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("즐겨찾기 삭제 오류", e);
        }
    }
    
    /**
     * 특정 식단이 즐겨찾기 상태인지 확인합니다.
     *
     * @param dietNo 식단 번호
     * @param memberId 회원 ID
     * @return 즐겨찾기 여부 (true/false)
     * @throws SQLException SQL 실행 중 오류 발생 시
     */
    public boolean isBookmarked(int dietNo, String memberId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM diet_bookmark WHERE diet_no = ? AND member_id = ?";
        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, dietNo);
            pstmt.setString(2, memberId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }


    /**
     * 추천 식단 라이브러리 목록을 조회합니다.
     *
     * @param begin 조회 시작 인덱스
     * @param end 조회 종료 인덱스
     * @param memberId 회원 ID
     * @return 추천 식단 목록
     */
    public List<DietDTO> getRecommendDiets(int begin, int end, String memberId) {
        String sql = """
                    SELECT * FROM (
                        SELECT a.*, ROWNUM rnum FROM (
                            SELECT
                                d.diet_no,
                                d.diet_name,
                                dc.diet_category_name,
                                TO_CHAR(d.regdate, 'YYYY-MM-DD') AS regdate,
                                d.diet_total_kcal,
                                d.meal_classify,
                                d.creator_id,
                                NVL(b.diet_bookmark_no, 0) AS diet_bookmark_no,
                                d.views
                            FROM diet d
                            LEFT JOIN diet_bookmark b
                                ON d.diet_no = b.diet_no
                                AND b.member_id = ?
                            LEFT JOIN diet_category dc
                                ON d.diet_category_no = dc.diet_category_no
                            ORDER BY d.regdate DESC
                        ) a WHERE ROWNUM <= ?
                    ) WHERE rnum >= ?
                """;

        List<DietDTO> diets = new ArrayList<>();

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            pstmt.setInt(2, end);
            pstmt.setInt(3, begin);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DietDTO diet = new DietDTO();
                    diet.setDiet_no(rs.getInt("diet_no"));
                    diet.setDiet_name(rs.getString("diet_name"));
                    diet.setDiet_category_name(rs.getString("diet_category_name"));
                    diet.setRegdate(rs.getString("regdate"));
                    diet.setDiet_total_kcal(rs.getInt("diet_total_kcal"));
                    diet.setMeal_classify(rs.getString("meal_classify"));
                    diet.setCreator_id(rs.getString("creator_id"));
                    diet.setDiet_bookmark_no(rs.getInt("diet_bookmark_no"));
                    diet.setViews(rs.getInt("views"));

                    diets.add(diet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return diets;
    }

    /**
     * 특정 식단 번호에 포함된 음식의 영양소 정보를 조회합니다.
     *
     * @param dietNo 식단 번호
     * @return 음식 영양소 정보 목록 (열량, 단백질, 탄수화물 등 포함)
     */
    public List<Map<String, Object>> getFoodNuts(int dietNo) {
        String sql = """
                                    SELECT
                        COALESCE(f.food_name, cf.custom_food_name) AS food_name, -- 음식명
                        COALESCE(irdfn.enerc, cf.kcal_per_unit) AS enerc,       -- 열량 (kcal)
                        COALESCE(irdfn.protein,
                            (SELECT SUM(ncn.nutrient_content)
                             FROM custom_food_nutrient ncn
                             WHERE ncn.custom_food_no = cf.custom_food_no
                               AND ncn.nutrient_cd = 'PROT'), 0) AS protein,    -- 단백질 (g)
                        COALESCE(irdfn.chocdf,
                            (SELECT SUM(ncn.nutrient_content)
                             FROM custom_food_nutrient ncn
                             WHERE ncn.custom_food_no = cf.custom_food_no
                               AND ncn.nutrient_cd = 'chocdf'), 0) AS chocdf,     -- 탄수화물 (g)
                        COALESCE(irdfn.fatce,
                            (SELECT SUM(ncn.nutrient_content)
                             FROM custom_food_nutrient ncn
                             WHERE ncn.custom_food_no = cf.custom_food_no
                               AND ncn.nutrient_cd = 'fatce'), 0) AS fatce,       -- 지방 (g)
                        COALESCE(irdfn.na,
                            (SELECT SUM(ncn.nutrient_content)
                             FROM custom_food_nutrient ncn
                             WHERE ncn.custom_food_no = cf.custom_food_no
                               AND ncn.nutrient_cd = 'nat'), 0) AS na            -- 나트륨 (mg)
                    FROM diet_food_list dl
                    LEFT JOIN food f
                        ON dl.food_no = f.food_no
                        AND dl.food_creation_type = 0                           -- 일반 음식
                    LEFT JOIN individual_diet_record_food_nutrient irdfn
                        ON f.food_cd = irdfn.food_cd                            -- 영양소 데이터 조인
                    LEFT JOIN custom_food cf
                        ON dl.custom_food_no = cf.custom_food_no
                        AND dl.food_creation_type = 1                           -- 커스텀 음식
                    WHERE dl.diet_no = ?
                """;

        List<Map<String, Object>> foods = new ArrayList<>();

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> foodDetailMap = new HashMap<>();
                    foodDetailMap.put("food_name", rs.getString("food_name"));
                    foodDetailMap.put("enerc", rs.getDouble("enerc"));
                    foodDetailMap.put("protein", rs.getDouble("protein"));
                    foodDetailMap.put("chocdf", rs.getDouble("chocdf"));
                    foodDetailMap.put("fatce", rs.getDouble("fatce"));
                    foodDetailMap.put("na", rs.getDouble("na"));

                    foods.add(foodDetailMap);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("음식 영양소 정보 조회 오류", e);
        }

        return foods;
    }

    /**
     * 특정 식단의 추천 및 비추천 수를 조회합니다.
     *
     * @param dietNo 식단 번호
     * @return 추천 및 비추천 수를 포함하는 맵 (recommend, disrecommend 키 사용)
     */
    public Map<String, Object> getDietRecommendInfo(int dietNo) {
        String sql = "SELECT recommend, disrecommend FROM diet WHERE diet_no = ?";
        Map<String, Object> result = new HashMap<>();

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    result.put("recommend", rs.getInt("recommend"));
                    result.put("disrecommend", rs.getInt("disrecommend"));
                } else {
                    result.put("recommend", 0);
                    result.put("disrecommend", 0);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("추천/비추천 정보 조회 오류", e);
        }

        return result;
    }

    /**
     * 특정 식단의 조회수를 증가시킵니다.
     *
     * @param dietNo 식단 번호
     * @return 업데이트된 조회수 값
     */
    public int incrementViews(int dietNo) {
        String sql = "UPDATE diet SET views = views + 1 WHERE diet_no = ?";
        String selectSql = "SELECT views FROM diet WHERE diet_no = ?";
        int updatedViews = 0;

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);
            pstmt.executeUpdate();

            // 업데이트된 조회수 가져오기
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, dietNo);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        updatedViews = rs.getInt("views");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updatedViews;
    }

    /**
     * 특정 식단의 추천수를 증가시킵니다.
     *
     * @param dietNo 식단 번호
     * @return 업데이트된 추천수 값
     */
    public int incrementRecommend(int dietNo) {
        String sql = "UPDATE diet SET recommend = recommend + 1 WHERE diet_no = ?";
        String selectSql = "SELECT recommend FROM diet WHERE diet_no = ?";
        int updatedRecommend = 0;

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);
            pstmt.executeUpdate();

            // 업데이트된 추천수 가져오기
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, dietNo);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        updatedRecommend = rs.getInt("recommend");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updatedRecommend;
    }

    /**
     * 특정 식단의 비추천수를 증가시킵니다.
     *
     * @param dietNo 식단 번호
     * @return 업데이트된 비추천수 값
     */
    public int incrementDisrecommend(int dietNo) {
        String sql = "UPDATE diet SET disrecommend = disrecommend + 1 WHERE diet_no = ?";
        String selectSql = "SELECT disrecommend FROM diet WHERE diet_no = ?";
        int updatedDisrecommend = 0;

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);
            pstmt.executeUpdate();

            // 업데이트된 비추천수 가져오기
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, dietNo);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        updatedDisrecommend = rs.getInt("disrecommend");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updatedDisrecommend;
    }

    /**
     * 다양한 조건을 기반으로 추천 식단을 검색합니다.
     *
     * @param calorieMin 최소 칼로리
     * @param calorieMax 최대 칼로리
     * @param mealClassify 식사 분류 (아침, 점심 등)
     * @param searchTerm 검색어
     * @param dietCategory 식단 카테고리
     * @param favoriteFilter 즐겨찾기 필터 여부
     * @param myMealFilter 내가 만든 식단 필터 여부
     * @param memberId 회원 ID
     * @param begin 조회 시작 인덱스
     * @param end 조회 종료 인덱스
     * @return 검색된 추천 식단 목록
     */
    public List<DietDTO> searchRecomDiets(int calorieMin, int calorieMax, String mealClassify, String searchTerm,
            String dietCategory, boolean favoriteFilter, boolean myMealFilter, String memberId, int begin, int end) {
        String sql = """
                SELECT
                d.diet_no,
                d.diet_name,
                TO_CHAR(d.regdate, 'YYYY-MM-DD') AS regdate,
                d.diet_total_kcal,
                d.meal_classify,
                d.creator_id,
                dc.diet_category_name AS diet_category,
                NVL(b.diet_bookmark_no, 0) AS diet_bookmark_no
                FROM diet d
                LEFT JOIN diet_bookmark b
                ON d.diet_no = b.diet_no
                AND b.member_id = ?
                LEFT JOIN diet_category dc
                ON d.diet_category_no = dc.diet_category_no
                WHERE d.diet_total_kcal BETWEEN ? AND ?
                AND (d.meal_classify = ? OR ? IS NULL)
                AND (d.diet_name LIKE '%'|| ? ||'%' OR ? IS NULL)
                AND (dc.diet_category_name = ? OR ? IS NULL)
                AND (? = 0 OR NVL(b.diet_bookmark_no, 0) > 0)
                AND (? = 0 OR d.creator_id = ?)
                ORDER BY d.regdate DESC
                """;

        List<DietDTO> diets = new ArrayList<>();
        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            pstmt.setInt(2, calorieMin);
            pstmt.setInt(3, calorieMax);
            pstmt.setString(4, mealClassify);
            pstmt.setString(5, mealClassify);
            pstmt.setString(6, searchTerm);
            pstmt.setString(7, searchTerm);
            pstmt.setString(8, dietCategory);
            pstmt.setString(9, dietCategory);
            pstmt.setInt(10, favoriteFilter ? 1 : 0);
            pstmt.setInt(11, myMealFilter ? 1 : 0);
            pstmt.setString(12, memberId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DietDTO diet = new DietDTO(rs.getInt("diet_no"), rs.getString("diet_name"), rs.getString("regdate"),
                            rs.getInt("diet_total_kcal"), rs.getString("meal_classify"), rs.getString("creator_id"),
                            rs.getString("diet_category"), // 카테고리 정보 추가
                            rs.getInt("diet_bookmark_no"));
                    diets.add(diet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("추천 식단 검색 오류", e);
        }
        return diets;
    }

    /**
     * 특정 식단의 추천/비추천 수를 조회합니다.
     *
     * @param dietNo 식단 번호
     * @return 추천 및 비추천 수를 포함하는 맵 (recommend 및 disrecommend 키 사용)
     */
    public HashMap<String, Integer> getCount(String dietNo) {

        String sql = "select recommend, disrecommend from diet where diet_no = ?";

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dietNo);

            ResultSet rs = pstmt.executeQuery();

            HashMap<String, Integer> map = new HashMap<String, Integer>();

            if (rs.next()) {

                map.put("recommend", rs.getInt("recommend"));
                map.put("disrecommend", rs.getInt("disrecommend"));

            }

            return map;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 특정 회원 ID를 기반으로 음식 데이터를 조회합니다.
     *
     * @param begin 조회 시작 인덱스
     * @param end 조회 종료 인덱스
     * @param memberId 회원 ID
     * @return 음식 데이터 목록 (DietDTO 객체 리스트)
     */
    public List<DietDTO> getFoods(int begin, int end, String memberId) {
        String sql = """
                                SELECT
                        n.food_cd,
                        n.food_name,
                        n.foodlv4_name,
                        REGEXP_REPLACE(n.nut_con_str_qua, '[^0-9]', '') AS nut_con_str_qua_numeric,
                        COALESCE(n.enerc, 0) AS enerc,
                        COALESCE(n.protein, 0) AS protein,
                        COALESCE(n.fatce, 0) AS fatce,
                        COALESCE(n.chocdf, 0) AS chocdf,
                        COALESCE(n.sugar, 0) AS sugar,
                        COALESCE(n.na, 0) AS na,
                        f.food_no,
                        COALESCE(b.food_bookmark_no, 0) AS food_bookmark_no
                    FROM individual_diet_record_food_nutrient n
                    INNER JOIN food f
                        ON n.food_cd = f.food_cd
                    LEFT JOIN food_bookmark b
                        ON f.food_no = b.food_no
                        AND b.member_id = ?
                    WHERE ROWNUM <= 10
                    ORDER BY n.food_name
                """;

        List<DietDTO> foods = new ArrayList<>();

        try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    
                    DietDTO dto = new DietDTO();
                    dto.setFood_cd(rs.getString("food_cd"));
                    dto.setFood_name(rs.getString("food_name"));
                    dto.setFoodlv4_name(rs.getString("foodlv4_name"));
                    dto.setNut_con_str_qua(rs.getString("nut_con_str_qua_numeric"));
                    dto.setEnerc(rs.getDouble("enerc"));
                    dto.setProtein(rs.getDouble("protein"));
                    dto.setFatce(rs.getDouble("fatce"));
                    dto.setChocdf(rs.getDouble("chocdf"));
                    dto.setSugar(rs.getDouble("sugar"));
                    dto.setNa(rs.getDouble("na"));
                    dto.setFood_no(rs.getInt("food_no"));
                    dto.setFood_bookmark_no(rs.getInt("food_bookmark_no"));

                    foods.add(dto);
                }
                
            }
        } catch (SQLException e) {
            throw new RuntimeException("음식 데이터 조회 오류", e);
        }

        return foods.isEmpty() ? new ArrayList<>() : foods;
    }

}
