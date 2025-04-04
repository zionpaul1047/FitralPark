package fitralpark.nutrition.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.nutrition.dao.NutritionDAO;
import fitralpark.nutrition.dto.NutritionDTO;

@WebServlet({"/nutrition/foodsearch.do", "/nutrition/foodsearch_favorite.do"})
public class NutritionSearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NutritionDAO nutritionDAO = new NutritionDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 어떤 요청 경로로 왔는지 확인
        String requestURI = request.getRequestURI();
        
        // 요청이 AJAX인지 확인
        String xRequestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(xRequestedWith);
        
        if (requestURI.endsWith("/foodsearch_favorite.do")) {
            // 즐겨찾기 요청 처리
            handleFavorites(request, response, isAjax);
        } else {
            // 일반 검색 요청 처리
            handleSearch(request, response, isAjax);
        }
    }
    
    // 즐겨찾기 요청 처리 메서드
    private void handleFavorites(HttpServletRequest request, HttpServletResponse response, boolean isAjax) 
            throws ServletException, IOException {
        try {
            // 여기서 즐겨찾기 데이터를 가져오는 DAO 메서드를 호출
            // 아직 구현되지 않았으므로 빈 리스트를 반환
            List<NutritionDTO> favorites = new ArrayList<>(); // 실제로는 DAO에서 즐겨찾기 목록을 가져와야 함
            
            request.setAttribute("favorites", favorites);
            
            if (isAjax) {
                // AJAX 요청일 경우 즐겨찾기 부분만 반환
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch_favorite.jsp").forward(request, response);
            } else {
                // 일반 요청일 경우 전체 페이지 반환 (즐겨찾기 섹션이 표시됨)
                request.setAttribute("section", "favorite");
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) {
                response.getWriter().write("<div class='error_message'><p>즐겨찾기를 불러오는 중 오류가 발생했습니다.</p></div>");
            } else {
                request.setAttribute("error", "즐겨찾기를 불러오는 중 오류가 발생했습니다.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            }
        }
    }
    
    // 검색 요청 처리 메서드
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, boolean isAjax) 
            throws ServletException, IOException {
        // 검색어 파라미터 가져오기
        String keyword = request.getParameter("query");
        System.out.println("검색어: [" + keyword + "]");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            // 검색어가 없으면 전체 페이지 반환
            if (isAjax) {
                response.getWriter().write("<div class='no_results_message'><p>검색어를 입력해 주세요.</p></div>");
            } else {
                request.setAttribute("section", "search");
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(request, response);
            }
            return;
        }
        
        try {
            // 검색 실행
            List<NutritionDTO> results = nutritionDAO.searchFoods(keyword);
            
            // 결과 저장
            request.setAttribute("results", results);
            
            if (isAjax) {
                // AJAX 요청일 경우 결과 부분만 반환
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch_results.jsp").forward(request, response);
            } else {
                // 일반 요청일 경우 전체 페이지 반환 (검색 결과 섹션이 표시됨)
                request.setAttribute("section", "search");
                request.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) {
                response.getWriter().write("<div class='error_message'><p>검색 중 오류가 발생했습니다.</p></div>");
            } else {
                request.setAttribute("error", "검색 중 오류가 발생했습니다.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // POST 요청도 GET과 동일하게 처리
        doGet(request, response);
    }
}
