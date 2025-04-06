package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.RoutineDAO;

@WebServlet("/exercise/getFavorites.do")
public class GetFavoritesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String memberId = request.getParameter("memberId");
        
        if (memberId == null || memberId.trim().isEmpty()) {
            out.print("{\"success\":false, \"error\":\"회원 ID가 필요합니다.\"}");
            return;
        }
        
        RoutineDAO dao = new RoutineDAO();
        List<String> favorites = new ArrayList<>();
        
        try {
            // 모든 루틴에 대해 즐겨찾기 여부 확인
            List<String> allRoutines = dao.getAllRoutineNos();
            for (String routineNo : allRoutines) {
                if (dao.isFavorite(memberId, routineNo)) {
                    favorites.add(routineNo);
                }
            }
            
            out.print("{\"success\":true, \"favorites\":" + favorites + "}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false, \"error\":\"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
} 