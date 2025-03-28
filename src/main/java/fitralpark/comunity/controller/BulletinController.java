package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//커뮤니티 자유게시판 관련 컨트롤러
@WebServlet("/bulletinList.do")
public class BulletinController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BoardController
		

		req.getRequestDispatcher("/WEB-INF/views/bulletinList.jsp").forward(req, resp);
	}

}