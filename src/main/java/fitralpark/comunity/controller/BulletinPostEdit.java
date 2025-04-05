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

@WebServlet("/bulletinPostEdit.do")
public class BulletinPostEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPost
		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
		
		
		
		String post_no = req.getParameter("post_no");
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO communitydto = dao.getPost(post_no, req.getSession());
		
		if (!userDto.getMemberId().equals(communitydto.getCreator_id())) {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('수정 권한이 없습니다.');");
			out.println("window.close();");
	        out.println("history.back();");
			out.println("</script>");
			out.close();
		    return;
		}
		
		// 말머리 조회
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
