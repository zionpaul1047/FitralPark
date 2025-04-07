package fitralpark.exercise.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import fitralpark.exercise.dao.RoutineDAO;
import fitralpark.exercise.dto.RoutineDTO;
import fitralpark.exercise.dto.RoutineExerciseDTO;

@WebServlet("/exercise/editRoutine.do")
public class EditRoutineController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String routineNo = req.getParameter("routineNo");
        
        RoutineDAO dao = new RoutineDAO();
        
        // 루틴 기본 정보 조회
        RoutineDTO routine = dao.getRoutineInfo(routineNo);
        
        // 루틴에 포함된 운동 목록 조회
        ArrayList<RoutineExerciseDTO> exercises = dao.exerciseList(routineNo);
        
        dao.close();
        
        // JSP에 데이터 전달
        req.setAttribute("routine", routine);
        req.setAttribute("exercises", exercises);
        
        // JSP로 포워딩
        req.getRequestDispatcher("/WEB-INF/views/exercise/routineEdit.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 루틴 수정 로직은 UpdateRoutineController에서 처리
    }
} 