package fitralpark.common.config;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 로그인 보호 필터 - 보호 경로에 대해 로그인 상태인지 확인 - 미로그인 시 로그인 팝업 트리거용 속성 저장 - 로그인 성공 시 해당 속성
 * 제거
 */
@WebFilter("/*")
public class SessionCheckFilter implements Filter {

	// 로그인 필요 없는 경로 목록
	private static final String[] excludePaths = {
		    "/index.do", "/login.do", "/logout.do", "/register.do", "/auth.jsp",
		    "/checkId.do", "/sendAuthEmail.do", "/checkAuthCode.do",
		    "/favicon.ico", "/assets/", "/assets/js/", "/assets/css/", "/assets/images/",
		    "/dapi.kakao.com" // 외부 카카오 API 도메인 추가
		};

	// 로그인 보호가 필요한 경로
	private static final String[] protectedPaths = {

			// 마이페이지 관련
			"/dashboard.do",

			// 커뮤니티 관련
			"/bulletinPost.do", "/bulletinPostDel.do", "/bulletinPostDel.do", "/bulletinPostWrite.do",
			"/bulletinPostDelOK.do", "/bulletinPostEditOK.do", "/bulletinPostOK.do", "/bulletinWriteOK.do",
			"/bulletinPostEdit.do",

			// 운동 관련
			"/exerciseList.do", "/exerciseRecommend.do",

			// test
			"/qnaList.do" };

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpRes = (HttpServletResponse) response;
		HttpSession session = httpReq.getSession(false);

		String uri = httpReq.getRequestURI();
		String contextPath = httpReq.getContextPath();
		String command = uri.substring(contextPath.length());

		// 필터 제외 경로 처리
		for (String path : excludePaths) {
			if (command.startsWith(path)) {
				chain.doFilter(request, response);
				return;
			}
		}
		// 정적 리소스 및 외부 스크립트 예외 처리
		if (command.matches(".*\\.(js|css|png|jpg|jpeg|gif|ico)$") || uri.contains("/assets/")
				|| uri.contains("kakao.com")) {
			chain.doFilter(request, response);
			return;
		}

		// 로그인 여부 확인
		boolean isLoggedIn = (session != null && session.getAttribute("loginUser") != null);

		// 보호 경로 접근 시 로그인 필요 여부 확인
		boolean isProtected = false;
		for (String path : protectedPaths) {
			if (command.startsWith(path)) {
				isProtected = true;
				break;
			}
		}

		if (isProtected && !isLoggedIn) {
			session = httpReq.getSession(true);
			session.setAttribute("redirectAfterLogin", command);
			session.setAttribute("loginRequired", true);

			if ("XMLHttpRequest".equals(httpReq.getHeader("X-Requested-With"))) {
				httpRes.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인 필요");
			} else {
				// 보호된 경로 접근 시 index.do로 튕김
				httpRes.sendRedirect(contextPath + "/index.do");
			}

			return;
		}

		// 로그인된 상태인데 이전 플래그가 남아있다면 제거
		if (isLoggedIn && session.getAttribute("loginRequired") != null) {
			session.removeAttribute("loginRequired");
		}

		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	}
}
