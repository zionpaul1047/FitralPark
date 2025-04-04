package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.exercise.dto.ExerciseDTO;

@WebServlet("/exercise/getSelectedExercises.do")
public class GetSelectedExercises extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String exerciseNos = req.getParameter("exerciseNos");
        System.out.println("Received exercise numbers: " + exerciseNos);
        
        if (exerciseNos == null || exerciseNos.trim().isEmpty()) {
            sendErrorResponse(resp, "선택된 운동이 없습니다.");
            return;
        }
        
        ExerciseDAO dao = new ExerciseDAO();
        try {
            List<ExerciseDTO> exercises = dao.getSelectedExercises(exerciseNos.split(","));
            System.out.println("Retrieved exercises: " + exercises);
            
            List<Map<String, Object>> responseList = new ArrayList<>();
            
            for (ExerciseDTO exercise : exercises) {
                Map<String, Object> map = new HashMap<>();
                
                // 일반 운동과 커스텀 운동을 통합하여 처리
                String exerciseNo = exercise.getExerciseNo() != null ? 
                    exercise.getExerciseNo() : 
                    "C" + exercise.getCustomExerciseNo();
                    
                String exerciseName = exercise.getExerciseName() != null ? 
                    exercise.getExerciseName() : 
                    exercise.getCustomExerciseName();
                    
                String categoryName = exercise.getExerciseCategoryName() != null ? 
                    exercise.getExerciseCategoryName() : 
                    exercise.getCustomExerciseCategoryName();
                    
                String partName = exercise.getExercisePartName() != null ? 
                    exercise.getExercisePartName() : 
                    exercise.getCustomExercisePartName();
                    
                String calories = exercise.getCaloriesPerUnit() != null ? 
                    exercise.getCaloriesPerUnit() : 
                    exercise.getCustomCaloriesPerUnit();
                
                map.put("exerciseNo", exerciseNo);
                map.put("exerciseName", exerciseName);
                map.put("exerciseCategoryName", categoryName);
                map.put("exercisePartName", partName);
                map.put("caloriesPerUnit", calories);
                
                responseList.add(map);
            }
            
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(responseList);
            System.out.println("Sending JSON response: " + jsonResponse);
            
            PrintWriter writer = resp.getWriter();
            writer.print(jsonResponse);
            writer.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(resp, "운동 정보를 가져오는데 실패했습니다.");
        } finally {
            dao.close();
        }
    }
    
    private void sendErrorResponse(HttpServletResponse resp, String message) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        Map<String, String> errorResponse = new HashMap<>();
        errorResponse.put("error", message);
        writer.print(new Gson().toJson(errorResponse));
        writer.flush();
    }
} 