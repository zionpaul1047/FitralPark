package fitralpark.comunity.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/qnaCommentEditOK.do")
public class QnaCommentEditOK extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO)session.getAttribute("loginUser");
        
        if (userDto == null) {
            sendJsonResponse(resp, "error", "로그인이 필요합니다.");
            return;
        }
        
        String comment_no = req.getParameter("comment_no");
        String post_no = req.getParameter("post_no");
        String comment_content = req.getParameter("comment_content");
        
        if (comment_no == null || comment_no.trim().isEmpty() ||
            post_no == null || post_no.trim().isEmpty() ||
            comment_content == null || comment_content.trim().isEmpty()) {
            
            sendJsonResponse(resp, "error", "필수 입력값이 누락되었습니다.");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            // 댓글 작성자 확인
            CommunityDTO dto = dao.getQnaComment(comment_no);
            
            if (dto == null) {
                sendJsonResponse(resp, "error", "댓글을 찾을 수 없습니다.");
                return;
            }
            
            if (!userDto.getMemberId().equals(dto.getCreator_id())) {
                sendJsonResponse(resp, "error", "수정 권한이 없습니다.");
                return;
            }
            
            dto.setComment_content(comment_content);
            boolean result = dao.Qna_comment_edit(dto);
            
            if (result) {
                sendJsonResponse(resp, "success", "댓글이 수정되었습니다.");
            } else {
                sendJsonResponse(resp, "error", "댓글 수정에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonResponse(resp, "error", "댓글 수정 중 오류가 발생했습니다.");
        } finally {
            dao.close();
        }
    }
    
    private void sendJsonResponse(HttpServletResponse resp, String status, String message) throws IOException {
        PrintWriter writer = resp.getWriter();
        writer.println("{\"status\":\"" + status + "\", \"message\":\"" + message + "\"}");
        writer.close();
    }
} 