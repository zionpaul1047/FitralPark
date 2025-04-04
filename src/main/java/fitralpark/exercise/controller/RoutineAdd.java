package fitralpark.exercise.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.exercise.dto.ExerciseDTO;

@WebServlet("/exercise/routineAdd.do")
public class RoutineAdd extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//RoutineAdd.java
			

		req.getRequestDispatcher("/WEB-INF/views/exercise/routineAdd.jsp").forward(req, resp);
	}
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String[] exerciseNos = req.getParameterValues("exerciseNos");
        
        if (exerciseNos != null && exerciseNos.length > 0) {
            ExerciseDAO dao = new ExerciseDAO();
            try {
                // DTO 리스트로 데이터 받아오기
                List<ExerciseDTO> selectedExercises = dao.getSelectedExercises(exerciseNos);
                
                // request에 데이터 저장
                req.setAttribute("selectedExercises", selectedExercises);
                
                System.out.println("Selected exercises: " + selectedExercises); // 디버깅용
            } finally {
                dao.close();
            }
        }
        
        req.getRequestDispatcher("/WEB-INF/views/exercise/routineAdd.jsp").forward(req, resp);
    }

}
