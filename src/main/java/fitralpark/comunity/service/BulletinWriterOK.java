package fitralpark.comunity.service;
//(비즈니스 로직 서비스 클래스 자리)

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

@WebServlet("/writeok.do")
public class BulletinWriterOK extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//AddOk.java	
		HttpSession session = req.getSession();
		
//		req.setCharacterEncoding("UTF-8");
		
		String post_subject = req.getParameter("post_subject");
		String post_content = req.getParameter("post_content");
		
		CommunityDTO dto = new CommunityDTO();
		dto.setPost_subject(post_subject);
		dto.setPost_content(post_content);
		dto.setCreator_id(session.getAttribute("auth").toString());
		
		CommunityDAO dao = new CommunityDAO();
		int result = dao.Bulletin_add(dto);
		dao.close();
		
		if (result == 1) {
			resp.sendRedirect("/fitralpark/community/Bulletinlist.do");
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










