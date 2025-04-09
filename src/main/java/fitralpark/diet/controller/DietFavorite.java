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

/**
 * DietFavorite 서블릿 클래스는 특정 식단에 대해 즐겨찾기 추가/삭제 작업을 처리합니다.
 * 
 * <p>이 클래스는 다음과 같은 주요 기능을 제공합니다:
 * <ul>
 *   <li>즐겨찾기 추가 또는 삭제</li>
 *   <li>JSON 형식으로 클라이언트에게 응답 반환</li>
 * </ul>
 */
@WebServlet("/dietFavorite.do")
public class DietFavorite extends HttpServlet {

    /**
     * GET 요청을 처리하는 메서드입니다.
     *
     * <p>클라이언트로부터 회원 ID와 식단 번호를 받아 즐겨찾기 상태를 변경합니다.
     * 성공 또는 실패 여부를 JSON 형식으로 클라이언트에게 반환합니다.
     *
     * @param req HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @throws ServletException 서블릿 처리 중 오류 발생 시
     * @throws IOException 입출력 처리 중 오류 발생 시
     */
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        
        /**
         * 요청 파라미터에서 회원 ID와 식단 번호를 추출합니다.
         */
        String memberId = req.getParameter("memberId");
        String dietNo = req.getParameter("dietNo");
        boolean isCurrentlyBookmarked;
        
        System.out.println("memberId: " + memberId);
        System.out.println("dietNo: " + dietNo);
        
        DietDAO dao = new DietDAO();
        Map<String, Object> result = new HashMap<>();
        
        try {
            
            /**
             * 즐겨찾기 상태를 변경합니다.
             */
            dao.editBookmark(dietNo, memberId);
            
            // 성공 응답 반환
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(resp.getWriter(), result);
            
        } catch (Exception e) {
            /**
             * 서버 오류가 발생한 경우, HTTP 상태 코드 500과 함께 오류 메시지를 반환합니다.
             */
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("즐겨찾기 처리 중 오류 발생: " + e.getMessage());
        }
    }


}
