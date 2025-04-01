package fitralpark.comunity.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;

@WebServlet("/bulletinWrite.do")
public class BulletinWrite extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		CommunityDAO dao = new CommunityDAO();
		HttpSession session = req.getSession();
		String auth = (String) session.getAttribute("auth");
		
		if (auth != null) {
			req.setAttribute("auth", auth);
		} else {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
		
		// 헤더 조회하기
		ArrayList<CommunityDTO> headerList = dao.getHeaderList();
		
		// 헤더 불러오기
		req.setAttribute("headerList", headerList);
		
		
		req.getRequestDispatcher("/WEB-INF/views/community/bulletinWrite.jsp").forward(req, resp);
	}

}