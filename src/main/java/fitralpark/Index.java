package fitralpark;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * 애플리케이션의 메인 페이지(index.jsp)로 이동시키는 서블릿입니다.
 * <p>
 * {@code /index.do}로 요청이 들어오면 내부적으로 JSP 페이지로 포워딩됩니다.
 * 별도의 비즈니스 로직 없이 초기 화면을 제공하는 역할만 수행합니다.
 * </p>
 *
 * URL: {@code /index.do}
 * 포워딩 대상: {@code /WEB-INF/views/index.jsp}
 * 
 * @author 이지온
 */
@WebServlet("/index.do")
public class Index extends HttpServlet {

    /**
     * GET 요청을 처리하여 index.jsp로 포워딩합니다.
     *
     * @param req 클라이언트의 HTTP 요청
     * @param resp 클라이언트에게 반환할 HTTP 응답
     * @throws ServletException 포워딩 중 서블릿 오류 발생 시
     * @throws IOException 입출력 처리 오류 발생 시
     */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Index.java
		

		req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
	}

}
