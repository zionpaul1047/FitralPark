package fitralpark.comunity.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/reportOK.do")
public class ReportOK extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter writer = resp.getWriter();
        
        // 로그인 체크
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO)session.getAttribute("loginUser");
        
        if (userDto == null) {
            writer.println("<script>");
            writer.println("alert('로그인이 필요합니다.');");
            writer.println("window.close();");
            writer.println("</script>");
            writer.close();
            return;
        }
        
        // 파라미터 받기
        String target_type = req.getParameter("target_type");
        String target_id = req.getParameter("target_id");
        String creator_id = req.getParameter("creator_id");
        String report_reason = req.getParameter("report_reason");
        String report_content = req.getParameter("report_content");
        
        // 필수 파라미터 체크
        if (target_type == null || target_type.trim().isEmpty() ||
            target_id == null || target_id.trim().isEmpty() ||
            creator_id == null || creator_id.trim().isEmpty() ||
            report_reason == null || report_reason.trim().isEmpty() ||
            report_content == null || report_content.trim().isEmpty()) {
            
            writer.println("<script>");
            writer.println("alert('필수 입력값이 누락되었습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
            writer.close();
            return;
        }
        
        // 세션에서 신고한 게시글 목록 가져오기
        @SuppressWarnings("unchecked")
        Set<String> reportedPosts = (Set<String>) session.getAttribute("reportedPosts");
        
        if (reportedPosts == null) {
            reportedPosts = new HashSet<>();
            session.setAttribute("reportedPosts", reportedPosts);
        }
        
        // 이미 신고한 게시글인지 확인
        if (reportedPosts.contains(target_id)) {
            writer.println("<script>");
            writer.println("alert('이미 신고한 게시글입니다.');");
            writer.println("window.close();");
            writer.println("</script>");
            writer.close();
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            // 신고 처리
            boolean result = dao.addReport(target_id, userDto.getMemberId(), target_type);
            
            if (result) {
                // 세션에 신고한 게시글 추가
                reportedPosts.add(target_id);
                session.setAttribute("reportedPosts", reportedPosts);
                
                writer.println("<script>");
                writer.println("alert('신고가 접수되었습니다.');");
                writer.println("window.opener.location.reload();"); // 부모 창 새로고침
                writer.println("window.close();");
                writer.println("</script>");
            } else {
                writer.println("<script>");
                writer.println("alert('신고 처리 중 오류가 발생했습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            writer.println("<script>");
            writer.println("alert('신고 처리 중 오류가 발생했습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
        } finally {
            dao.close();
            writer.close();
        }
    }
} 