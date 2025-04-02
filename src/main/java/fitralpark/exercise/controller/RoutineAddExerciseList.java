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

@WebServlet("/exercise/routineAddExerciseList.do")
public class RoutineAddExerciseList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//RoutineAddExerciseList.java
		String memberId = (String) req.getSession().getAttribute("id"); // 로그인 된 사용자 ID

        ExerciseDAO dao = new ExerciseDAO();

        // 일반 운동 목록
        List<ExerciseDTO> exerciseList = dao.getExerciseList();

        // 사용자 정의 운동 목록
        List<ExerciseDTO> customExerciseList = dao.getCustomExerciseList(memberId);

        dao.close();

        // request에 담아서 JSP로 전달
        req.setAttribute("exerciseList", exerciseList);
        req.setAttribute("customExerciseList", customExerciseList);

		req.getRequestDispatcher("/WEB-INF/views/exercise/routineAddExerciseList.jsp").forward(req, resp);
	}

}

