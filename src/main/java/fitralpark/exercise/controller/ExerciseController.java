package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 클래스 설명: 운동 목록을 보여주는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
//운동 기록, 운동 라이브러리 관련 컨트롤러
@WebServlet("/exerciseList.do")
public class ExerciseController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//ExerciseController.java
		

		req.getRequestDispatcher("/WEB-INF/views/exercise/exerciseList.jsp").forward(req, resp);
	}

}
