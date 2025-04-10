package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 클래스 설명: 루틴 생성 페이지를 나타내는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
@WebServlet("/exercise/routineAdd.do")
public class RoutineAdd extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//RoutineAdd.java
			

		req.getRequestDispatcher("/WEB-INF/views/exercise/routineAdd.jsp").forward(req, resp);
	}

}
