package fitralpark.comunity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/qnaPostDel.do")
public class QnaPostDel extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
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
            
            req.setAttribute("dto", dto);
            req.getRequestDispatcher("/WEB-INF/views/community/qnaPostDel.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("qnaList.do");
        } finally {
            dao.close();
        }
    }
} 