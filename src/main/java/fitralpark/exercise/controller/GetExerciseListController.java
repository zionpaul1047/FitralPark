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

/**
 * 클래스 설명: 루틴 추천 페이지에 루틴 이름을 클릭하면 팝업창으로 운동 정보를 보여주는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
@WebServlet("/getExerciseList.do")
public class GetExerciseListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
        String routineNo = req.getParameter("routineNo");
        System.out.println("Received routineNo: " + routineNo);

        RoutineDAO dao = new RoutineDAO();
        try {
            ArrayList<RoutineExerciseDTO> exerciseList = dao.exerciseList(routineNo);
            RoutineDTO routineInfo = dao.getRoutineInfo(routineNo);
            
            System.out.println("Exercise list size: " + (exerciseList != null ? exerciseList.size() : 0));
            System.out.println("Routine info: " + (routineInfo != null ? routineInfo.getRoutineName() : "null"));

            req.setAttribute("exercises", exerciseList);
            req.setAttribute("routineInfo", routineInfo);
            req.getRequestDispatcher("/WEB-INF/views/exercise/getExerciseList.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println("Error in GetExerciseListController: " + e.getMessage());
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "운동 목록을 불러오는 중 오류가 발생했습니다.");
        } finally {
            dao.close();
        }
	}
	

}

