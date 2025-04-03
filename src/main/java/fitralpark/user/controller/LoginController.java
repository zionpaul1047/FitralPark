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
import java.io.PrintWriter;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 기본 로그인 페이지 (직접 접근 시 auth.jsp로 포워딩)
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
        UserDTO loginUser = dao.login(username, password);  // UserDAO에 정의된 login 메서드 사용

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (loginUser != null) {
            // 로그인 성공 → 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser);

            // 팝업에서 로그인한 경우 → 부모창 새로고침 & 팝업 닫기
            out.println("<script>");
            out.println("alert('로그인 성공!');");
            out.println("if (window.opener) { window.opener.location.reload(); window.close(); }");
            out.println("</script>");
        } else {
            // 로그인 실패
            out.println("<script>");
            out.println("alert('아이디 또는 비밀번호가 올바르지 않습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    }
}
