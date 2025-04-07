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
		String id = req.getParameter("id");
		String email = req.getParameter("email");

		UserDAO dao = new UserDAO();
		boolean isMatched = dao.checkUserByIdAndEmail(id, email);

		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = resp.getWriter();

		if (isMatched) {
			String authCode = String.format("%06d", new Random().nextInt(1000000));

			HttpSession session = req.getSession();
			session.setAttribute("pwFindAuthCode", authCode);
			session.setAttribute("pwFindUserId", id);

			// 1. 이메일 전송
			String subject = "[👟FitralPark🌳] 비밀번호 찾기 인증번호입니다.";
			String content = "요청하신 인증번호는 [" + authCode + "] 입니다. 5분 내에 입력해주세요.";

			boolean emailSent = MailUtil.sendMail(email, subject, content);

			// 2. 결과 처리
			if (emailSent) {
				out.write(
						"<script>alert('인증번호가 이메일로 전송되었습니다.'); window.location.href='auth.jsp?show=reset-pw';</script>");
			} else {
				out.write("<script>alert('이메일 전송에 실패했습니다. 관리자에게 문의하세요.'); history.back();</script>");
			}
		} else {
			out.write("<script>alert('일치하는 회원 정보가 없습니다.'); history.back();</script>");
		}
	}
}