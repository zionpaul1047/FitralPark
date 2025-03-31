package fitralpark.common.utils;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.common.utils.DBUtil;

@WebServlet("/dbtest")
public class DBTestServlet extends HttpServlet {
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

