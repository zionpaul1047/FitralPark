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

		String memberId = (String) req.getSession().getAttribute("id");
        if (memberId == null) memberId = "test"; // 테스트용

        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");

        ExerciseDAO dao = new ExerciseDAO();

        List<ExerciseDTO> exerciseList = dao.getExerciseList(keyword, category);
        List<ExerciseDTO> customExerciseList = dao.getCustomExerciseList(memberId, keyword, category);

        dao.close();

        req.setAttribute("exerciseList", exerciseList);
        req.setAttribute("customExerciseList", customExerciseList);
        req.getRequestDispatcher("/WEB-INF/views/exercise/routineAddExerciseList.jsp").forward(req, resp);
	}
	
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 사용자가 입력한 운동명, 열량 등 받아서 DB에 insert

        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("exerciseName");
        String calories = req.getParameter("caloriesPerUnit");
        String category = req.getParameter("category");
        String part = req.getParameter("part");
        String memberId = (String) req.getSession().getAttribute("id");
        if (memberId == null) memberId = "test"; // 테스트 계정

        ExerciseDAO dao = new ExerciseDAO();
        int result = dao.insertCustomExercise(name, calories, category, part, memberId);
        dao.close();

        // 등록 후 다시 목록 페이지로 리다이렉트
        resp.sendRedirect("/fitralpark/exercise/routineAddExerciseList.do");
    }

}

