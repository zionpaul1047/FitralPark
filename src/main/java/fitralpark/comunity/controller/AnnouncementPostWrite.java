package fitralpark.comunity.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/announcementPostWrite.do")
public class AnnouncementPostWrite extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
		
		if (userDto == null) {
			resp.sendRedirect("/fitralpark/login.do");
			return;
		}
		
        if (userDto.getAdminCheck() != 1) {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println("<script>");
	        out.println("alert('게시글을 작성할 권한이 없습니다.');");
	        out.println("history.back();");
	        out.println("</script>");
	        out.close();
	        return;
        }
		
		
		CommunityDAO dao = new CommunityDAO();
		
		try {
			ArrayList<CommunityDTO> hlist = dao.getAnnouncementHeaderList();
			req.setAttribute("hlist", hlist);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.close();
		}
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/community/announcementWrite.jsp");
		dispatcher.forward(req, resp);
	}

}