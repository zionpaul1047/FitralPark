package fitralpark.exercise.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.RoutineDAO;
import fitralpark.exercise.dto.RoutineDTO;

//운동 추천 기능 컨트롤러
@WebServlet("/exerciseRecommend.do")
public class ExerciseRecommendationController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//ExerciseRecommendationController.java
		
		RoutineDAO dao = new RoutineDAO();
		
		ArrayList<RoutineDTO> list = dao.list();
		dao.close();

		req.setAttribute("list", list);

		req.getRequestDispatcher("/WEB-INF/views/exercise/exerciseRecommend.jsp").forward(req, resp);
	}

}
