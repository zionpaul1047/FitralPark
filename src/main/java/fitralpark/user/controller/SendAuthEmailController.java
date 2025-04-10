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
/**
 * 이메일 인증번호를 발송하는 서블릿입니다.
 * <p>
 * 클라이언트로부터 이메일 주소를 전달받아 6자리 인증번호를 생성한 후,
 * 해당 이메일로 인증번호를 전송하고 세션에 인증번호 및 발송 시간을 저장합니다.
 * 응답은 JSON 형식으로 이메일 발송 성공 여부를 반환합니다.
 * </p>
 *
 * URL: {@code /sendAuthEmail.do}
 * 요청 방식: {@code GET}
 * 응답 형식: {@code {"success": true}} 또는 {@code {"success": false}}
 *
 * <p><b>세션 저장 값:</b> {@code emailAuthCode}, {@code emailAuthTime}</p>
 * 
 * @author 이지온
 */
@WebServlet("/sendAuthEmail.do")
public class SendAuthEmailController extends HttpServlet {

    /**
     * 이메일 인증 요청을 처리합니다.
     * <p>
     * 이메일 파라미터가 유효한 경우 6자리 인증번호를 생성하여 메일로 전송하고,
     * 인증번호와 전송 시각을 세션에 저장합니다.
     * </p>
     *
     * @param req 이메일 주소를 포함한 HTTP GET 요청 (파라미터: {@code email})
     * @param resp 인증번호 발송 성공 여부를 나타내는 JSON 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
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
