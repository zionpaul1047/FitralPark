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
 * DietFoodLoading 서블릿 클래스는 특정 식단 번호를 기반으로 음식 데이터를 조회하여 클라이언트에게 전달합니다.
 * 
 * <p>이 클래스는 다음과 같은 주요 기능을 제공합니다:
 * <ul>
 *   <li>음식 데이터 불러오기 및 조회</li>
 *   <li>검색 조건에 따른 데이터 필터링</li>
 *   <li>JSP 페이지로 데이터 전달</li>
 * </ul>
 */
@WebServlet("/dietFoodLoading.do")
public class DietFoodLoading extends HttpServlet {
    
    /** 한 페이지에 표시할 데이터 수 */
    private final int PAGE_SIZE = 10;

    /**
     * GET 요청을 처리하는 메서드입니다.
     *
     * <p>클라이언트의 요청 파라미터를 기반으로 음식 데이터를 조회하고,
     * JSP 페이지로 전달합니다. 검색 조건이 있을 경우 필터링된 데이터를 반환합니다.
     *
     * @param req HttpServletRequest 객체 (클라이언트 요청 정보 포함)
     * @param resp HttpServletResponse 객체 (클라이언트 응답 정보 포함)
     * @throws ServletException 서블릿 처리 중 오류 발생 시
     * @throws IOException 입출력 처리 중 오류 발생 시
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        /**
         * 세션에서 사용자 ID를 추출합니다.
         * 만약 세션에 사용자 ID가 없으면 "guest"로 설정됩니다.
         */
        HttpSession session = req.getSession();
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null)
            memberId = "guest";
    

        // DAO 호출
        DietDAO dao = new DietDAO();

        /**
         * 현재 페이지 번호를 추출합니다.
         * 만약 페이지 번호가 없거나 잘못된 경우 기본값으로 1을 사용합니다.
         */
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

            // 검색O

            /**
             * 검색 조건이 있는 경우, 파라미터를 추출하여 데이터를 필터링합니다.
             */
            int calorieMin = Integer.parseInt(req.getParameter("calorieMin"));
            int calorieMax = Integer.parseInt(req.getParameter("calorieMax"));
            String mealClassify = req.getParameter("mealClassify");
            String searchTerm = req.getParameter("searchTerm");
            boolean favoriteFilter = req.getParameter("favoriteFilter") != null ? true : false;
            boolean myMealFilter = req.getParameter("myMealFilter") != null ? true : false;

            list = dao.searchDiets(calorieMin, calorieMax, mealClassify, searchTerm, favoriteFilter, myMealFilter, memberId, begin, end);
            
            req.setAttribute("isSearch", false);

        } else {

            /**
             * 검색 조건이 없는 경우, 전체 데이터를 조회합니다.
             */
            list = dao.getFoods(begin, end, memberId);
            System.out.println(list);

            //커스텀푸드로 변경
            
            
            req.setAttribute("isSearch", true);

        }
        
        /**
         * 전체 페이지 수를 계산하고 요청 속성을 설정합니다.
         */
        int totalCount = dao.getTotalCount(memberId);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        req.setAttribute("list", list);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/views/diet/dietFoodLoading.jsp").forward(req, resp);
    }

}

