package fitralpark.user.controller;

import fitralpark.user.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/checkId.do")
public class CheckIdController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        UserDAO dao = new UserDAO();
        boolean isDuplicate = dao.isDuplicateId(id);

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.print("{\"exists\": " + isDuplicate + "}");
    }
}
