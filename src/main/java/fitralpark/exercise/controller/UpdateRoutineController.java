package fitralpark.exercise.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.exercise.dto.ExerciseRecordDTO;

@WebServlet("/updateRoutine.do")
public class UpdateRoutineController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");

        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        try (BufferedReader reader = req.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        JsonObject json = JsonParser.parseString(jsonBuffer.toString()).getAsJsonObject();

        String routineNo = json.get("routineNo").getAsString();
        String routineName = json.get("routineName").getAsString();
        String routineCategory = json.get("routineCategory").getAsString();
        String publicCheck = json.get("publicCheck").getAsString();

        JsonArray exercisesJson = json.getAsJsonArray("exercises");
        List<ExerciseRecordDTO> exerciseList = new ArrayList<>();

        for (JsonElement e : exercisesJson) {
            JsonObject obj = e.getAsJsonObject();
            ExerciseRecordDTO dto = new ExerciseRecordDTO();

            String exId = obj.get("exerciseId").getAsString(); // ex_1 또는 cus_3

            if (exId.startsWith("ex_")) {
                dto.setExerciseNo(exId.replace("ex_", ""));
                dto.setExerciseCreationType("default");
            } else if (exId.startsWith("cus_")) {
                dto.setCustomExerciseNo(exId.replace("cus_", ""));
                dto.setExerciseCreationType("custom");
            }

            dto.setSets(obj.get("sets").getAsString());
            dto.setRepsPerSet(obj.get("repsPerSet").getAsString());
            dto.setExerciseTime(obj.get("exerciseTime").getAsString());
            dto.setWeight(obj.get("weight").getAsString());

            exerciseList.add(dto);
        }

        ExerciseDAO dao = new ExerciseDAO();
        boolean success = dao.updateRoutine(routineNo, routineName, routineCategory, publicCheck, exerciseList);

        JsonObject result = new JsonObject();
        result.addProperty("success", success);
        resp.getWriter().print(result.toString());
        
    }
} 