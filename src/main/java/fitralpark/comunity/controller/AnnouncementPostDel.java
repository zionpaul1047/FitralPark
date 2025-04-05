package fitralpark.comunity.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.comunity.dao.CommunityDAO;
import fitralpark.comunity.dto.CommunityDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/announcementPostDel.do")
public class AnnouncementPostDel extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션 확인
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect("/fitralpark/login.do");
            return;
        }
        
        if (userDto.getAdminCheck() != 1) {
	        req.setCharacterEncoding("UTF-8");
	        resp.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println("<script>");
	        out.println("alert('게시글을 삭제할 권한이 없습니다.');");
	        out.println("history.back();");
	        out.println("</script>");
	        out.close();
	        return;
        }
        
        
        // 게시글 번호 가져오기
        String post_no = req.getParameter("post_no");
        
        if (post_no == null || post_no.equals("")) {
            resp.sendRedirect("/fitralpark/announcementList.do");
            return;
        }
        
        // 게시글 정보 가져오기
        CommunityDAO dao = new CommunityDAO();
        try {
            CommunityDTO dto = dao.getAnnouncementPost(post_no, req.getSession());
            
            // 작성자 확인
            if (!userDto.getMemberId().equals(dto.getCreator_id())) {
                resp.sendRedirect("/fitralpark/announcementList.do");
                return;
            }
            
            req.setAttribute("dto", dto);
            
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/community/announcementPostDel.jsp");
            dispatcher.forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dao.close();
        }
    }
} 