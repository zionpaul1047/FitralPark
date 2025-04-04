package fitralpark.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/mdfyuserinfo.do")
public class MdfyUserInfoController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//MdfyUserInfoController.java
		String id = ((UserDTO)(req.getSession().getAttribute("loginUser"))).getMemberId();
		
		UserDAO dao = new UserDAO();
		
		UserDTO dto = dao.getUserInfo(id);
		dao.close();
		
		req.setAttribute("userInfo", dto);
		
		
		

		req.getRequestDispatcher("/WEB-INF/views/user/mdfyuserinfo.jsp").forward(req, resp);

	}

}