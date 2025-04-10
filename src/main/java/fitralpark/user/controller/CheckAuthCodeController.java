package fitralpark.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 이메일 인증번호 검증을 처리하는 서블릿입니다.
 * <p>
 * 사용자가 입력한 인증번호와 세션에 저장된 인증번호 및 유효 시간(5분 이내)을 비교하여
 * 일치 여부를 JSON 형태로 반환합니다.
 * </p>
 * 
 * URL: {@code /checkAuthCode.do}
 * 
 * 응답 예시: {@code {"match": true}} 또는 {@code {"match": false}}
 * 
 * @author 이지온
 */
@WebServlet("/checkAuthCode.do")
public class CheckAuthCodeController extends HttpServlet {
    /**
     * 클라이언트로부터 전송된 인증번호를 세션에 저장된 인증번호와 비교하여
     * 일치 여부를 JSON으로 응답합니다.
     * <p>
     * 인증번호는 5분 이내 유효하며, 시간 초과 시 자동으로 실패 처리됩니다.
     * </p>
     *
     * @param req 클라이언트의 HTTP POST 요청
     * @param resp JSON 형식으로 인증 결과를 반환하는 HTTP 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String inputCode = req.getParameter("code");
        HttpSession session = req.getSession();

        String savedCode = (String) session.getAttribute("emailAuthCode");
        Long savedTime = (Long) session.getAttribute("emailAuthTime");
        long currentTime = System.currentTimeMillis();

        boolean match = false;

        if (savedCode != null && savedTime != null) {
            if ((currentTime - savedTime) <= 5 * 60 * 1000 && savedCode.equals(inputCode)) {
                match = true;
            }
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().print("{\"match\": " + match + "}");
    }
}

