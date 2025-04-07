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

@WebServlet("/qnaPostDeleteOK.do")
public class QnaPostDeleteOK extends HttpServlet {
    
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
        
        String post_no = req.getParameter("post_no");
        
        if (post_no == null || post_no.trim().isEmpty()) {
            resp.sendRedirect("qnaList.do");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            CommunityDTO dto = dao.getQnaPost(post_no, session);
            
            if (dto == null) {
                resp.sendRedirect("qnaList.do");
                return;
            }
            
            // 작성자 본인 확인
            if (!userDto.getMemberId().equals(dto.getCreator_id())) {
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('삭제 권한이 없습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
                return;
            }
            
            boolean result = dao.Qna_post_delete(post_no);
            
            if (result) {
                resp.sendRedirect("qnaList.do");
            } else {
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('게시글 삭제에 실패했습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter writer = resp.getWriter();
            writer.println("<script>");
            writer.println("alert('게시글 삭제 중 오류가 발생했습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
            writer.close();
        } finally {
            dao.close();
        }
    }
} 