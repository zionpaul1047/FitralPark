package fitralpark.comunity.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

/**
	자유 게시글 작성 페이지 서블릿 클래스입니다.
	
	@author 김형년
   	@since 2025.04.10
*/
@WebServlet("/bulletinPostWrite.do")
public class BulletinPostWrite extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		//AddOk.java	
		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
		
		if (userDto == null) {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
		
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO communityDto = new CommunityDTO();
		
		// 말머리 조회하기
		ArrayList<CommunityDTO> headerList = dao.getHeaderList();
		
		// 말머리 불러오기
		req.setAttribute("headerList", headerList);
			
		
		
		// DAO 연결 해제
		dao.close();

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinPostWrite.jsp").forward(req, resp);
	}

}