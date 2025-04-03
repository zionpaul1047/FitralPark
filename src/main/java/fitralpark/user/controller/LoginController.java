package fitralpark.user.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

import java.io.IOException;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// auth.jsp로 포워딩
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/auth.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// DB에서 로그인 정보 확인
		UserDAO dao = new UserDAO();
		UserDTO loginUser = dao.login(username, password); // login() 메서드는 UserDAO에 작성 필요

		response.setContentType("text/html;charset=UTF-8");

		if (loginUser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser);

			String redirect = (String) session.getAttribute("redirectAfterLogin");
			if (redirect == null || redirect.isEmpty()) {
				redirect = "/index.do";
			} else {
				session.removeAttribute("redirectAfterLogin");
			}

			response.getWriter()
				.println("<script>"
					+ "alert('로그인 성공!');"
					+ "window.opener.location.href='" + request.getContextPath() + redirect + "';"
					+ "window.opener.document.getElementById('overlay').style.display = 'none';"
					+ "window.close();"
					+ "</script>");
		} else {
			// 로그인 실패
			response.getWriter()
					.println("<script>" + "alert('아이디 또는 비밀번호가 일치하지 않습니다.');" + "history.back();" + "</script>");
		}
	}

}