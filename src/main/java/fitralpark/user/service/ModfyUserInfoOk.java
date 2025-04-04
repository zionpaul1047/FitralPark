package fitralpark.user.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/user/modfyuserinfook.do")
public class ModfyUserInfoOk extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//ModfyUserInfoOk.java
		

		//req.getRequestDispatcher("/WEB-INF/views/user/modfyuserinfook.jsp").forward(req, resp);

	}

}