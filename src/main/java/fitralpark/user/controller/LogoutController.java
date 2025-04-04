package fitralpark.user.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout.do")
public class LogoutController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // 기존 세션만 가져옴
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }

        response.sendRedirect(request.getContextPath() + "/index.do"); // 메인페이지로 이동
    }
}
