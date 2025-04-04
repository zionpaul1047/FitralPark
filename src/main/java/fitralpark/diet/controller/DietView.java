package fitralpark.diet.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import fitralpark.diet.dao.DietDAO;

@WebServlet("/dietView.do")
public class DietView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //DietView.java
        //
        // AJAX 요청인지 확인 (상세정보 요청)
        String dietNoParam = req.getParameter("dietNo");
        if (dietNoParam != null) {
            handleFoodDetailsRequest(req, resp, Integer.parseInt(dietNoParam));
            return;
        }
    }
    
    /**
     * AJAX 요청으로 음식 상세정보를 반환하는 메서드
     */
    private void handleFoodDetailsRequest(HttpServletRequest req, HttpServletResponse resp, int dietNo)
            throws IOException {

        DietDAO dao = new DietDAO();

        // 식단 이름 조회
        String dietName = dao.getDietName(dietNo);

        // 음식 상세 정보 조회
        List<Map<String, Object>> foods = dao.getFoodDetails(dietNo);

        System.out.println("foods: " + foods);

        // JSON 응답 생성
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        ObjectMapper mapper = new ObjectMapper();

        Map<String, Object> result = new HashMap<>();
        result.put("dietName", dietName);
        result.put("foods", foods);

        mapper.writeValue(resp.getWriter(), result);

    }
    

}
