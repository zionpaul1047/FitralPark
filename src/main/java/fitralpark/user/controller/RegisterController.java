package fitralpark.user.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

import java.io.IOException;

@WebServlet("/register.do")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		System.out.println("[DEBUG] RegisterController 호출됨");

		// 1. 입력값 받아오기
		String id = nvl(request.getParameter("id"));
		String pw = nvl(request.getParameter("password"));
		String name = nvl(request.getParameter("name"));

		String jumin1 = nvl(request.getParameter("jumin1"));
		String jumin2_first = nvl(request.getParameter("jumin2_first"));
		String jumin2_rest = nvl(request.getParameter("jumin2_rest"));
		String jumin = request.getParameter("jumin1")
	            + request.getParameter("jumin2_first")
	            + request.getParameter("jumin2_rest");


		String nickname = nvl(request.getParameter("nickname"));

		String customPhone = request.getParameter("custom_phone");
		String tel;
		if (customPhone != null && !customPhone.trim().isEmpty()) {
			tel = customPhone;
		} else {
			tel = nvl(request.getParameter("phone1")) + "-" +
				  nvl(request.getParameter("phone2")) + "-" +
				  nvl(request.getParameter("phone3"));
		}

		String emailDomain = nvl(request.getParameter("email_domain"));
		String emailCustomDomain = nvl(request.getParameter("email_domain_custom"));
		String emailPrefix = nvl(request.getParameter("email_prefix"));

		String domain = "etc".equals(emailDomain) ? emailCustomDomain : emailDomain;
		String email = emailPrefix + "@" + domain;

		String zipcode = nvl(request.getParameter("zipcode"));
		String addressBasic = nvl(request.getParameter("address"));
		String addressDetail = nvl(request.getParameter("address_detail"));
		String address = zipcode + " " + addressBasic + " " + addressDetail;

		// 2. DTO에 담기
		UserDTO dto = new UserDTO();
		dto.setMemberId(id);
		dto.setPw(pw);
		dto.setMemberName(name);
		dto.setMemberNickname(nickname);
		dto.setPersonalNumber(jumin);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setAddress(address);

		dto.setMemberPic(null); // 프로필 사진 추후 구현
		dto.setBackgroundPic(null);
		dto.setAllergy(null);

		// 3. DB 저장
		UserDAO dao = new UserDAO();
		int result = dao.insertMember(dto);

		// 4. 결과 처리
		response.setContentType("text/html; charset=UTF-8");
		if (result > 0) {
			response.getWriter().println(
					"<script>alert('회원가입 성공!'); window.opener.location.href='/index.do'; window.close();</script>");
		} else {
			response.getWriter().println("<script>alert('회원가입 실패!'); history.back();</script>");
		}
	}

	// 널 방지 헬퍼 메소드
	private String nvl(String str) {
		return str == null ? "" : str.trim();
	}
}
