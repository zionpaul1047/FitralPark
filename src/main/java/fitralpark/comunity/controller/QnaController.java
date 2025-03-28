package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Q&A 게시판 관련 컨트롤러
@WebServlet("/qnaList.do")
public class QnaController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//QnaController
		

		req.getRequestDispatcher("/WEB-INF/views/community/qnaList.jsp").forward(req, resp);
	}

}