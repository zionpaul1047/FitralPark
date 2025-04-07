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

@WebServlet("/dietFoodLoading.do")
public class DietFoodLoading extends HttpServlet {
    
    private final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        /// 세션에서 사용자 ID 추출
        HttpSession session = req.getSession();
        String memberId = (String) session.getAttribute("memberId");
        if (memberId == null)
            memberId = "guest";
    

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
            list = dao.getFoods(begin, end, memberId);
            System.out.println(list);

            //커스텀푸드로 변경
            
            
            req.setAttribute("isSearch", true);

        }

        int totalCount = dao.getTotalCount(memberId);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        req.setAttribute("list", list);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/WEB-INF/views/diet/dietFoodLoading.jsp").forward(req, resp);
    }

}

