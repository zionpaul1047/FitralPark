package fitralpark.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.DashCurrentDietDTO;
import fitralpark.user.dto.DashCurrentExcsDTO;
import fitralpark.user.dto.DashDTO;
import fitralpark.user.dto.DashTodayDietDTO;
import fitralpark.user.dto.DashTodayExerciseDTO;
import fitralpark.user.dto.DashTodayIntakeDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/dashboard.do")
public class DashBoardController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		if(req.getSession().getAttribute("loginUser") == null) {
			resp.sendRedirect("/fitralpark/index.do");
		} else {
			
			UserDTO userdto = (UserDTO)(req.getSession().getAttribute("loginUser"));
			String id = userdto.getMemberId();
			String rank = userdto.getRank();
			
			//세션값 임시
//			String id = "hong";
//			String rank = "junior";
			String mentor_check = "0";
			
			UserDTO userDto = new UserDTO();
			userDto.setMemberId(id);
			
			//DashBoardController.java
			UserDAO dao = new UserDAO();
			
			
			DashDTO dto = dao.getDashInfo(userDto);
			
			dao.close();
			
			System.out.println(dto);
			
			
			req.setAttribute("dto", dto);
			req.setAttribute("rank", rank);
			req.setAttribute("mentor_check", mentor_check);
			req.setAttribute("id", id);
			

			req.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(req, resp);
		}
		

	}

}
