package fitralpark.comunity.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
		UserDTO UserDto = (UserDTO) session.getAttribute("loginUser");
		
		String post_no = req.getParameter("post_no");
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO communitydto = dao.getPost(post_no, req.getSession());
		
		if (!UserDto.getMemberId().equals(communitydto.getCreator_id())) {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('삭제 권한이 없습니다.');");
			out.println("window.close();");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		    return;
		}
		
		req.setAttribute("post", communitydto);
	
		dao.close();

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinPostDel.jsp").forward(req, resp);
	}

}
