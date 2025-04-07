package fitralpark.comunity.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/qnaPostEdit.do")
public class QnaPostEdit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
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
            // 게시글 정보 조회
            CommunityDTO dto = dao.getQnaPost(post_no, session);
            
            if (dto == null) {
                resp.sendRedirect("qnaList.do");
                return;
            }
            
            // 작성자 본인 확인
            if (!userDto.getMemberId().equals(dto.getCreator_id())) {
                resp.setCharacterEncoding("UTF-8");
                resp.setContentType("text/html; charset=UTF-8");
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('수정 권한이 없습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
                return;
            }
            
            // 말머리 목록 조회
            ArrayList<CommunityDTO> headerList = dao.getQnaHeaderList();
            
            req.setAttribute("dto", dto);
            req.setAttribute("headerList", headerList);
            
            req.getRequestDispatcher("/WEB-INF/views/community/qnaPostEdit.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("qnaList.do");
        } finally {
            dao.close();
        }
    }
} 