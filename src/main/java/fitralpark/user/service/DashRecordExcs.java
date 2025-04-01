package fitralpark.user.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dashrecordexcs.do")
public class DashRecordExcs extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DashRecordExcs.java
		String sets = req.getParameter("sets");
		String reps_per_set = req.getParameter("reps_per_set");
		String weight = req.getParameter("weight");
		String exercise_time = req.getParameter("exercise_time");
		String exercise_no = req.getParameter("exercise_no");
		String exercise_creation_type = req.getParameter("exercise_creation_type");
		
		System.out.println(sets);
		System.out.println(reps_per_set);
		System.out.println(weight);
		System.out.println(exercise_time);
		System.out.println(exercise_no);
		System.out.println(exercise_creation_type);

	}

}