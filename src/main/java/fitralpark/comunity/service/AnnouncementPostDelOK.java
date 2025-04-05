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

@WebServlet("/announcementPostDelOK.do")
public class AnnouncementPostDelOK extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션 확인
        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect("/fitralpark/member/login.do");
            return;
        }
        
        // 게시글 번호 가져오기
        String post_no = req.getParameter("post_no");
        
        if (post_no == null || post_no.equals("")) {
            resp.sendRedirect("/fitralpark/announcementList.do");
            return;
        }
        
        //관리자 권한 체크
        if (userDto.getAdminCheck() == 1) {
            //관리자인 경우 삭제 처리
            CommunityDAO dao = new CommunityDAO();
            boolean result = dao.announcement_Del_Post(post_no, userDto);
            
            if (result) {
                resp.sendRedirect("/fitralpark/announcementList.do");
            } else {
                resp.setCharacterEncoding("UTF-8");
                resp.setContentType("text/html; charset=UTF-8");
                
                PrintWriter writer = resp.getWriter();
                writer.println("<script>");
                writer.println("alert('삭제에 실패했습니다.');");
                writer.println("history.back();");
                writer.println("</script>");
                writer.close();
            }
            dao.close();
        } else {
            //권한 없음
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html; charset=UTF-8");
            
            PrintWriter writer = resp.getWriter();
            writer.println("<script>");
            writer.println("alert('권한이 없습니다.');");
            writer.println("history.back();");
            writer.println("</script>");
            writer.close();
        }
    }
} 