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
import fitralpark.user.dto.UserDTO;
import fitralpark.comunity.dto.CommunityDTO;

@WebServlet("/announcementCommentEditOK.do")
public class AnnouncementCommentEditOK extends HttpServlet {
    
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
        
        String comment_no = req.getParameter("comment_no");
        String comment_content = req.getParameter("comment_content");
        String comment_creator_id = req.getParameter("comment_creator_id");
        String post_no = req.getParameter("post_no");
        
        // 권한 확인
        if (!userDto.getMemberId().equals(comment_creator_id)) {
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\": \"unauthorized\", \"message\": \"댓글을 수정할 권한이 없습니다.\"}");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            CommunityDTO communityDto = new CommunityDTO();
            communityDto.setComment_no(comment_no);
            communityDto.setComment_content(comment_content);
            boolean success = dao.announcement_Edit_Comment(communityDto);
            
            resp.setContentType("application/json");
            if (success) {
                resp.getWriter().write("{\"status\": \"success\", \"message\": \"댓글이 수정되었습니다.\"}");
            } else {
                resp.getWriter().write("{\"status\": \"fail\", \"message\": \"댓글 수정에 실패했습니다.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\": \"error\", \"message\": \"댓글 수정 중 오류가 발생했습니다.\"}");
        } finally {
            dao.close();
        }
    }
} 