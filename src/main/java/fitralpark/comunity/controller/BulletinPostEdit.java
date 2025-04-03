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
import fitralpark.user.dto.UserDTO;

@WebServlet("/bulletinPostEdit.do")
public class BulletinPostEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPost
		HttpSession session = req.getSession();
		UserDTO dto = (UserDTO) session.getAttribute("loginUser");
		
		
		if (dto == null) {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
		
		String post_no = req.getParameter("post_no");
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO communitydto = dao.getPost(post_no);
		
		if (!dto.getMemberId().equals(communitydto.getCreator_id())) {
		    resp.sendRedirect(req.getContextPath() + "/community/bulletinList.do");
		    return;
		}
		
		// 댓글 목록, 말머리 조회
		ArrayList<CommunityDTO> list = dao.Bulletin_Comment_list(post_no);
		ArrayList<CommunityDTO> headerList = dao.getHeaderList();
		
		// 불러오기
		req.setAttribute("headerList", headerList);
		req.setAttribute("post", communitydto);
		
		//세션에 정보 저장
		session.setAttribute("dto", communitydto);
		
		dao.close();
		
		req.getRequestDispatcher("/WEB-INF/views/community/bulletinPostEdit.jsp").forward(req, resp);
	}

}
