package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//공지사항 조회 및 상세 컨트롤러
@WebServlet("/announcementList.do")
public class AnnouncementController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//AnnouncementController
		

		req.getRequestDispatcher("/WEB-INF/views/community/announcementList.jsp").forward(req, resp);
	}

}