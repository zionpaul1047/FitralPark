package fitralpark.user.controller;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 이름과 이메일을 기반으로 회원 아이디를 조회하는 서블릿입니다.
 * <p>
 * 사용자가 입력한 이름과 이메일 정보를 바탕으로 회원 아이디를 검색한 후,
 * 결과를 알림창(alert)으로 출력하고 로그인 화면으로 이동하거나 이전 페이지로 되돌립니다.
 * </p>
 * 
 * URL: {@code /find-id.do}
 * 
 * @author 이지온
 */
@WebServlet("/find-id.do")
public class FindIdController extends HttpServlet {

    /**
     * POST 방식으로 전달된 이름과 이메일 정보를 기반으로 회원 아이디를 조회하고,
     * 결과에 따라 알림창을 출력한 후 로그인 페이지로 리다이렉트하거나 이전 페이지로 되돌립니다.
     *
     * @param req 클라이언트의 HTTP POST 요청 (파라미터: {@code name}, {@code email})
     * @param resp HTML 및 JavaScript 알림 형식으로 응답을 반환
     * @throws ServletException 서블릿 처리 중 예외 발생 시
     * @throws IOException 입출력 처리 중 예외 발생 시
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        UserDAO dao = new UserDAO();
        String foundId = dao.findIdByNameAndEmail(name, email);

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        if (foundId != null) {
            out.write("<script>alert('회원님의 아이디는: " + foundId + " 입니다.'); window.location.href='login.do?show=login';</script>");
        } else {
            out.write("<script>alert('일치하는 회원 정보가 없습니다.'); history.back();</script>");
        }
    }
}
