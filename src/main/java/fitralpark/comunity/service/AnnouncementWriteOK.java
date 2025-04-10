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

/**
	공지사항 작성 수행을 위한 서블릿 클래스입니다.
*/
@WebServlet("/announcementWriteOK.do")
public class AnnouncementWriteOK extends HttpServlet {
    
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
        
        // 관리자 권한 체크
        if (userDto.getAdminCheck() != 1) {
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.println("<script>");
            writer.println("alert('관리자만 접근 가능합니다.');");
            writer.println("location.href='/fitralpark/announcementList.do';");
            writer.println("</script>");
            writer.close();
            return;
        }
        
        // 게시글 정보 가져오기
        String post_subject = req.getParameter("subject");
        String post_content = req.getParameter("content");
        String header_no = req.getParameter("header");
        String private_check = req.getParameter("private_check");
        
        // 필수 입력값 검증
        if (post_subject == null || post_subject.trim().isEmpty() ||
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
            CommunityDTO communityDto = new CommunityDTO();
            communityDto.setPost_subject(post_subject);
            communityDto.setPost_content(post_content);
            communityDto.setHeader_no(header_no);
            communityDto.setPrivate_check(private_check);
            communityDto.setCreator_id(userDto.getMemberId());
            
            int result = dao.Announcement_post_add(communityDto, userDto);
            
            if (result > 0) {
                resp.sendRedirect("/fitralpark/announcementList.do");
            } else {
                PrintWriter out = resp.getWriter();
                out.println("<script>");
                out.println("alert('게시글 작성에 실패했습니다.');");
                out.println("history.back();");
                out.println("</script>");
                out.close();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('게시글 작성 중 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
        } finally {
            dao.close();
        }
    }
} 