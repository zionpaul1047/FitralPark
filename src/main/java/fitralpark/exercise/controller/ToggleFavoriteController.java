package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.RoutineDAO;

@WebServlet("/exercise/toggleFavorite.do")
public class ToggleFavoriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(ToggleFavoriteController.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String memberId = request.getParameter("memberId");
        String routineNo = request.getParameter("routineNo");
        String action = request.getParameter("action");
        
        logger.info("ToggleFavorite request - memberId: " + memberId + ", routineNo: " + routineNo + ", action: " + action);
        
        if (memberId == null || routineNo == null || action == null) {
            logger.warning("Missing parameters - memberId: " + memberId + ", routineNo: " + routineNo + ", action: " + action);
            out.print("{\"success\":false, \"error\":\"필수 파라미터가 누락되었습니다.\"}");
            return;
        }
        
        RoutineDAO dao = new RoutineDAO();
        
        try {
            if ("add".equals(action)) {
                boolean success = dao.addFavorite(memberId, routineNo);
                logger.info("Add favorite result: " + success);
                out.print("{\"success\":" + success + "}");
            } else if ("remove".equals(action)) {
                boolean success = dao.removeFavorite(memberId, routineNo);
                logger.info("Remove favorite result: " + success);
                out.print("{\"success\":" + success + "}");
            } else if ("check".equals(action)) {
                boolean isFavorite = dao.isFavorite(memberId, routineNo);
                logger.info("Check favorite result: " + isFavorite);
                out.print("{\"isFavorite\":" + isFavorite + "}");
            } else {
                logger.warning("Invalid action: " + action);
                out.print("{\"success\":false, \"error\":\"잘못된 액션입니다.\"}");
            }
        } catch (Exception e) {
            logger.severe("Error in ToggleFavoriteController: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false, \"error\":\"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
} 