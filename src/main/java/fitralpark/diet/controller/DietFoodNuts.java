package fitralpark.diet.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import fitralpark.diet.dao.DietDAO;

@WebServlet("/getFoodNuts.do")
public class DietFoodNuts extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        
        int dietNo = Integer.parseInt(req.getParameter("dietNo"));
        
        System.out.println("dietNo: " + dietNo);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        try {            
            // DAO 인스턴스 생성
            DietDAO dietDAO = new DietDAO();
            
            // 음식 영양소 정보 가져오기
            List<Map<String, Object>> foods = dietDAO.getFoodNuts(dietNo);
            
            
            // 추천/비추천 정보 가져오기
            Map<String, Object> dietInfo = dietDAO.getDietRecommendInfo(dietNo);
            
            // JSON 응답 구성
            JSONObject result = new JSONObject();
            result.put("foods", foods);
            result.put("recommend", dietInfo.get("recommend"));
            result.put("disrecommend", dietInfo.get("disrecommend"));
            
            // 응답 전송
            PrintWriter out = resp.getWriter();
            out.print(result.toString());
            out.flush();
            
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JSONObject error = new JSONObject();
            error.put("error", "서버 오류: " + e.getMessage());
            
            PrintWriter out = resp.getWriter();
            out.print(error.toString());
            out.flush();
        }
        
    }


}
