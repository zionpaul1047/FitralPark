package fitralpark.comunity.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/bulletinPostOK.do")
public class BulletinPostOK extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // PostOK
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
    	
		HttpSession session = req.getSession();
		UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
		
		if (userDto == null) {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
        
		

       
    }
}