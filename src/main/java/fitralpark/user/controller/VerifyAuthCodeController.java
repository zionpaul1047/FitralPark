// 파일명: VerifyAuthCodeController.java
package fitralpark.user.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/verify-auth-code.do")
public class VerifyAuthCodeController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String inputCode = req.getParameter("authCode");
        HttpSession session = req.getSession();
        String sessionCode = (String) session.getAttribute("authCode");

        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            out.write("{\"success\": true}");
        } else {
            out.write("{\"success\": false, \"message\": \"인증번호가 일치하지 않습니다.\"}");
        }
    }
}
