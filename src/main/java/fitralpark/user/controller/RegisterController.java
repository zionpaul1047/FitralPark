package fitralpark.user.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register.do")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 팝업에서 전달된 name, email 값 가져오기
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // register.jsp로 전달
        request.setAttribute("name", name);
        request.setAttribute("email", email);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 실제 회원가입 처리 로직 작성 예정 (DB 저장 등)
    }
}
