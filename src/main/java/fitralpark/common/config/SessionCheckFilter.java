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
 * 로그인 세션 체크 필터입니다.
 * <p>
 * 특정 보호된 경로에 접근할 경우 사용자가 로그인되어 있는지 확인하고,
 * 로그인되지 않은 경우 세션에 로그인 요구 속성을 추가한 후 로그인 페이지로 리다이렉트하거나,
 * AJAX 요청인 경우 401 에러를 응답합니다.
 * </p>
 * 
 * <ul>
 *   <li>필터 대상: 전체 경로 ({@code "/*"})</li>
 *   <li>예외 경로: 로그인/회원가입/정적 자원/카카오 API 등</li>
 *   <li>보호 경로: 마이페이지, 게시판, 운동, Q and A 등 주요 기능</li>
 * </ul>
 * 
 * <p><b>세션 속성:</b> {@code loginRequired}, {@code redirectAfterLogin}</p>
 * 
 * @author 이지온
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

    /**
     * 요청 경로에 따라 로그인 여부를 확인하고, 보호 경로 접근 시 인증을 요구합니다.
     * <p>
     * 로그인되지 않은 사용자가 보호된 경로에 접근하면 세션에 {@code loginRequired}와 {@code redirectAfterLogin}을 설정한 후,
     * 일반 요청은 메인 페이지({@code /index.do})로 리다이렉트하고, AJAX 요청은 401 에러를 응답합니다.
     * </p>
     *
     * @param request  필터링할 요청
     * @param response 필터링할 응답
     * @param chain    다음 필터 또는 서블릿으로 요청 전달
     * @throws IOException 요청/응답 처리 중 I/O 오류 발생 시
     * @throws ServletException 필터 처리 중 서블릿 예외 발생 시
     */
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
    /**
     * 필터 초기화 메서드
     *
     * @param filterConfig 필터 설정 객체
     */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}
    /**
     * 필터 종료 처리 메서드
     */
	@Override
	public void destroy() {
	}
}
