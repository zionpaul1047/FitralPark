package fitralpark.user.controller;

import fitralpark.user.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/reset-pw.do")
public class ResetPwController extends HttpServlet {

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
