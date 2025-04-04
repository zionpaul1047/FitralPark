package fitralpark.common.config;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

/**
 * 🔐 로그인 보호 필터
 * - 보호 경로에 대해 로그인 상태인지 확인
 * - 미로그인 시 로그인 팝업 트리거용 속성 저장
 * - 로그인 성공 시 해당 속성 제거
 */
@WebFilter("/*")
public class SessionCheckFilter implements Filter {

    // 로그인 필요 없는 경로 목록
    private static final String[] excludePaths = {
        "/index.do", "/login.do", "/logout.do", "/register.do", "/auth.jsp",
        "/checkId.do", "/sendAuthEmail.do", "/checkAuthCode.do",
        "/favicon.ico", "/assets/"
    };

    // 로그인 보호가 필요한 경로
    private static final String[] protectedPaths = {
        "/dashboard.do", "/bulletinList.do", "/diet.do", "/recommendation.do"
    };

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

            // 일반 요청인지, AJAX인지 판별 필요시 여기에 조건 추가 가능
            if ("XMLHttpRequest".equals(httpReq.getHeader("X-Requested-With"))) {
                httpRes.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인 필요");
            } else {
				//httpRes.sendRedirect(contextPath + "/login.do?show=login");
            }

            return; // 요청 차단
        }

        // 로그인된 상태인데 이전 플래그가 남아있다면 제거
        if (isLoggedIn && session.getAttribute("loginRequired") != null) {
            session.removeAttribute("loginRequired");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void destroy() {}
}
