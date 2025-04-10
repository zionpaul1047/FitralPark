package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 클래스 설명: 지도에 피트니스 정보를 제공해주는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
@WebServlet("/exercise/fitnessmap.do")
public class FitnessMap extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//FitnessMap.java
		

		req.getRequestDispatcher("/WEB-INF/views/exercise/fitnessmap.jsp").forward(req, resp);
	}

}

