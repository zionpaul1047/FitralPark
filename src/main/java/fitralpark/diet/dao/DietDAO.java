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
                        AND dl.food_creation_type = 1
                    LEFT JOIN individual_diet_record_food_nutrient irdfn 
                        ON f.food_cd = irdfn.food_cd
                    LEFT JOIN custom_food cf 
                        ON dl.custom_food_no = cf.custom_food_no 
                        AND dl.food_creation_type = 2
                ) a WHERE ROWNUM <= ?
            ) WHERE rnum >= ?
        """;

        List<DietDTO> diets = new ArrayList<>();
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // 파라미터 바인딩 (SQL Injection 방지)
            pstmt.setString(1, memberId);  // member_id
            pstmt.setInt(2, end);          // ROWNUM <= end
            pstmt.setInt(3, begin);        // rnum >= begin

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    DietDTO diet = new DietDTO(
                        rs.getInt("diet_no"),
                        rs.getString("diet_name"),
                        rs.getString("regdate"),
                        rs.getInt("diet_total_kcal"),
                        rs.getString("meal_classify"),
                        rs.getString("creator_id"),
                        rs.getInt("diet_bookmark_no"),
                        rs.getString("food_name"),
                        rs.getInt("enerc"),
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

        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

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

        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

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
                COALESCE(REGEXP_REPLACE(irdfn.food_size, '[^0-9]', ''), '100') AS food_size
            FROM diet_food_list dl
            LEFT JOIN food f 
                ON dl.food_no = f.food_no 
                AND dl.food_creation_type = 1
            LEFT JOIN individual_diet_record_food_nutrient irdfn 
                ON f.food_cd = irdfn.food_cd
            LEFT JOIN custom_food cf 
                ON dl.custom_food_no = cf.custom_food_no 
                AND dl.food_creation_type = 2
            WHERE dl.diet_no = ?
        """;

        List<Map<String, Object>> foods = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dietNo);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> foodDetailMap = new HashMap<>();
                    foodDetailMap.put("food_name", rs.getString("food_name"));
                    foodDetailMap.put("enerc", rs.getInt("enerc"));
                    foodDetailMap.put("food_size", rs.getString("food_size"));

                    foods.add(foodDetailMap);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("음식 상세정보 조회 오류", e);
        }

        return foods;
    }


    
}
