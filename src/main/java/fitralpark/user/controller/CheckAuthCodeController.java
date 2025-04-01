package fitralpark.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/checkAuthCode.do")
public class CheckAuthCodeController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String inputCode = req.getParameter("code");
        HttpSession session = req.getSession();

        String savedCode = (String) session.getAttribute("emailAuthCode");
        Long savedTime = (Long) session.getAttribute("emailAuthTime");
        long currentTime = System.currentTimeMillis();

        boolean match = false;

        if (savedCode != null && savedTime != null) {
            if ((currentTime - savedTime) <= 5 * 60 * 1000 && savedCode.equals(inputCode)) {
                match = true;
            }
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().print("{\"match\": " + match + "}");
    }
}

