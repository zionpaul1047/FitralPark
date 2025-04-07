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
import fitralpark.user.dto.UserDTO;

@WebServlet("/bulletinWriteOK.do")
public class BulletinWriterOK extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		//AddOk.java	
		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
		
		String post_subject = req.getParameter("post_subject");
		String post_content = req.getParameter("post_content");
		String header_no = req.getParameter("header_no");
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO communityDto = new CommunityDTO();
		communityDto.setHeader_no(header_no);
		communityDto.setPost_subject(post_subject);
		communityDto.setPost_content(post_content);
		
		
		int result = dao.Bulletin_post_add(communityDto, userDto);
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










