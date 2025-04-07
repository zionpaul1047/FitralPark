package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.user.dto.UserDTO;

@WebServlet("/report.do")
public class Report extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 로그인 체크
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO)session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.setContentType("text/html; charset=UTF-8");
            resp.getWriter().println("<script>alert('로그인이 필요합니다.'); window.close();</script>");
            return;
        }
        
        // 필수 파라미터 체크
        String target_type = req.getParameter("target_type");
        String target_id = "";
        String creator_id = req.getParameter("creator_id");
        
        // 게시글인지 댓글인지에 따라 target_id 설정
        if (target_type.endsWith("_post")) {
            target_id = req.getParameter("post_no");
        } else if (target_type.endsWith("_comment")) {
            target_id = req.getParameter("comment_no");
        }
        
        if (target_type == null || target_type.trim().isEmpty() ||
            target_id == null || target_id.trim().isEmpty() ||
            creator_id == null || creator_id.trim().isEmpty()) {
            resp.setContentType("text/html; charset=UTF-8");
            resp.getWriter().println("<script>alert('잘못된 접근입니다.'); window.close();</script>");
            return;
        }
        
        // 파라미터를 request에 저장
        req.setAttribute("target_type", target_type);
        req.setAttribute("target_id", target_id);
        req.setAttribute("creator_id", creator_id);
        
        // 신고 페이지로 포워딩
        req.getRequestDispatcher("/WEB-INF/views/community/report.jsp").forward(req, resp);
    }
} 