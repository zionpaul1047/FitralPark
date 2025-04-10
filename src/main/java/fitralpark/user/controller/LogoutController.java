package fitralpark.user.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
/**
 * 사용자 로그아웃 처리를 담당하는 서블릿입니다.
 * <p>
 * 현재 활성화된 세션을 무효화하고, 로그아웃 후 메인 페이지로 리다이렉트합니다.
 * </p>
 *
 * URL: {@code /logout.do}
 * 
 * 요청 방식: {@code POST}
 * 
 * <p><b>주의:</b> 세션이 없는 경우에도 에러 없이 안전하게 처리됩니다.</p>
 * 
 * @author 이지온
 */
@WebServlet("/logout.do")
public class LogoutController extends HttpServlet {
    /**
     * 로그아웃 요청을 처리합니다.
     * <p>
     * 기존 세션을 가져와 무효화한 뒤, 메인 페이지({@code /index.do})로 리다이렉트합니다.
     * </p>
     *
     * @param request 클라이언트의 HTTP POST 요청
     * @param response 메인 페이지로 리다이렉트되는 HTTP 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
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
