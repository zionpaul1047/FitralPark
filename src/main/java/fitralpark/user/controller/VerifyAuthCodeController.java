// 파일명: VerifyAuthCodeController.java
package fitralpark.user.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * 세션에 저장된 인증번호와 사용자가 입력한 인증번호를 비교하여 검증하는 서블릿입니다.
 * <p>
 * 비밀번호 재설정 또는 회원가입 인증 절차 중,
 * 사용자가 입력한 인증번호({@code authCode})가 세션에 저장된 인증번호({@code pwAuthCode})와 일치하는지 확인합니다.
 * </p>
 *
 * URL: {@code /verify-auth-code.do}  
 * 요청 방식: {@code POST}  
 * 응답 형식: {@code application/json}
 *
 * <ul>
 *   <li>{@code {"result": "OK"}}: 인증번호 일치</li>
 *   <li>{@code {"result": "FAIL"}}: 인증번호 불일치</li>
 *   <li>{@code {"result": "FAIL", "error": "no-session"}}: 세션 없음</li>
 *   <li>{@code {"result": "ERROR"}}: 처리 중 예외 발생</li>
 * </ul>
 * 
 * @author 이지온
 */
@WebServlet("/verify-auth-code.do")
public class VerifyAuthCodeController extends HttpServlet {

    /**
     * 클라이언트로부터 받은 인증번호를 세션에 저장된 인증번호와 비교합니다.
     * <p>
     * 세션이 없거나, 인증번호가 일치하지 않으면 {@code FAIL}, 일치하면 {@code OK}를 JSON으로 반환합니다.
     * </p>
     *
     * @param req 인증번호를 포함한 HTTP POST 요청 ({@code authCode} 파라미터)
     * @param resp JSON 형식의 인증 결과 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
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