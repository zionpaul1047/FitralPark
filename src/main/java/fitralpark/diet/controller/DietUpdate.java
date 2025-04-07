package fitralpark.diet.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.diet.dao.DietDAO;

@WebServlet("/dietupdate.do")
public class DietUpdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        int dietNo = Integer.parseInt(req.getParameter("dietNo"));
        String type = req.getParameter("type");
        
        // DAO 인스턴스 생성
        DietDAO dietDAO = new DietDAO();
        
       
        
        int count = 0;
        
        if (type.equals("recommend")) {
            //추천수 업데이트
            count = dietDAO.incrementRecommend(dietNo);
        } else if (type.equals("disrecommend")) {        
            // 비추천수 업데이트
            count = dietDAO.incrementDisrecommend(dietNo);
        } else if(type.equals("views")) {
            // 조회수 업데이트
            count = dietDAO.incrementViews(dietNo);
        }
        
        // JSON 응답 생성
        PrintWriter out = resp.getWriter();
        out.print("""
                {
                    "success": true,
                    "count": %d
                }
                """.formatted(count));
        out.flush();
        
        
    }
}

