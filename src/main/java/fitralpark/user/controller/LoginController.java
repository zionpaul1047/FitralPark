package fitralpark.user.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

import java.io.IOException;
import java.io.PrintWriter;
/**
 * 로그인 화면 출력 및 로그인 처리를 담당하는 서블릿입니다.
 * <p>
 * GET 요청 시 로그인 폼(auth.jsp)을 보여주며,  
 * POST 요청 시 사용자가 입력한 아이디/비밀번호를 검증하여 로그인 처리 및 세션 저장을 수행합니다.
 * 로그인 성공 시 원래 페이지로 리다이렉트하거나 메인 페이지로 이동합니다.
 * </p>
 *
 * URL: {@code /login.do}
 *
 * @author 이지온
 */
@WebServlet("/login.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 로그인 화면(auth.jsp)을 출력합니다.
	 * <p>
	 * 요청 파라미터 {@code show} 값을 JSP에 전달하여 어떤 폼을 표시할지 결정할 수 있습니다.
	 * </p>
	 *
	 * @param request 클라이언트의 HTTP GET 요청
	 * @param response 로그인 화면(auth.jsp)으로 포워딩되는 HTTP 응답
	 * @throws ServletException 서블릿 처리 중 예외 발생 시
	 * @throws IOException 입출력 처리 중 예외 발생 시
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// auth.jsp로 포워딩
		String show = request.getParameter("show");
		request.setAttribute("show", show);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/auth.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * 사용자의 로그인 요청을 처리합니다.
	 * <p>
	 * 전달된 아이디/비밀번호를 검증한 후, 로그인 성공 시 세션에 사용자 정보를 저장하고
	 * 팝업창이 열린 경우에는 부모 창을 갱신한 뒤 닫습니다.
	 * 실패 시에는 경고창을 띄우고 이전 페이지로 되돌아갑니다.
	 * </p>
	 *
	 * @param request 클라이언트의 HTTP POST 요청 (파라미터: {@code username}, {@code password})
	 * @param response 로그인 결과에 따른 JavaScript 응답
	 * @throws ServletException 서블릿 처리 중 예외 발생 시
	 * @throws IOException 입출력 처리 중 예외 발생 시
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// DB에서 로그인 정보 확인
		UserDAO dao = new UserDAO();
		UserDTO loginUser = dao.login(username, password); // login() 메서드는 UserDAO에 작성 필요

		response.setContentType("text/html;charset=UTF-8");

		if (loginUser != null) {
			// 로그인 성공 → 세션에 DTO 저장
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser);
			System.out.println(session);
			String redirect = (String) session.getAttribute("redirectAfterLogin");
			if (redirect == null || redirect.isEmpty()) {
				redirect = "/index.do";
			} else {
				session.removeAttribute("redirectAfterLogin");
			}

			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 성공!');");
			out.println("if (window.opener) {");
			out.println("  window.opener.location.href='" + request.getContextPath() + redirect + "';");
			out.println("  var overlay = window.opener.document.getElementById('overlay');");
			out.println("  if (overlay) overlay.style.display = 'none';");
			out.println("  window.close();");
			out.println("} else {");
			out.println("  location.href='" + request.getContextPath() + redirect + "';");
			out.println("}");
			out.println("</script>");

		} else {
			// 로그인 실패 시에만 실행되어야 하는 코드
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디 또는 비밀번호가 일치하지 않습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}

	}
}
