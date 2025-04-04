package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/bulletinPostDel.do")
public class BulletinPostDel extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPostDel
		
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
		    resp.sendRedirect(req.getContextPath() + "/community/bulletinList.do");  // 권한 없으면 목록으로 이동
		    return;
		}
		
		req.setAttribute("post", communitydto);
	
		dao.close();

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinPostDel.jsp").forward(req, resp);
	}

}
