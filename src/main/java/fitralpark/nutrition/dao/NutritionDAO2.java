package fitralpark.nutrition.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
}
