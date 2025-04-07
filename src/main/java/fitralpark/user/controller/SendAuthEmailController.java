package fitralpark.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.common.utils.MailUtil;

@WebServlet("/sendAuthEmail.do")
public class SendAuthEmailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 이메일 파라미터 받기
        String email = req.getParameter("email");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();

        if (email == null || email.trim().isEmpty()) {
            out.print("{\"success\": false}");
            return;
        }

        // 2. 인증번호 생성
        String code = String.valueOf(new Random().nextInt(900000) + 100000);
        HttpSession session = req.getSession();
        session.setAttribute("emailAuthCode", code);
        session.setAttribute("emailAuthTime", System.currentTimeMillis());

        // 3. 이메일 전송
        String subject = "[👟FitralPark🌳] 이메일 인증번호입니다.";
        String content = "인증번호는 [" + code + "] 입니다. 5분 내로 입력해주세요.";

        boolean sendSuccess = MailUtil.sendMail(email, subject, content);

        // 4. 응답 처리
        out.print("{\"success\": " + sendSuccess + "}");
    }
}
