package fitralpark.user.controller;

import fitralpark.user.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * 회원가입 시 아이디 중복 여부를 확인하는 서블릿입니다.
 * <p>
 * 클라이언트가 전달한 아이디에 대해 데이터베이스 조회를 수행하고,
 * 중복 여부를 JSON 형식으로 반환합니다.
 * </p>
 *
 * URL: {@code /checkId.do}
 *
 * 응답 예시: {@code {"exists": true}} 또는 {@code {"exists": false}}
 * 
 * @author 이지온
 */
@WebServlet("/checkId.do")
public class CheckIdController extends HttpServlet {
    /**
     * 전달받은 아이디가 이미 존재하는지 확인하여 JSON 응답을 반환합니다.
     *
     * @param req 클라이언트의 HTTP GET 요청 (파라미터: {@code id})
     * @param resp JSON 형식으로 중복 여부를 응답하는 HTTP 응답
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        UserDAO dao = new UserDAO();
        boolean isDuplicate = dao.isDuplicateId(id);

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.print("{\"exists\": " + isDuplicate + "}");
    }
}
