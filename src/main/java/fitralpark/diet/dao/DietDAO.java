package fitralpark.diet.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;
import fitralpark.diet.dto.DietDTO;

public class DietDAO {
    private final DataSource dataSource; // DataSource 주입

    public DietDAO() {
        try {
            Context ctx = new InitialContext();
            Context env = (Context) ctx.lookup("java:comp/env");
            dataSource = (DataSource) env.lookup("jdbc/pool");
        } catch (NamingException e) {
            throw new RuntimeException("DB 연결 실패", e);
        }
    }

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

    // 여기까지 됨

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

    // 식단의 추천/비추천 정보를 가져오는 메서드
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

    // 조회수 증가 메서드
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

    // 추천수 증가 메서드
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

    // 비추천수 증가 메서드
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

    /*
     * public List<DietDTO> getFoods(int begin, int end, String memberId) { String
     * sql = """ SELECT n.food_cd, n.food_name, n.foodlv4_name,
     * REGEXP_REPLACE(n.nut_con_str_qua, '[^0-9]', '') AS nut_con_str_qua_numeric,
     * COALESCE(n.enerc, 0) AS enerc, COALESCE(n.protein, 0) AS protein,
     * COALESCE(n.fatce, 0) AS fatce, COALESCE(n.chocdf, 0) AS chocdf,
     * COALESCE(n.sugar, 0) AS sugar, COALESCE(n.na, 0) AS na, f.food_no,
     * COALESCE(b.food_bookmark_no, 0) AS food_bookmark_no FROM
     * individual_diet_record_food_nutrient n INNER JOIN food f ON n.food_cd =
     * f.food_cd LEFT JOIN food_bookmark b ON f.food_no = b.food_no AND b.member_id
     * = ? ORDER BY n.food_name """;
     * 
     * List<DietDTO> foods = new ArrayList<>();
     * 
     * try (Connection conn = dataSource.getConnection(); PreparedStatement pstmt =
     * conn.prepareStatement(sql)) {
     * 
     * pstmt.setString(1, memberId);
     * 
     * try (ResultSet rs = pstmt.executeQuery()) { while (rs.next()) { DietDTO dto =
     * new DietDTO(); // 음식 정보 매핑 dto.setFood_cd(rs.getString("food_cd"));
     * dto.setFood_name(rs.getString("food_name"));
     * dto.setFoodLv4Nm(rs.getString("foodLv4Nm"));
     * 
     * // 용량: null → "0" 처리 String nutConStrQua = rs.getString("nut_con_srtr_qua");
     * dto.setNut_con_srtr_qua(nutConStrQua != null ? nutConStrQua : "0");
     * 
     * // 영양소 정보 (COALESCE로 이미 0 처리됨) dto.setEnerc(rs.getInt("enerc"));
     * dto.setProt(rs.getInt("protein")); dto.setFatce(rs.getInt("fatce"));
     * dto.setChocdf(rs.getInt("chocdf")); dto.setSugar(rs.getInt("sugar"));
     * dto.setNat(rs.getInt("na"));
     * 
     * // food_no와 북마크 정보 dto.setFood_no(rs.getInt("food_no"));
     * dto.setFood_bookmark_no(rs.getInt("food_bookmark_no"));
     * 
     * foods.add(dto); } } } catch (SQLException e) { e.printStackTrace(); }
     * 
     * return foods.isEmpty() ? new ArrayList<>() : foods; }
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
