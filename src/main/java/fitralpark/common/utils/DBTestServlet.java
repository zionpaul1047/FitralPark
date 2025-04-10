package fitralpark.common.utils;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.common.utils.DBUtil;
/**
 * DB 커넥션 풀 테스트용 서블릿입니다.
 * <p>
 * {@link DBUtil#getConnection()} 메서드를 사용하여 데이터베이스 연결이 정상적으로 이루어지는지 확인하고,
 * 연결 결과를 HTML 형식으로 출력합니다.
 * </p>
 *
 * URL: {@code /dbtest}
 * 요청 방식: {@code GET}
 * 
 * <p><b>용도:</b> 개발 또는 테스트 환경에서 커넥션 풀(DBCP) 설정 확인용</p>
 * 
 * @author 이지온
 */
@WebServlet("/dbtest")
public class DBTestServlet extends HttpServlet {
    /**
     * DB 커넥션을 시도하고, 성공 또는 실패 여부를 HTML로 출력합니다.
     *
     * @param request HTTP GET 요청
     * @param response DB 연결 결과 메시지를 담은 HTML 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 한글 인코딩
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null) {
                response.getWriter().println("커넥션 풀 연결 성공!");
            } else {
                response.getWriter().println("커넥션 풀 연결 실패: null");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("예외 발생: " + e.getMessage());
        }
    }
}

