package fitralpark;

@WebServlet("/index.do")
public class index extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//index.java
		

		req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
	}

}
