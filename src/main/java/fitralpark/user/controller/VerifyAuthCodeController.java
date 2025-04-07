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
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            String inputCode = req.getParameter("authCode");
            HttpSession session = req.getSession(false); // 세션 없으면 null

            if (session == null) {
                System.err.println("[VerifyAuthCode] 세션이 존재하지 않습니다.");
                resp.getWriter().write("{\"result\":\"FAIL\", \"error\": \"no-session\"}");
                return;
            }

            String savedCode = (String) session.getAttribute("pwAuthCode");

            System.out.println("[VerifyAuthCode] 입력된 코드: " + inputCode);
            System.out.println("[VerifyAuthCode] 세션 저장 코드: " + savedCode);

            boolean isMatch = savedCode != null && savedCode.equals(inputCode);

            PrintWriter out = resp.getWriter();
            out.write("{\"result\": \"" + (isMatch ? "OK" : "FAIL") + "\"}");
            out.flush();
        } catch (Exception e) {
            System.err.println("[VerifyAuthCode] 예외 발생:");
            e.printStackTrace();

            PrintWriter out = resp.getWriter();
            out.write("{\"result\": \"ERROR\"}");
            out.flush();
        }
    }
}