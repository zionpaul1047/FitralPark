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

/**
 * 클래스 설명: 루틴 생성 페이지에 운동 불러오기를 눌렀을때 팝업창이 생성되고 운동 목록을 보여주는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
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

