package fitralpark.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//로그인, 로그아웃, 회원가입, 비밀번호/아이디 찾기 컨트롤러
@WebServlet("/login.do")
public class AuthController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//index.java
		

		req.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(req, resp);
	}

}
