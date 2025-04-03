package fitralpark.exercise.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.exercise.dto.ExerciseDTO;

@WebServlet("/searchExercise.do")
public class SearchExerciseController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//SearchExerciseController.java
		/*
		 * String keyword = req.getParameter("keyword"); String category =
		 * req.getParameter("category");
		 * 
		 * ExerciseDAO dao = new ExerciseDAO(); ArrayList<ExerciseDTO> result =
		 * dao.searchExercise(keyword, category); dao.close();
		 * 
		 * Gson gson = new Gson(); String json = gson.toJson(result);
		 * 
		 * resp.setContentType("application/json"); resp.setCharacterEncoding("UTF-8");
		 * resp.getWriter().write(json);
		 */
	}

}
