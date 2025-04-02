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
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe"; // 오라클 DB URL
    private static final String DB_USER = "server"; // 오라클 사용자명
    private static final String DB_PASSWORD = "java1234"; // 오라클 비밀번호

    // 데이터베이스 연결 메서드
    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver"); // 오라클 드라이버 로드
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // 검색어로 데이터를 조회하는 메서드
    public List<NutritionDTO> searchFoods(String keyword) {
        List<NutritionDTO> foodList = new ArrayList<>();
        String sql = "SELECT food_name, nut_con_str_qua, enerc, protein, chocdf, fatce, sugar, na, ca, fe, p, k, chole, fasat, fatrn, vataRae, cartb, thia, ribf, nia, vitac, vitd, food_size " +
                     "FROM individual_diet_record_food_nutrient WHERE food_name LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + keyword + "%"); // 검색어를 LIKE 조건에 설정
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
}
