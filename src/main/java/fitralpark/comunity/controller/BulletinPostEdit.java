package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bulletinpostEdit.do")
public class BulletinPostEdit extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPostEdit
		

		req.getRequestDispatcher("/WEB-INF/views/community/bulletinEdit.jsp").forward(req, resp);
	}

}