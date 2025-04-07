package fitralpark.exercise.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.exercise.dao.ExerciseDAO;
import fitralpark.exercise.dto.ExerciseDTO;
import fitralpark.user.dto.UserDTO;

@WebServlet("/exercise/routineAddExerciseList.do")
public class RoutineAddExerciseList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		String memberId = loginUser.getMemberId();
		
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

}

