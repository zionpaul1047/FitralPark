package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.ExerciseDAO;

@WebServlet("/exercise/updateCustomExercise.do")
public class UpdateCustomExercise extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String customExerciseNo = req.getParameter("customExerciseNo");
        String exerciseName = req.getParameter("exerciseName");
        String exerciseCategory = req.getParameter("exerciseCategory");
        String exercisePart = req.getParameter("exercisePart");
        String caloriesPerUnit = req.getParameter("caloriesPerUnit");
        
        ExerciseDAO dao = new ExerciseDAO();
        
        // 1. custom_exercise 테이블 업데이트
        dao.updateCustomExercise(customExerciseNo, exerciseName, caloriesPerUnit);
        
        // 2. category group 업데이트
        dao.updateCustomExerciseCategory(customExerciseNo, exerciseCategory);
        
        // 3. part link 업데이트
        dao.updateCustomExercisePart(customExerciseNo, exercisePart);
        
        dao.close();
        
        resp.sendRedirect("/fitralpark/exercise/routineAddExerciseList.do");
    }
} 