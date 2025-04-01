package fitralpark.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.DashCurrentDietDTO;
import fitralpark.user.dto.DashCurrentExcsDTO;
import fitralpark.user.dto.DashDTO;
import fitralpark.user.dto.DashTodayDietDTO;
import fitralpark.user.dto.DashTodayExerciseDTO;
import fitralpark.user.dto.DashTodayIntakeDTO;

@WebServlet("/dashboard.do")
public class DashBoardController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("페이지 실행");
		String id = "hong";
		//DashBoardController.java
		UserDAO dao = new UserDAO();
		
		
		DashDTO dto = dao.getDashInfo(id);
		
		dao.close();
		
		System.out.println(dto);
		
		
		//임시코드(DB 연결 전 테스트)
//		DashDTO dto = new DashDTO();
//		
//		dto.setCrtdietList(new ArrayList<DashCurrentDietDTO>());
//		dto.setCrtExcsList(new ArrayList<DashCurrentExcsDTO>());
//		dto.setTdyDietList(new ArrayList<DashTodayDietDTO>());
//		dto.setTdyExcsList(new ArrayList<DashTodayExerciseDTO>());
//		
//		dto.getCrtdietList().add(new DashCurrentDietDTO("2025.03.23. (일)", "21", "16", "5", "80"));
//		dto.getCrtdietList().add(new DashCurrentDietDTO("2025.03.24. (월)", "21", "14", "7", "75"));
//		dto.getCrtdietList().add(new DashCurrentDietDTO("2025.03.25. (화)", "21", "18", "3", "85"));
//		dto.getCrtdietList().add(new DashCurrentDietDTO("2025.03.26. (수)", "21", "14", "7", "75"));
//		dto.getCrtdietList().add(new DashCurrentDietDTO("2025.03.26. (목)", "21", "16", "5", "80"));
//
//		dto.getCrtExcsList().add(new DashCurrentExcsDTO("2025.03.23. (일)", "30", "20", "10", "66.6"));
//		dto.getCrtExcsList().add(new DashCurrentExcsDTO("2025.03.23. (월)", "21", "17", "4", "70"));
//		dto.getCrtExcsList().add(new DashCurrentExcsDTO("2025.03.23. (화)", "26", "19", "7", "67"));
//		
//		String[] food1 = {"바나나","닭가슴살","우유"};
//		dto.getTdyDietList().add(new DashTodayDietDTO("아침",food1));
//		String[] food2 = {"사과","샐러드","달걀"};
//		dto.getTdyDietList().add(new DashTodayDietDTO("점심",food2));
//		String[] food3 = {"고구마","닭가슴살","요거트"};
//		dto.getTdyDietList().add(new DashTodayDietDTO("아침",food3));
//		
//		dto.getTdyExcsList().add(new DashTodayExerciseDTO("스쿼트", "90", "10회", "3세트", "30kg", "20min"));
//		dto.getTdyExcsList().add(new DashTodayExerciseDTO("데드리프트", "80", "12회", "3세트", "20kg", "20min"));
//		dto.getTdyExcsList().add(new DashTodayExerciseDTO("풀업", "100", "10회", "5세트", null, "10min"));
//		
//		dto.setUserName("아무개");
//		dto.setAge("20");
//		dto.setHeight("180.2");
//		dto.setWeight("68.3");
//		dto.setGender("남성");
//		
//		dto.setTdyintake(new DashTodayIntakeDTO("2600", "400", "50", "50", "80", "30", "750", "1900", "700", "0", "1.2", "20", "500", "15"));
//		
//		System.out.println(dto.getCrtdietList());
//		
		req.setAttribute("dto", dto);
		
		

		req.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(req, resp);

	}

}
