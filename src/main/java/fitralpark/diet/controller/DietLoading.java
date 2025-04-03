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
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import fitralpark.diet.dao.DietDAO;
import fitralpark.diet.dto.DietDTO;

@WebServlet("/dietLoading.do")
public class DietLoading extends HttpServlet {

    private final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 세션에서 사용자 ID 추출
        HttpSession session = req.getSession();
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null)
            memberId = "guest";

        // 여기까지
        // AJAX 요청인지 확인 (상세정보 요청)
        String dietNoParam = req.getParameter("dietNo");
        if (dietNoParam != null) {
            handleFoodDetailsRequest(req, resp, Integer.parseInt(dietNoParam));
            return;
        }

        // DAO 호출
        DietDAO dao = new DietDAO();

        // 페이지네이션 처리
        if (memberId == null)
            memberId = "guest";

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

            // 파라미터 추출
            int calorieMin = Integer.parseInt(req.getParameter("calorieMin"));
            int calorieMax = Integer.parseInt(req.getParameter("calorieMax"));
            String mealClassify = req.getParameter("mealClassify");
            String searchTerm = req.getParameter("searchTerm");
            boolean favoriteFilter = req.getParameter("favoriteFilter") != null ? true : false;
            boolean myMealFilter = req.getParameter("myMealFilter") != null ? true : false;

            list = dao.searchDiets(calorieMin, calorieMax, mealClassify, searchTerm, favoriteFilter, myMealFilter, memberId, begin, end);
            
            req.setAttribute("isSearch", false);

        } else {

            // 검색X
            list = dao.getDiets(begin, end, memberId);
            
            req.setAttribute("isSearch", true);

        }

        int totalCount = dao.getTotalCount(memberId);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        req.setAttribute("list", list);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/views/diet/dietLoading.jsp").forward(req, resp);

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
