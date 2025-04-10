package fitralpark.user.controller;

import fitralpark.user.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * 인증번호 검증 후 비밀번호를 재설정하는 서블릿입니다.
 * <p>
 * 사용자가 입력한 인증번호와 세션에 저장된 인증번호를 비교하여 일치할 경우,
 * 새 비밀번호를 DB에 반영합니다. 처리 결과는 alert 창을 통해 사용자에게 안내됩니다.
 * </p>
 *
 * URL: {@code /reset-pw.do}
 * 요청 방식: {@code POST}
 * 
 * <p><b>세션 사용 키:</b> {@code pwAuthCode}, {@code pwResetUserId}</p>
 *
 * @author 이지온
 */
@WebServlet("/reset-pw.do")
public class ResetPwController extends HttpServlet {

    /**
     * 비밀번호 재설정 요청을 처리합니다.
     * <p>
     * 세션에 저장된 인증번호 및 사용자 ID와 클라이언트가 입력한 값을 비교하여 검증 후,
     * 비밀번호를 업데이트합니다. 성공 시 세션을 정리하고 로그인 페이지로 이동시킵니다.
     * </p>
     *
     * @param req HTTP POST 요청 (파라미터: {@code authCode}, {@code newPassword}, {@code confirmPassword})
     * @param resp 처리 결과에 따른 JavaScript 기반 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession();

        // 세션에서 정보 꺼내기
        String sessionAuthCode = (String) session.getAttribute("pwAuthCode");
        String sessionUserId = (String) session.getAttribute("pwResetUserId");

        // 사용자가 입력한 값
        String inputCode = req.getParameter("authCode");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // 검증
        if (sessionAuthCode == null || sessionUserId == null) {
            out.write("<script>alert('세션이 만료되었거나 잘못된 접근입니다.'); window.location.href='auth.jsp?show=find-pw';</script>");
            return;
        }

        if (!sessionAuthCode.equals(inputCode)) {
            out.write("<script>alert('인증번호가 일치하지 않습니다.'); history.back();</script>");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            out.write("<script>alert('비밀번호 확인이 일치하지 않습니다.'); history.back();</script>");
            return;
        }

        // 비밀번호 변경
        UserDAO dao = new UserDAO();
        int result = dao.updatePassword(sessionUserId, newPassword); // DAO에 메서드 있어야 함

        if (result > 0) {
            // 세션 정리
            session.removeAttribute("pwAuthCode");
            session.removeAttribute("pwResetUserId");

            out.write("<script>alert('비밀번호가 성공적으로 변경되었습니다.'); window.location.href='auth.jsp?show=login';</script>");
        } else {
            out.write("<script>alert('비밀번호 변경에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    }
}
