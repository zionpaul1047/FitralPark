package fitralpark.comunity.service;

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

@WebServlet("/bulletinCommentDelOK.do")
public class BulletinCommentDelOK extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO)session.getAttribute("loginUser");
		
		if (userDto == null) {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
		
		String comment_no = req.getParameter("comment_no");
		String comment_creator_id = req.getParameter("comment_creator_id");
		String post_no = req.getParameter("post_no");
		
		// 권한 확인
		if (!userDto.getMemberId().equals(comment_creator_id)) {
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('댓글을 삭제할 권한이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return;
		}
		
		CommunityDAO dao = new CommunityDAO();
		
		try {
			boolean success = dao.bulletin_Del_Comment(comment_no);
			
			if (success) {
				resp.sendRedirect("/fitralpark/bulletinPost.do?post_no=" + post_no);
			} else {
				PrintWriter out = resp.getWriter();
				out.println("<script>");
				out.println("alert('댓글 삭제에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('댓글 삭제 중 오류가 발생했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} finally {
			dao.close();
		}
	}

}
