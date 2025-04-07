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

@WebServlet("/qnaCommentDelOK.do")
public class QnaCommentDelOK extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO)session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect("login.do");
            return;
        }
        
        String comment_no = req.getParameter("comment_no");
        String post_no = req.getParameter("post_no");
        
        if (comment_no == null || comment_no.trim().isEmpty() ||
            post_no == null || post_no.trim().isEmpty()) {
            
            resp.sendRedirect("qnaList.do");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            // 댓글 작성자 확인
            CommunityDTO dto = dao.getQnaComment(comment_no);
            
            if (dto == null) {
                resp.sendRedirect("qnaPost.do?post_no=" + post_no);
                return;
            }
            
            if (!userDto.getMemberId().equals(dto.getCreator_id())) {
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('본인이 작성한 댓글만 삭제할 수 있습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
                return;
            }
            
            boolean result = dao.Qna_comment_delete(comment_no);
            
            if (result) {
                resp.sendRedirect("qnaPost.do?post_no=" + post_no);
            } else {
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('댓글 삭제에 실패했습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter writer = resp.getWriter();
            writer.println("<script>");
            writer.println("alert('댓글 삭제 중 오류가 발생했습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
            writer.close();
        } finally {
            dao.close();
        }
    }
} 