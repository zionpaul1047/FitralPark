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

@WebServlet("/announcementPostEditOK.do")
public class AnnouncementPostEditOK extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO)session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        if (userDto.getAdminCheck() == 1) {
        PrintWriter out = resp.getWriter();
        out.println("<script>");
        out.println("alert('게시글을 수정할 권한이 없습니다.');");
        out.println("history.back();");
        out.println("</script>");
        out.close();
        return;
        }


        // 게시글 정보 가져오기
        String post_no = req.getParameter("post_no");
        String post_subject = req.getParameter("post_subject");
        String post_content = req.getParameter("post_content");
        String header_no = req.getParameter("header_no");
        String private_check = req.getParameter("private_check");
        
        // 필수 입력값 검증
        if (post_no == null || post_no.trim().isEmpty() ||
            post_subject == null || post_subject.trim().isEmpty() ||
            post_content == null || post_content.trim().isEmpty() ||
            header_no == null || header_no.trim().isEmpty()) {
            
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('필수 입력값이 누락되었습니다.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            // 게시글 작성자 확인
            CommunityDTO existingPost = dao.getAnnouncementPost(post_no, req.getSession());
            
            // 게시글 수정
            CommunityDTO communityDto = new CommunityDTO();
            communityDto.setPost_no(post_no);
            communityDto.setPost_subject(post_subject);
            communityDto.setPost_content(post_content);
            communityDto.setHeader_no(header_no);
            communityDto.setPrivate_check(private_check);
            
            int result = dao.announcement_Edit_Post(communityDto, userDto);
            
            if (result > 0) {
                resp.sendRedirect("/fitralpark/announcementPost.do?post_no=" + post_no);
            } else {
                PrintWriter out = resp.getWriter();
                out.println("<script>");
                out.println("alert('게시글 수정에 실패했습니다.');");
                out.println("history.back();");
                out.println("</script>");
                out.close();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('게시글 수정 중 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
        } finally {
            dao.close();
        }
    }
} 