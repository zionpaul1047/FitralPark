package fitralpark.user.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import fitralpark.diet.dto.IntakeRecordDTO;
import fitralpark.user.dao.UserDAO;

@WebServlet("/dashrecordintake.do")
public class DashRecordIntake extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		req.setCharacterEncoding("UTF-8");
		
//		String id = req.getParameter("id");
//		String diet_no = req.getParameter("diet_no");
//		String meal_classify = req.getParameter("meal_classify");
//		String arrFood = req.getParameter("arrFood");
//		
//		System.out.println(id);
//		System.out.println(diet_no);
//		System.out.println(meal_classify);
//		System.out.println(arrFood);
//		

		
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(req.getInputStream()));
		StringBuilder jsonData = new StringBuilder();
		String line = null;
		
		while((line = reader.readLine()) != null) {
			jsonData.append(line);
		}
		
		JSONParser parser = new JSONParser();
		ArrayList<IntakeRecordDTO> dtoList = new ArrayList<IntakeRecordDTO>();
		
		try {
			JSONObject diet = (JSONObject)parser.parse(jsonData.toString());
			
			String id = diet.get("id").toString();
			String diet_no = diet.get("diet_no").toString();
			String meal_classify = diet.get("meal_classify").toString();
			String arrFood = diet.get("arrFood").toString();
			
//			System.out.println("id: " + id);
//			System.out.println("diet_no: " + diet_no);
//			System.out.println("meal_classify: " + meal_classify);
//			System.out.println("arrFood: " + arrFood);
			
			try {
				JSONArray foods = (JSONArray)parser.parse(arrFood);
				
				for(Object food : foods) {
					JSONObject jsonFood = (JSONObject)parser.parse(food.toString());
					
					IntakeRecordDTO dto = new IntakeRecordDTO();
					dto.setCreatorId(id);
					dto.setDietNo(diet_no);
					dto.setMealClassify(meal_classify);
					dto.setFoodCreationType(jsonFood.get("food_creation_type").toString());
					dto.setFoodNo(jsonFood.get("food_no").toString());
					dto.setIntake(jsonFood.get("intake").toString());
					
					dtoList.add(dto);
					
				}
				
//				System.out.println("dtoList: " + dtoList);
				
				UserDAO dao = new UserDAO();
				int result = dao.tdyRecordIntake(dtoList);
				
				dao.close();
				
				resp.setContentType("application/json");
				PrintWriter writer = resp.getWriter();
				
				writer.print("""
						{"result": %d}
						""".formatted(result));
				
				writer.close();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		

	}

}
