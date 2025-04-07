package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import fitralpark.exercise.dao.RoutineDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/exercise/toggleFavorite.do")
public class ToggleFavoriteController extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        JsonObject result = new JsonObject();
        
        if (loginUser == null) {
            result.addProperty("success", false);
            result.addProperty("message", "로그인이 필요합니다.");
        } else {
            String memberId = loginUser.getMemberId();
            String routineNo = req.getParameter("routineNo");

            RoutineDAO dao = new RoutineDAO();
            boolean isFavorite = dao.isFavoriteRoutine(memberId, routineNo);

            boolean success;
            if (isFavorite) {
                success = dao.removeFavoriteRoutine(memberId, routineNo);
            } else {
                success = dao.addFavoriteRoutine(memberId, routineNo);
            }

            dao.close();
            result.addProperty("success", success);
            result.addProperty("favorite", !isFavorite);
        }

        PrintWriter writer = resp.getWriter();
        writer.print(result.toString());
        writer.close();
    	
    }
    
} 