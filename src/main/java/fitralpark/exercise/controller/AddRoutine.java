package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import fitralpark.exercise.dao.RoutineDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/exercise/addRoutine.do")
public class AddRoutine extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        PrintWriter writer = resp.getWriter();
        JsonObject result = new JsonObject();
        
        try {
            // 세션에서 로그인 사용자 정보 가져오기
            HttpSession session = req.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
            
            if (loginUser == null) {
                result.addProperty("success", false);
                result.addProperty("message", "로그인이 필요합니다.");
                writer.write(result.toString());
                return;
            }
            
            // JSON 요청 데이터 파싱
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = req.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            Gson gson = new Gson();
            Map<String, Object> data = gson.fromJson(sb.toString(), Map.class);
            
            String routineName = (String) data.get("routineName");
            String routineCategory = (String) data.get("routineCategory");
            String publicCheck = String.valueOf(data.get("publicCheck"));
            List<Map<String, Object>> exercises = (List<Map<String, Object>>) data.get("exercises");
            boolean addToFavorites = (Boolean) data.get("addToFavorites");
            
            // 루틴 등록
            RoutineDAO dao = new RoutineDAO();
            String routineNo = dao.insertRoutine(routineName, routineCategory, publicCheck, loginUser.getMemberId());
            
            if (routineNo != null) {
                System.out.println("Routine created with ID: " + routineNo);
                // 운동 등록
                for (Map<String, Object> exercise : exercises) {
                    String exerciseId = String.valueOf(exercise.get("exerciseNo"));
                    String sets = String.valueOf(exercise.get("sets"));
                    String repsPerSet = String.valueOf(exercise.get("repsPerSet"));
                    String exerciseTime = String.valueOf(exercise.get("exerciseTime"));
                    String weight = String.valueOf(exercise.get("weight"));
                    
                    System.out.println("Processing exercise: " + exerciseId);
                    System.out.println("Sets: " + sets + ", Reps: " + repsPerSet + ", Time: " + exerciseTime + ", Weight: " + weight);
                    
                    dao.insertRoutineExercise(routineNo, exerciseId, sets, repsPerSet, exerciseTime, weight);
                }
                
                // TODO: 즐겨찾기 등록 로직 추가 (addToFavorites가 true인 경우)
                
                result.addProperty("success", true);
            } else {
                result.addProperty("success", false);
            }
            
            dao.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            result.addProperty("success", false);
        }
        
        writer.write(result.toString());
    }
} 