package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/routineAddok.do")
public class RoutineAddController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String[] names = req.getParameterValues("exerciseName");
	    String[] categories = req.getParameterValues("exerciseCategoryNo");
	    String[] parts = req.getParameterValues("exercisePartNo");
	    String[] calories = req.getParameterValues("caloriesPerUnit");

	    String creatorId = ((UserDTO) req.getSession().getAttribute("loginUser")).getMemberId();

	    ExerciseDAO dao = new ExerciseDAO();

	    for (int i = 0; i < names.length; i++) {
	        dao.insertCustomExercise(
	            names[i],
	            categories[i],
	            parts[i],
	            calories[i],
	            creatorId
	        );
	    }

	    dao.close();
	    resp.sendRedirect("/fitralpark/exercise/routineAddExerciseList.do");
		
	}

}
