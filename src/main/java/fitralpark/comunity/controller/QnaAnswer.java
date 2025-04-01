package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/qnaAnswer.do")
public class QnaAnswer extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String auth = (String) session.getAttribute("auth");
		if (auth != null) {
			req.setAttribute("auth", auth);
		} else {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}

		
		req.getRequestDispatcher("/WEB-INF/views/community/qnaAnswer.jsp").forward(req, resp);
	}
}