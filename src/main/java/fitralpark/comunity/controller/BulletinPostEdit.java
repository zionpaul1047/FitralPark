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

@WebServlet("/bulletinPostEdit.do")
public class BulletinPostEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPost
		HttpSession session = req.getSession();
		
		if (null != session.getAttribute("loginUser")) {
					
		} else {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
		
		String post_no = req.getParameter("post_no");
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO dto = dao.getPost(post_no);
		
		// 댓글 목록, 말머리 조회
		ArrayList<CommunityDTO> list = dao.Bulletin_Comment_list(post_no);
		ArrayList<CommunityDTO> headerList = dao.getHeaderList();
		
		// 불러오기
		req.setAttribute("headerList", headerList);
		req.setAttribute("Comment_list", list);
		req.setAttribute("post", dto);
		
		dao.close();
		
		req.getRequestDispatcher("/WEB-INF/views/community/bulletinPostEdit.jsp").forward(req, resp);
	}

}
