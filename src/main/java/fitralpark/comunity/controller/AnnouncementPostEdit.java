package fitralpark.comunity.controller;

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

@WebServlet("/announcementPostEdit.do")
public class AnnouncementPostEdit extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        if (userDto.getAdminCheck() != 1) {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println("<script>");
	        out.println("alert('게시글을 수정할 권한이 없습니다.');");
	        out.println("history.back();");
	        out.println("</script>");
	        out.close();
	        return;
        }
        
        
        
        String post_no = req.getParameter("post_no");
        
        if (post_no == null || post_no.trim().isEmpty()) {
            resp.sendRedirect("/fitralpark/announcementList.do");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            CommunityDTO post = dao.getAnnouncementPost(post_no, req.getSession());
            
            if (!userDto.getMemberId().equals(post.getCreator_id())) {
                resp.sendRedirect("/fitralpark/announcementList.do");
                return;
            }
            
            req.setAttribute("post", post);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dao.close();
        }
        
        req.getRequestDispatcher("/WEB-INF/views/community/announcementPostEdit.jsp").forward(req, resp);
    }
} 