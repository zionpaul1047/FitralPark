package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fitralpark.exercise.dao.ExerciseDAO;

@WebServlet("/addCustomExercise.do")
public class addCustomExercise extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//addCustomExercise.java
		// 사용자가 입력한 운동명, 열량 등 받아서 DB에 insert
		
				HttpSession session = req.getSession();
				
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

