package fitralpark.diet.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import fitralpark.diet.dao.DietDAO;

@WebServlet("/dietFavorite.do")
public class DietFavorite extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //DietFavorite.java
        
        String memberId = req.getParameter("memberId");
        String dietNo = req.getParameter("dietNo");
        boolean isCurrentlyBookmarked;
        
        System.out.println("memberId: " + memberId);
        System.out.println("dietNo: " + dietNo);
        
        DietDAO dao = new DietDAO();
        Map<String, Object> result = new HashMap<>();
        
        try {
            
            dao.editBookmark(dietNo, memberId);
            
            // 성공 응답 반환
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(resp.getWriter(), result);
            
        } catch (Exception e) {
            // 오류 응답 반환
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("즐겨찾기 처리 중 오류 발생: " + e.getMessage());
        }
    }


}
