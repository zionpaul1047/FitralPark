package fitralpark.user.controller;

import fitralpark.common.utils.MailUtil;
import fitralpark.user.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
/**
 * 비밀번호 재설정을 위한 인증번호 이메일 전송을 처리하는 서블릿입니다.
 * <p>
 * 전달받은 아이디와 이메일 정보가 일치하는 회원이 존재할 경우,
 * 인증번호를 생성하여 세션에 저장하고 해당 이메일로 인증번호를 전송합니다.
 * 결과는 JSON 형식으로 반환됩니다.
 * </p>
 *
 * URL: {@code /find-pw.do}
 *
 * 예시 응답:
 * <ul>
 *   <li>{@code {"success": true}} : 이메일 전송 성공</li>
 *   <li>{@code {"success": false}} : 회원 정보 불일치 또는 이메일 전송 실패</li>
 * </ul>
 * 
 * @author 이지온
 */
@WebServlet("/find-pw.do")
public class FindPwController extends HttpServlet {

    /**
     * 아이디와 이메일 정보를 확인한 후 인증번호를 생성하여 이메일로 전송하고,
     * 인증번호와 사용자 ID를 세션에 저장합니다.
     * 결과는 JSON 형식으로 클라이언트에 응답됩니다.
     *
     * @param req 클라이언트의 HTTP POST 요청 (파라미터: {@code id}, {@code email})
     * @param resp 이메일 전송 결과를 포함한 JSON 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
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
