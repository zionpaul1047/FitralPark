package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.ExerciseDAO;

@WebServlet("/exercise/deleteCustomExercise.do")
public class DeleteCustomExercise extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String customExerciseNo = req.getParameter("customExerciseNo");
        
        if (customExerciseNo == null || customExerciseNo.trim().isEmpty()) {
            sendErrorResponse(resp, "운동 번호가 유효하지 않습니다.");
            return;
        }
        
        ExerciseDAO dao = new ExerciseDAO();
        boolean success = false;
        
        try {
            success = dao.deleteCustomExercise(customExerciseNo);
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(resp, "삭제 중 오류가 발생했습니다: " + e.getMessage());
            return;
        } finally {
            dao.close();
        }
        
        // JSON 응답 설정
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        PrintWriter writer = resp.getWriter();
        writer.print("{\"success\": " + success + "}");
        writer.flush();
    }
    
    private void sendErrorResponse(HttpServletResponse resp, String message) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        writer.print("{\"success\": false, \"message\": \"" + message + "\"}");
        writer.flush();
    }
} 