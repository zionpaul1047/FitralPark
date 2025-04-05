package fitralpark.user.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/modfyuserinfook.do")
public class ModfyUserInfoOk extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//ModfyUserInfoOk.java
		if(req.getSession().getAttribute("loginUser") == null) {
			
			resp.sendRedirect("/fitralpark/index.do");
		} else {
			req.setCharacterEncoding("UTF-8");
			String id = ((UserDTO)(req.getSession().getAttribute("loginUser"))).getMemberId();
			String pw = req.getParameter("user_pw");
			String nick = req.getParameter("user_nickname");
			String tel1 = req.getParameter("user_tel1");
			String tel2 = req.getParameter("user_tel2");
			String tel3 = req.getParameter("user_tel3");
			String custom_tel = req.getParameter("custom_phone");
			String tel_select = req.getParameter("tel_select");
			String email_prefix = req.getParameter("user_email_prefix");
			String email_domain = req.getParameter("user_email_domain");
			String email_domain_custom = req.getParameter("email_domain_custom");
			String email_domain_select = req.getParameter("email_domain_select");
			String postcode = req.getParameter("input_postcode");
			String address = req.getParameter("input_address");
			String detailAddress = req.getParameter("input_detailAddress");
			
//			System.out.println("pw: " + pw);
//			System.out.println("nick: " + nick);
//			System.out.println("tel1: " + tel1);
//			System.out.println("tel2: " + tel2);
//			System.out.println("tel3: " + tel3);
//			System.out.println("custom_tel: " + custom_tel);
//			System.out.println("tel_select: " + tel_select);
//			System.out.println("email_prefix: " + email_prefix);
//			System.out.println("email_domain: " + email_domain);
//			System.out.println("email_domain_custom: " + email_domain_custom);
//			System.out.println("email_domain_select: " + email_domain_select);
//			System.out.println("postcode: " + postcode);
//			System.out.println("address: " + address);
//			System.out.println("detailAddress: " + detailAddress);
			
			
			UserDTO dto = new UserDTO();
			dto.setMemberId(id);
			dto.setPw(pw);
			dto.setMemberNickname(nick);
			if(tel_select.equals("default")) {
				dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
			} else if (tel_select.equals("custom")) {
				dto.setTel(custom_tel);
			}
			if (email_domain_select.equals("default")) {
				dto.setEmail(email_prefix + "@" + email_domain);
			} else if (email_domain_select.equals("custom")) {
				dto.setEmail(email_prefix + "@" + email_domain_custom);
			}
			dto.setAddress(postcode + "◈" + address + "◈" + detailAddress);

			
			UserDAO dao = new UserDAO();
			
			int result = dao.updateMember(dto);
			dao.close();
			
			req.setAttribute("service_result", result);
			System.out.println("회원정보 수정완료: " + result);
			
			//req.getRequestDispatcher("/mdfyuserinfo.do").forward(req, resp);
			resp.sendRedirect("/fitralpark/mdfyuserinfo.do?serviceResult=" + result);
		}
		

	}

}