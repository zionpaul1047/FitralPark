package fitralpark.diet.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.diet.dao.DietDAO;
import fitralpark.diet.dto.DietDTO;

/**
 * DietRecommendationController 서블릿 클래스는 추천 식단 데이터를 조회하고 클라이언트에게 전달하는 역할을 합니다.
 * 
 * <p>이 클래스는 다음과 같은 주요 기능을 제공합니다:
 * <ul>
 *   <li>추천 식단 목록 조회</li>
 *   <li>검색 조건에 따른 추천 식단 필터링</li>
 *   <li>JSP 페이지로 데이터 전달</li>
 * </ul>
 */
@WebServlet("/dietRecommend.do")
public class DietRecommendationController extends HttpServlet {
    
    private final int PAGE_SIZE = 10;
    
    /**
     * GET 요청을 처리하는 메서드입니다.
     *
     * <p>클라이언트의 요청 파라미터를 기반으로 추천 식단 데이터를 조회하고,
     * JSP 페이지로 전달합니다. 검색 조건이 있을 경우 필터링된 데이터를 반환합니다.
     *
     * @param req HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @throws ServletException 서블릿 처리 중 오류 발생 시
     * @throws IOException 입출력 처리 중 오류 발생 시
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 세션에서 사용자 ID 추출
        HttpSession session = req.getSession();
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null)
            memberId = "guest";
        
        memberId = "hong";


        // DAO 호출
        DietDAO dao = new DietDAO();
        
        String pageParam = req.getParameter("page");
        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        int begin = (currentPage - 1) * PAGE_SIZE + 1;
        int end = currentPage * PAGE_SIZE;

        List<DietDTO> list = null;

        if (req.getParameter("searchTerm") != null && !req.getParameter("searchTerm").equals("")) {

            // O

            /**
             * 검색 조건에 따라 추천 식단 데이터를 조회합니다.
             */

            // 파라미터 추출
            int calorieMin = Integer.parseInt(req.getParameter("calorieMin"));
            int calorieMax = Integer.parseInt(req.getParameter("calorieMax"));
            String mealClassify = req.getParameter("mealClassify");
            String searchTerm = req.getParameter("searchTerm");
            String dietCategory = req.getParameter("dietCategory");
            boolean favoriteFilter = req.getParameter("favoriteFilter") != null ? true : false;
            boolean myMealFilter = req.getParameter("myMealFilter") != null ? true : false;

            list = dao.searchRecomDiets(calorieMin, calorieMax, mealClassify, searchTerm, dietCategory, favoriteFilter, myMealFilter, memberId, begin, end);
            
            req.setAttribute("isSearch", false);

        } else {

            // 검색X
            /**
             * 검색 조건 없이 추천 식단 데이터를 조회합니다.
             */
            list = dao.getRecommendDiets(begin, end, memberId);
            
            req.setAttribute("isSearch", true);

        }

        int totalCount = dao.getTotalCount(memberId);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        
        /**
         * 요청 속성 설정 및 JSP로 포워딩합니다.
         */

        req.setAttribute("list", list);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/views/diet/dietRecommend.jsp").forward(req, resp);

    }
    
}
