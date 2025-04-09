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

/**
 * DietFoodNuts 서블릿 클래스는 특정 식단 번호를 기반으로 음식의 영양소 정보와 추천/비추천 정보를 조회하여 클라이언트에게 반환합니다.
 * 
 * <p>이 클래스는 다음과 같은 주요 기능을 제공합니다:
 * <ul>
 *   <li>음식의 영양소 정보 조회</li>
 *   <li>추천 및 비추천 정보 조회</li>
 *   <li>JSON 형식으로 클라이언트에게 응답 반환</li>
 * </ul>
 */
@WebServlet("/getFoodNuts.do")
public class DietFoodNuts extends HttpServlet {
    
    /**
     * GET 요청을 처리하는 메서드입니다.
     *
     * <p>클라이언트로부터 식단 번호를 받아 해당 식단의 음식 영양소 정보와 추천/비추천 정보를 조회합니다.
     * 조회된 데이터는 JSON 형식으로 클라이언트에게 반환됩니다.
     *
     * @param req HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @throws ServletException 서블릿 처리 중 오류 발생 시
     * @throws IOException 입출력 처리 중 오류 발생 시
     */

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        /**
         * 요청 파라미터에서 식단 번호를 추출합니다.
         */
        int dietNo = Integer.parseInt(req.getParameter("dietNo"));
        
        System.out.println("dietNo: " + dietNo);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        try {            
            // DAO 인스턴스 생성
            DietDAO dietDAO = new DietDAO();
            
            /**
             * 특정 식단 번호에 포함된 음식의 영양소 정보를 가져옵니다.
             */
            List<Map<String, Object>> foods = dietDAO.getFoodNuts(dietNo);
            
            
            /**
             * 특정 식단 번호에 대한 추천 및 비추천 정보를 가져옵니다.
             */
            Map<String, Object> dietInfo = dietDAO.getDietRecommendInfo(dietNo);
            
            /* JSON 응답 구성*/
            JSONObject result = new JSONObject();
            result.put("foods", foods);
            result.put("recommend", dietInfo.get("recommend"));
            result.put("disrecommend", dietInfo.get("disrecommend"));
            
            /* 응답 전송*/
            PrintWriter out = resp.getWriter();
            out.print(result.toString());
            out.flush();
            
        } catch (Exception e) {
            /**
             * 서버 오류가 발생한 경우, HTTP 상태 코드 500과 함께 오류 메시지를 반환합니다.
             */
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JSONObject error = new JSONObject();
            error.put("error", "서버 오류: " + e.getMessage());
            
            PrintWriter out = resp.getWriter();
            out.print(error.toString());
            out.flush();
        }
        
    }


}
