
package fitralpark.comunity.service;

import java.io.IOException;

import javax.servlet.ServletException;
import
javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import
javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.user.dto.UserDTO;

/**
	자유 게시글 삭제 수행을 위한 서블릿 클래스입니다.
*/
@WebServlet("/bulletinPostDelOK.do") 
public class BulletinPostDelOK extends HttpServlet {

	@Override 
	protected void doPost(HttpServletRequest req, HttpServletResponse
	resp) throws ServletException, IOException {
		
	req.setCharacterEncoding("UTF-8");
	resp.setContentType("text/html; charset=UTF-8");

	HttpSession session = req.getSession(); 
	UserDTO userDto = (UserDTO) session.getAttribute("loginUser");

	if (userDto == null) { 
		resp.sendRedirect(req.getContextPath() + "/login.do");
		return; }

		String post_no = req.getParameter("post_no"); // 요청에서 post_no 가져오기 
		String creator_id = req.getParameter("creator_id");

	if (!creator_id.equals(userDto.getMemberId())) {
	resp.getWriter().write("fail"); return; }

	CommunityDAO dao = new CommunityDAO(); // DAO 객체 생성

		try { 
			dao.bulletin_Del_Post(post_no); 
			resp.getWriter().write("success"); }
		catch (Exception e) { 
			e.printStackTrace(); 
			resp.getWriter().write("error"); }
		finally { dao.close(); }

		resp.sendRedirect("/fitralpark/bulletinList.do");

}

}