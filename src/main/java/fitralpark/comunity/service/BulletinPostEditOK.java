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

@WebServlet("/bulletinPostEditOK.do")
public class BulletinPostEditOK extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		
		//BulletinPostEditOK
		String header_no = req.getParameter("header_no");
		String post_subject = req.getParameter("post_subject");
		String post_content = req.getParameter("post_content");
		String post_no = req.getParameter("post_no");
		
		CommunityDTO dto = new CommunityDTO();
		dto.setHeader_no(header_no);
		dto.setPost_subject(post_subject);
		dto.setPost_content(post_content);
		dto.setPost_no(post_no);
		
		CommunityDAO dao = new CommunityDAO();
		int result = dao.Bulletin_edit(dto);
		
		dao.close();
		
		if (result == 1) {
			resp.sendRedirect("/fitralpark/bulletinList.do");
		} else {
			PrintWriter writer = resp.getWriter();
			writer.print("""
					<script>
						alert('failed');
						history.back();
					</script>
					""");
			writer.close();
		}
		
		
	}

}