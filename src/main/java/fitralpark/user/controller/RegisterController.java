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

		// 1. 입력값 받아오기
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String name = request.getParameter("name");
		String jumin = request.getParameter("jumin1") + "-" + request.getParameter("jumin2_first")
				+ request.getParameter("jumin2_rest");
		String nickname = request.getParameter("nickname");
		String tel = request.getParameter("custom_phone") != null && !request.getParameter("custom_phone").isEmpty()
				? request.getParameter("custom_phone")
				: request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-"
						+ request.getParameter("phone3");

		String domain = request.getParameter("email_domain").equals("etc") ? request.getParameter("email_domain_custom")
				: request.getParameter("email_domain");

		String email = request.getParameter("email_prefix") + "@" + domain;
		String address = request.getParameter("zipcode") + " " + request.getParameter("address") + " "
				+ request.getParameter("address_detail");

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
		dto.setMemberPic(null); // 추후 프로필 사진 기능 구현 예정
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

}
