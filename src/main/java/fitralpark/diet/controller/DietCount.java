package fitralpark.diet.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.diet.dao.DietDAO;

@WebServlet("/getCount.do")
public class DietCount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //DietFavorite.java
        
        String dietNo = req.getParameter("dietNo");
        
        System.out.println("dietNo: " + dietNo);
        
        DietDAO dao = new DietDAO();
        
        try {
            
            HashMap<String,Integer> map = dao.getCount(dietNo);
            
            // 성공 응답 반환
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            PrintWriter writer = resp.getWriter();
            
            writer.print("""
                    {
                        "recommend": %d,
                        "disrecommend": %d
                    }
                    """.formatted(map.get("recommend"), map.get("disrecommend")));
            
            writer.close();
            
        } catch (Exception e) {
            // 오류 응답 반환
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("즐겨찾기 처리 중 오류 발생: " + e.getMessage());
        }
    }


}
