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

import fitralpark.exercise.dao.RoutineDAO;
import fitralpark.exercise.dto.RoutineDTO;
import fitralpark.exercise.dto.RoutineExerciseDTO;

@WebServlet("/getExerciseList.do")
public class GetExerciseListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
        String routineNo = req.getParameter("routineNo");

        RoutineDAO dao = new RoutineDAO();
        ArrayList<RoutineExerciseDTO> exerciseList = dao.exerciseList(routineNo);
        RoutineDTO routineInfo = dao.getRoutineInfo(routineNo);
        
        dao.close();

        req.setAttribute("exerciseList", exerciseList);
        req.setAttribute("routineInfo", routineInfo);
        req.getRequestDispatcher("/WEB-INF/views/exercise/getExerciseList.jsp").forward(req, resp);
	}
	

}

