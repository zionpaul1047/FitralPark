package fitralpark.nutrition.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
<<<<<<< HEAD
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
=======

public class NutritionDAO {


    public static void main(String[] args) {
        // 데이터베이스 연결 정보
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle DB URL (호스트와 SID에 맞게 수정)
        String user = "server"; // DB 사용자 이름
        String password = "java1234"; // DB 비밀번호

        // SQL 쿼리
        String sql = "SELECT food_name, nut_con_str_qua, enerc, protein, chocdf, fatce, sugar, na, ca, fe, p, k, chole, fasat, fatrn, vataRae, cartb, thia, ribf, nia, vitac, vitd, food_size " +
                     "FROM individual_diet_record_food_nutrient " +
                     "WHERE food_name LIKE '%피자%'";

        try (
            // 데이터베이스 연결
            Connection conn = DriverManager.getConnection(url, user, password);
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
        ) {
            // 결과 출력
            while (rs.next()) {
                System.out.println("식품명: " + rs.getString("food_name"));
                System.out.println("영양성분함량기준량: " + rs.getString("nut_con_str_qua"));
                System.out.println("에너지(칼로리): " + rs.getString("enerc"));
                System.out.println("단백질: " + rs.getString("protein"));
                System.out.println("탄수화물: " + rs.getString("chocdf"));
                System.out.println("지방: " + rs.getString("fatce"));
                System.out.println("당류: " + rs.getString("sugar"));
                System.out.println("나트륨: " + rs.getString("na"));
                System.out.println("칼슘: " + rs.getString("ca"));
                System.out.println("철: " + rs.getString("fe"));
                System.out.println("인: " + rs.getString("p"));
                System.out.println("칼륨: " + rs.getString("k"));
                System.out.println("콜레스테롤: " + rs.getString("chole"));
                System.out.println("포화지방산: " + rs.getString("fasat"));
                System.out.println("트랜스지방산: " + rs.getString("fatrn"));
                System.out.println("비타민 A: " + rs.getString("vataRae"));
                System.out.println("베타카로틴: " + rs.getString("cartb"));
                System.out.println("비타민 B1(티아민): " + rs.getString("thia"));
                System.out.println("비타민 B2(리보플라빈): " + rs.getString("ribf"));
                System.out.println("비타민 B3(니아신): " + rs.getString("nia"));
                System.out.println("비타민 C: " + rs.getString("vitac"));
                System.out.println("비타민 D: " + rs.getString("vitd"));
                System.out.println("식품중량: " + rs.getString("food_size"));
                System.out.println("----------------------------------------");
>>>>>>> 0e60b5ec92866662563f0fcb3271f5ff198ede2c
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
<<<<<<< HEAD

        return foodList; // 검색 결과 반환
    }
=======
    }
	
>>>>>>> 0e60b5ec92866662563f0fcb3271f5ff198ede2c
}
