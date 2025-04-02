package fitralpark.nutrition.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.nutrition.dao.NutritionDAO;
import fitralpark.nutrition.dto.NutritionDTO;

@WebServlet("/nutrition/foodsearch.do")
public class NutritionSearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 검색어 가져오기
        String keyword = req.getParameter("query");

        // DAO 호출 및 결과 가져오기
        NutritionDAO dao = new NutritionDAO();
        List<NutritionDTO> results = dao.searchFoods(keyword);

        // 세션에 결과 저장
        HttpSession session = req.getSession();
        session.setAttribute("results", results);

        // JSP로 포워딩
        req.getRequestDispatcher("/WEB-INF/views/nutrition/foodsearch.jsp").forward(req, resp);
    }
}
