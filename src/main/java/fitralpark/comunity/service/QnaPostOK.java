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

@WebServlet("/qnaPostOK.do")
public class QnaPostOK extends HttpServlet {
    
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
        
        String post_subject = req.getParameter("post_subject");
        String post_content = req.getParameter("post_content");
        String header_no = req.getParameter("header_no");
        
        if (post_subject == null || post_subject.trim().isEmpty() ||
            post_content == null || post_content.trim().isEmpty() ||
            header_no == null || header_no.trim().isEmpty()) {
            
            PrintWriter writer = resp.getWriter();
            writer.println("<script>");
            writer.println("alert('필수 입력값이 누락되었습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
            writer.close();
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            CommunityDTO dto = new CommunityDTO();
            dto.setPost_subject(post_subject);
            dto.setPost_content(post_content);
            dto.setHeader_no(header_no);
            dto.setCreator_id(userDto.getMemberId());
            
            int result = dao.Qna_post_add(dto, userDto);
            
            if (result > 0) {
                resp.sendRedirect("qnaList.do");
            } else {
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('게시글 등록에 실패했습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter writer = resp.getWriter();
            writer.println("<script>");
            writer.println("alert('게시글 등록 중 오류가 발생했습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
            writer.close();
        } finally {
            dao.close();
        }
    }
} 