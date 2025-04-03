package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bulletinPostDel.do")
public class BulletinPostDel extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//BulletinPostDel
		

		req.getRequestDispatcher("/WEB-INF/views/bulletinPostDel.jsp").forward(req, resp);
	}

}
