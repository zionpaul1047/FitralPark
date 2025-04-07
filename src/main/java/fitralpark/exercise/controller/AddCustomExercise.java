package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/exercise/addCustomExercise.do")
public class AddCustomExercise extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//AddCustomExercise.java
		req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        String memberId = loginUser.getMemberId();

        String[] exerciseNames = req.getParameterValues("exerciseName");
        String[] categories = req.getParameterValues("exerciseCategory");
        String[] parts = req.getParameterValues("exercisePart");
        String[] calories = req.getParameterValues("caloriesPerUnit");

        // 파라미터 유효성 검사
        if (exerciseNames == null || categories == null || parts == null || calories == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "필수 파라미터가 누락되었습니다.");
            return;
        }

        ExerciseDAO dao = new ExerciseDAO();

        for (int i = 0; i < exerciseNames.length; i++) {
            String name = exerciseNames[i];
            String categoryNo = categories[i];
            String partNo = parts[i];
            String kcal = calories[i];

            // 각 필드의 유효성 검사
            if (name == null || name.trim().isEmpty() || 
                categoryNo == null || categoryNo.trim().isEmpty() ||
                partNo == null || partNo.trim().isEmpty() ||
                kcal == null || kcal.trim().isEmpty()) {
                continue; // 유효하지 않은 데이터는 건너뜀
            }

            // 1. custom_exercise 테이블에 insert
            String customExerciseNo = dao.insertCustomExercise(name, kcal, memberId);

            // 2. category group 테이블에 insert
            dao.insertCustomExerciseCategoryGroup(customExerciseNo, categoryNo);

            // 3. part link 테이블에 insert
            dao.insertCustomExercisePartLink(customExerciseNo, partNo);
        }

        dao.close();

        resp.sendRedirect("/fitralpark/exercise/routineAddExerciseList.do");
		
	}

}

