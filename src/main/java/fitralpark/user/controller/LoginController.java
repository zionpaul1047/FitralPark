package fitralpark.user.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        // 간단한 로그인 예시 (실제 프로젝트에서는 DB와 연동 필요)
        if ("admin".equals(username) && "1234".equals(password)) {
            request.getSession().setAttribute("loginUser", username);
            response.getWriter().println("<script>alert('로그인 성공!'); window.opener.location.href='/index.do'; window.close();</script>");
        } else {
            response.getWriter().println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
        }
    }
}