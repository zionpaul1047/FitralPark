package fitralpark.user.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dto.ExerciseRecordDTO;
import fitralpark.user.dao.UserDAO;

@WebServlet("/dashrecordexcs.do")
public class DashRecordExcs extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DashRecordExcs.java
		String id = req.getParameter("id");
		
		String sets = req.getParameter("sets");
		String reps_per_set = req.getParameter("reps_per_set");
		String weight = req.getParameter("weight");
		String exercise_time = req.getParameter("exercise_time");
		String exercise_no = req.getParameter("exercise_no");
		String exercise_creation_type = req.getParameter("exercise_creation_type");
		
//		System.out.println("sets: " + sets);
//		System.out.println("reps_per_set: " + reps_per_set);
//		System.out.println("weight: " + weight);
//		System.out.println("exercise_time: " + exercise_time);
//		System.out.println("exercise_no: " + exercise_no);
//		System.out.println("exercise_creation_type: " + exercise_creation_type);
		
		ExerciseRecordDTO dto = new ExerciseRecordDTO();
		
		dto.setCreatorId(id);
		dto.setSets(sets);
		dto.setRepsPerSet(reps_per_set);
		dto.setWeight(weight);
		dto.setExerciseTime(exercise_time);
		dto.setExerciseNo(exercise_no);
		dto.setExerciseCreationType(exercise_creation_type);
		
		
		UserDAO dao = new UserDAO();
		int result = dao.tdyRecordExcs(dto);
		
		dao.close();
		
		PrintWriter writer = resp.getWriter();
		writer.print("""
				{
					"result": %d
				}
				""".formatted(result));
		
		writer.close();
		
	}

}