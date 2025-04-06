package fitralpark.user.controller;

import fitralpark.user.dao.UserDAO;
import fitralpark.user.dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/find-id.do")
public class FindIdController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        UserDAO dao = new UserDAO();
        String foundId = dao.findIdByNameAndEmail(name, email);

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        if (foundId != null) {
            out.write("<script>alert('회원님의 아이디는: " + foundId + " 입니다.'); window.location.href='login.do?show=login';</script>");
        } else {
            out.write("<script>alert('일치하는 회원 정보가 없습니다.'); history.back();</script>");
        }
    }
}
