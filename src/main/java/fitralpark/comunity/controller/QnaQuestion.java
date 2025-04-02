package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/qnaQuestion.do")
public class QnaQuestion extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		
		String loginUser = (String) session.getAttribute("loginUser");
		if (loginUser != null) {
			req.setAttribute("loginUser", loginUser);
		} else {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}

		req.getRequestDispatcher("/WEB-INF/views/community/qnaQuestion.jsp").forward(req, resp);
	}

}