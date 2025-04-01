/**
 * 
 */
package fitralpark.exercise.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import fitralpark.exercise.dao.RoutineDAO;
import fitralpark.exercise.dto.RoutineExerciseDTO;

@WebServlet("/getExerciseList.do")
public class GetExerciseListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String routineNo = req.getParameter("routineNo");
		

        RoutineDAO dao = new RoutineDAO();
        ArrayList<RoutineExerciseDTO> exerciseList = dao.exerciseList(routineNo);
        dao.close();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        String json = gson.toJson(exerciseList);
        resp.getWriter().write(json);
	}
	

}

