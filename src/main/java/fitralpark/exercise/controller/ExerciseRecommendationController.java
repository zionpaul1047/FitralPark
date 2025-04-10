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

/**
 * 클래스 설명: 루틴 추천 페이지의 루틴 목록을 보여주는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
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
