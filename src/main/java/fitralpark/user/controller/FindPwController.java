package fitralpark.user.controller;

import fitralpark.common.utils.MailUtil;
import fitralpark.user.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

@WebServlet("/find-pw.do")
public class FindPwController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json"); // JSON 응답
        resp.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String email = req.getParameter("email");

        UserDAO dao = new UserDAO();
        boolean isMatched = dao.checkUserByIdAndEmail(id, email);

        PrintWriter out = resp.getWriter();

        if (isMatched) {
            String authCode = String.format("%06d", new Random().nextInt(1000000));

            HttpSession session = req.getSession();
            session.setAttribute("pwAuthCode", authCode);
            session.setAttribute("pwResetUserId", id);

            // 이메일 전송
            String subject = "[👟FitralPark🌳] 비밀번호 찾기 인증번호입니다.";
            String content = "요청하신 인증번호는 [" + authCode + "] 입니다. 5분 내에 입력해주세요.";

            boolean emailSent = MailUtil.sendMail(email, subject, content);

            // JSON 응답
            out.write("{\"success\": " + emailSent + "}");
        } else {
            out.write("{\"success\": false}");
        }

        out.flush();
    }
}
