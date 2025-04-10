package fitralpark.user.controller;

import fitralpark.common.utils.ValidationUtil;
import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
/**
 * 회원가입 요청을 처리하는 서블릿입니다.
 * <p>
 * 클라이언트로부터 전달받은 회원 정보를 수집하여 유효성을 검증한 후,
 * 데이터베이스에 회원 정보를 저장하고 결과에 따라 알림창을 통해 피드백을 제공합니다.
 * </p>
 *
 * URL: {@code /register.do}
 * 
 * <ul>
 *   <li>요청 방식: {@code POST}</li>
 *   <li>요청 파라미터: {@code id}, {@code password}, {@code name}, {@code nickname}, {@code jumin1}, {@code jumin2_first}, {@code jumin2_rest}, {@code phoneX}, {@code email}, {@code address}</li>
 *   <li>응답 방식: HTML + JavaScript (alert + 리다이렉트)</li>
 * </ul>
 *
 * <p><b>서버 측 유효성 검사 수행 항목:</b> 아이디, 비밀번호, 닉네임, 주민번호, 이메일, 전화번호</p>
 * 
 * @author 이지온
 */
@WebServlet("/register.do")
public class RegisterController extends HttpServlet {

    /**
     * 회원가입 폼으로부터 전달된 데이터를 처리합니다.
     * <p>
     * 입력값을 수집 및 정리한 후, 서버 유효성 검사를 거쳐 DTO 객체를 생성하고
     * DB에 회원 정보를 삽입합니다. 성공 여부에 따라 alert 창 및 리다이렉션을 처리합니다.
     * </p>
     *
     * @param req 회원가입 정보를 포함한 HTTP POST 요청
     * @param resp 처리 결과에 따른 JavaScript 기반 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		System.out.println("[DEBUG] RegisterController 호출됨");

		// 1. 입력값 수집
		String id = req.getParameter("id");
		String pw = req.getParameter("password");
		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String jumin = req.getParameter("jumin1") + req.getParameter("jumin2_first") + req.getParameter("jumin2_rest");

		String tel = "";
		if (req.getParameter("custom_phone") != null && !req.getParameter("custom_phone").trim().isEmpty()) {
			tel = req.getParameter("custom_phone").replaceAll("-", "");
		} else {
			tel = req.getParameter("phone1") + "-" + req.getParameter("phone2") + "-" + req.getParameter("phone3");
		}

		String email = req.getParameter("email");
		String address = req.getParameter("zipcode") + "◈" + req.getParameter("address") + "◈" + req.getParameter("address_detail");

		// 2. 서버 유효성 검사
		resp.setContentType("text/html;charset=UTF-8");
		String contextPath = req.getContextPath();

		if (!ValidationUtil.isValidId(id)) {
			resp.getWriter().write("<script>alert('아이디 형식이 올바르지 않습니다.'); history.back();</script>");
			return;
		}
		if (!ValidationUtil.isValidPassword(pw)) {
			resp.getWriter().write("<script>alert('비밀번호 형식이 올바르지 않습니다.'); history.back();</script>");
			return;
		}
		if (!ValidationUtil.isValidNickname(nickname)) {
			resp.getWriter().write("<script>alert('닉네임 형식이 올바르지 않습니다.'); history.back();</script>");
			return;
		}
		if (!ValidationUtil.isValidJumin(jumin)) {
			resp.getWriter().write("<script>alert('주민등록번호 형식이 올바르지 않습니다.'); history.back();</script>");
			return;
		}
		if (!ValidationUtil.isValidEmail(email)) {
			resp.getWriter().write("<script>alert('이메일 인증 또는 형식을 확인해주세요.'); history.back();</script>");
			return;
		}
		if (!ValidationUtil.isValidPhone(tel)) {
			resp.getWriter().write("<script>alert('전화번호 형식이 올바르지 않습니다.'); history.back();</script>");
			return;
		}

		// 3. DTO 생성		
		UserDTO dto = new UserDTO();
		dto.setMemberId(id);
		dto.setPw(pw);
		dto.setMemberName(name);
		dto.setMemberNickname(nickname);
		dto.setPersonalNumber(jumin);
		dto.setTel(tel);
		dto.setEmail(email);
		dto.setAddress(address);

		// 기본값 (이미지는 추후 구현)
		dto.setMemberPic(null);
		dto.setBackgroundPic(null);
		dto.setAllergy(null);
		dto.setFitnessScore(0);
		dto.setCommunityScore(0);
		dto.setRestrictCheck(0);
		dto.setWithdrawCheck(0);
		dto.setMentorCheck(0);
		dto.setAdminCheck(0);
		dto.setPlanPublicCheck(0);

		// 4. DB 저장
		UserDAO dao = new UserDAO();
		int result = dao.insertMember(dto);

		// 5. 결과 처리
		if (result > 0) {
			resp.getWriter().write("<script>"
				+ "alert('회원가입이 완료되었습니다.');"
				+ "window.opener.location.href='" + contextPath + "/index.do';"
				+ "window.location.href='" + contextPath + "/login.do?show=login';"
				+ "</script>");
		} else {
			resp.getWriter().write("<script>alert('회원가입에 실패했습니다.'); history.back();</script>");
		}

		System.out.println("[DEBUG_RegisterController.java] 전달받은 이메일: " + email);
	}
}
