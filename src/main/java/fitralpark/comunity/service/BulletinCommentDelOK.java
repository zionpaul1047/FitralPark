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

		//BulletinPostDelOK
		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
	
		
        String comment_no = req.getParameter("comment_no");  // 요청에서 comment_no 가져오기
        String comment_creator_id = req.getParameter("comment_creator_id");

        if (!comment_creator_id.equals(userDto.getMemberId())) {
        	resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('수정 권한이 없습니다.');");
			out.println("window.close();");
			out.println("</script>");
			out.close();
            return;
        }

        CommunityDAO dao = new CommunityDAO(); // DAO 객체 생성

        try {
            dao.bulletin_Del_Comment(comment_no);
            resp.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("error");
        } finally {
            dao.close();
        }
        
        resp.sendRedirect("/fitralpark/bulletinList.do");
        
	}

}
