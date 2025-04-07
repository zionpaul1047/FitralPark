package fitralpark.nutrition.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import fitralpark.nutrition.dto.NutritionDTO;

public class NutritionDAO {

    // 데이터베이스 연결 정보
    private static final String DB_URL = "jdbc:oracle:thin:@192.168.10.46:1521:xe"; // 오라클 DB URL
    private static final String DB_USER = "server"; // 오라클 사용자명
    private static final String DB_PASSWORD = "java1234"; // 오라클 비밀번호

    // 데이터베이스 연결 메서드
    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver"); // 오라클 드라이버 로드
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // 검색어로 데이터를 조회하는 메서드
    public List<NutritionDTO> searchFoods(String keyword, int startRow, int endRow) {
        List<NutritionDTO> foodList = new ArrayList<>();
        
        String sql =  "SELECT * FROM ("
        			+ "SELECT ROWNUM AS rnum, a.* FROM ("
        			+ "SELECT food_name, "
        			+ "NVL(nut_con_str_qua, 0) AS nut_con_str_qua, "
        			+ "NVL(enerc, 0) AS enerc, "
        			+ "NVL(protein, 0) AS protein, "
        			+ "NVL(chocdf, 0) AS chocdf, "
        			+ "NVL(fatce, 0) AS fatce, "
        			+ "NVL(sugar, 0) AS sugar, "
        			+ "NVL(na, 0) AS na, "
        			+ "NVL(ca, 0) AS ca, "
        			+ "NVL(fe, 0) AS fe, "
        			+ "NVL(p, 0) AS p, "
        			+ "NVL(k, 0) AS k, "
        			+ "NVL(chole, 0) AS chole, "
        			+ "NVL(fasat, 0) AS fasat, "
        			+ "NVL(fatrn, 0) AS fatrn, "
        			+ "NVL(vataRae, 0) AS vataRae, "
        			+ "NVL(cartb, 0) AS cartb, "
        			+ "NVL(thia, 0) AS thia, "
        			+ "NVL(ribf, 0) AS ribf, "
        			+ "NVL(nia, 0) AS nia, "
        			+ "NVL(vitac, 0) AS vitac, "
        			+ "NVL(vitd, 0) AS vitd, "
        			+ "NVL(food_size, 0) AS food_size "
        			+ "FROM individual_diet_record_food_nutrient WHERE food_name LIKE ? ORDER BY food_name"
        			+ ") a WHERE ROWNUM <= ?"
        			+ ") WHERE rnum >= ?";
                

                
        /*
        String sql = "SELECT food_name, nut_con_str_qua, enerc, protein, chocdf, fatce, sugar, na, ca, fe, p, k, chole, fasat, fatrn, vataRae, cartb, thia, ribf, nia, vitac, vitd, food_size " +
        		"FROM individual_diet_record_food_nutrient WHERE food_name LIKE ?";
        */

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + keyword + "%"); // 검색어를 LIKE 조건에 설정
            
            pstmt.setInt(2, endRow);
            pstmt.setInt(3, startRow);
            
            ResultSet rs = pstmt.executeQuery();
            System.out.println("SQL 쿼리 실행: " + sql);
            System.out.println("검색 파라미터: %" + keyword + "%");
            
            while (rs.next()) {
                NutritionDTO dto = new NutritionDTO();
                dto.setFood_name(rs.getString("food_name"));
                dto.setNut_con_str_qua(rs.getString("nut_con_str_qua"));
                dto.setEnerc(rs.getString("enerc"));
                dto.setProtein(rs.getString("protein"));
                dto.setChocdf(rs.getString("chocdf"));
                dto.setFatce(rs.getString("fatce"));
                dto.setSugar(rs.getString("sugar"));
                dto.setNa(rs.getString("na"));
                dto.setCa(rs.getString("ca"));
                dto.setFe(rs.getString("fe"));
                dto.setP(rs.getString("p"));
                dto.setK(rs.getString("k"));
                dto.setChole(rs.getString("chole"));
                dto.setFasat(rs.getString("fasat"));
                dto.setFatrn(rs.getString("fatrn"));
                dto.setVataRae(rs.getString("vataRae"));
                dto.setCartb(rs.getString("cartb"));
                dto.setThia(rs.getString("thia"));
                dto.setRibf(rs.getString("ribf"));
                dto.setNia(rs.getString("nia"));
                dto.setVitac(rs.getString("vitac"));
                dto.setVitd(rs.getString("vitd"));
                dto.setFood_size(rs.getString("food_size"));

                foodList.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return foodList; // 검색 결과 반환
    }
    
 // 총 검색 결과 개수를 계산하는 메서드
    public int getTotalResults(String keyword) {
        int totalResults = 0;
        String sql = "SELECT COUNT(*) FROM individual_diet_record_food_nutrient WHERE food_name LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                totalResults = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalResults;
    }
    
}


