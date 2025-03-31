package fitralpark.nutrition.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/nutrition/foodsearch.do")
public class NutritionSearchController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//NutritionSearchController.java
		

		req.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(req, resp);
	}

}
