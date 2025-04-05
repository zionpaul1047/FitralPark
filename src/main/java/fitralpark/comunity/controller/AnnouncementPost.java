package fitralpark.comunity.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/announcementPost.do")
public class AnnouncementPost extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
        String post_no = req.getParameter("post_no");
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect("/fitralpark/login.do");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            CommunityDTO post = dao.getAnnouncementPost(post_no, req.getSession());
            ArrayList<CommunityDTO> Comment_list = dao.Announcement_Comment_list(post_no);
            
            req.setAttribute("post", post);
            req.setAttribute("Comment_list", Comment_list);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dao.close();
        }
        
        req.getRequestDispatcher("/WEB-INF/views/community/announcementPost.jsp").forward(req, resp);
    }
}