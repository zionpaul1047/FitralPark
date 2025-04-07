package fitralpark.comunity.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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

@WebServlet("/qnaPostWrite.do")
public class QnaPostWrite extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        UserDTO userDto = (UserDTO) session.getAttribute("loginUser");
        
        if (userDto == null) {
            resp.sendRedirect("/fitralpark/login.do");
            return;
        }
        
        CommunityDAO dao = new CommunityDAO();
        
        try {
            ArrayList<CommunityDTO> hlist = dao.getQnaHeaderList();
            if (hlist == null || hlist.isEmpty()) {
                PrintWriter out = resp.getWriter();
                out.println("<script>");
                out.println("alert('말머리 목록을 불러오는데 실패했습니다.');");
                out.println("history.back();");
                out.println("</script>");
                out.close();
                return;
            }
            req.setAttribute("hlist", hlist);
            
            RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/community/qnaWrite.jsp");
            dispatcher.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('시스템 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
        } finally {
            dao.close();
        }
    }
} 