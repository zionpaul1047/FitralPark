package fitralpark.nutrition.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.nutrition.dao.NutritionDAO;
import fitralpark.nutrition.dto.NutritionDTO;

@WebServlet("/nutrition/foodsearch.do")
public class NutritionSearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NutritionDAO nutritionDAO = new NutritionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 검색어 파라미터 가져오기
        String keyword = request.getParameter("query");
        String pageParam = request.getParameter("page");
        int currentPage = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
        int resultsPerPage = 15; // 한 페이지에 보여줄 결과 수

        // 검색어가 없으면 foodsearch.jsp로 이동
        if (keyword == null || keyword.trim().isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(request, response);
            return;
        }

        try {
            // 총 검색 결과 개수 가져오기
            int totalResults = nutritionDAO.getTotalResults(keyword);
            int totalPages = (int) Math.ceil((double) totalResults / resultsPerPage);

            // 현재 페이지에 해당하는 데이터 가져오기
            int startRow = (currentPage - 1) * resultsPerPage + 1;
            int endRow = currentPage * resultsPerPage;
            List<NutritionDTO> results = nutritionDAO.searchFoods(keyword, startRow, endRow);

            
            
            // 각 음식 이름에 대해 첫 번째 이미지 URL 가져오기
//            for (NutritionDTO item : results) {
//                String imageUrl = NutritionImageSearch.getFirstImageURL(item.getFood_name());
//                item.setFood_img_croll(imageUrl); // DTO에 이미지 URL 저장 (foodLv4Nm 필드 사용)
//            }
            
            
            

            // 페이지네이션 범위 계산
            int pageRange = 9; // 한 번에 보여줄 페이지 번호 개수
            int startPage = Math.max(1, currentPage - (pageRange / 2)); // 현재 페이지 기준으로 앞뒤로 나눔
            int endPage = Math.min(startPage + pageRange - 1, totalPages); // 최대 페이지를 초과하지 않도록 설정

            // startPage와 endPage 조정 (항상 pageRange 크기를 유지)
            if ((endPage - startPage + 1) < pageRange) {
                startPage = Math.max(1, endPage - pageRange + 1);
            }

            
            // 결과 저장
            request.setAttribute("results", results);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            // AJAX 요청인지 확인
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(xRequestedWith);

            if (isAjax) {
                response.setContentType("text/html; charset=UTF-8");
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch_results.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "검색 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
