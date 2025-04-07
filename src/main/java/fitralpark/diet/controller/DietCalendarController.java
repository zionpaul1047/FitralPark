package fitralpark.diet.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dietCalendar.do")
public class DietCalendarController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DietCalendarController.java
		

		req.getRequestDispatcher("/WEB-INF/views/exercise/dietCalendar.jsp").forward(req, resp);
	}

}
