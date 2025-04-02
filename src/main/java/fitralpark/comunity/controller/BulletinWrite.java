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

		
		if (null != session.getAttribute("loginUser")) {
			
		} else {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
		
		// 말머리 조회하기
		ArrayList<CommunityDTO> headerList = dao.getHeaderList();
		
		// 말머리 불러오기
		req.setAttribute("headerList", headerList);
		
		// DAO 연결 해제
		dao.close();

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinWrite.jsp").forward(req, resp);
	}

}