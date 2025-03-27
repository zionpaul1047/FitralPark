package fitralpark.user.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class Login extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 간단한 로그인 예시 (DB 연동 시 여기에서 처리)
        if ("test@naver.com".equals(email) && "1234".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);
            response.sendRedirect("main.jsp"); // 로그인 성공 시 이동할 페이지
        } else {
            request.setAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
