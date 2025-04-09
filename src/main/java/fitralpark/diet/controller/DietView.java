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


/**
 * DietView 서블릿 클래스는 식단 상세 정보를 AJAX 요청으로 처리하여 JSON 형식으로 반환합니다.
 * 
 * <p>이 클래스는 다음과 같은 주요 기능을 제공합니다:
 * <ul>
 *   <li>GET 요청을 처리하여 식단 상세 정보를 반환</li>
 *   <li>AJAX 요청을 통해 음식 상세 정보를 반환</li>
 * </ul>
 */
@WebServlet("/dietView.do")
public class DietView extends HttpServlet {
    
    /**
     * GET 요청을 처리하는 메서드입니다.
     *
     * <p>요청 파라미터에 따라 AJAX 요청인지 확인하고, 적절한 데이터를 반환합니다.
     *
     * @param req HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @throws ServletException 서블릿 처리 중 오류 발생 시
     * @throws IOException 입출력 처리 중 오류 발생 시
     */
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
     * AJAX 요청으로 음식 상세 정보를 반환하는 메서드입니다.
     *
     * <p>이 메서드는 특정 식단 번호에 해당하는 음식 상세 정보를 조회하고,
     * JSON 형식으로 클라이언트에게 응답합니다.
     *
     * @param req HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @param dietNo 식단 번호
     * @throws IOException 입출력 처리 중 오류 발생 시
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
