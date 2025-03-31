package fitralpark.user.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register.do")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 1. 입력값 받기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String jumin1 = request.getParameter("jumin1");
		String jumin2_first = request.getParameter("jumin2_first");
		String jumin2_rest = request.getParameter("jumin2_rest");
		String nickname = request.getParameter("nickname");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String customPhone = request.getParameter("custom_phone");
		String emailPrefix = request.getParameter("email_prefix");
		String emailDomain = request.getParameter("email_domain");
		String emailDomainCustom = request.getParameter("email_domain_custom");
		String zipcode = request.getParameter("zipcode");
		String address = request.getParameter("address");
		String addressDetail = request.getParameter("address_detail");

		// 2. 유효성 검증(선택적으로 로그 찍기)
		System.out.println("회원가입 요청 ID: " + id);
		System.out.println("닉네임: " + nickname);

		// 3. 이메일 도메인 처리
		String finalEmail = emailDomain.equals("etc") ? emailDomainCustom : emailDomain;
		String email = emailPrefix + "@" + finalEmail;

		// 4. 연락처 처리
		String phone = customPhone != null && !customPhone.isEmpty()
				? customPhone
				: phone1 + "-" + phone2 + "-" + phone3;

		// 5. 주민등록번호 전체
		String jumin = jumin1 + "-" + jumin2_first + jumin2_rest;

		// 6. (임시 처리) DB 저장 없이 완료 메시지
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println("<script>alert('회원가입 정보가 정상적으로 전달되었습니다.'); window.opener.location.href='/index.do'; window.close();</script>");
	}
}
