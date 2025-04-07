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

@WebServlet("/qnaPost.do")
public class QnaPost extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String post_no = req.getParameter("post_no");
        HttpSession session = req.getSession();
        
        if (post_no == null || post_no.trim().isEmpty()) {
            resp.sendRedirect("qnaList.do");
            return;
        }
        
        if (null != session.getAttribute("loginUser")) {
			
		} else {
			resp.sendRedirect(req.getContextPath() + "/login.do");
			return;
		}
        
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            // 게시글 정보 조회
            CommunityDTO dto = dao.getQnaPost(post_no, session);
            
            if (dto == null) {
                resp.sendRedirect("qnaList.do");
                return;
            }
            
            // 댓글 목록 조회
            ArrayList<CommunityDTO> commentList = dao.getQnaCommentList(post_no);
            
            req.setAttribute("post", dto);
            req.setAttribute("commentList", commentList);
            
            req.getRequestDispatcher("/WEB-INF/views/community/qnaPost.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("qnaList.do");
        } finally {
            dao.close();
        }
    }
} 