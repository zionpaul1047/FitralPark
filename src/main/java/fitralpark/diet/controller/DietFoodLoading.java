package fitralpark.diet.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dietFoodLoading.do")
public class DietFoodLoading extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //DietFoodLoading.java
        

        req.getRequestDispatcher("/WEB-INF/views/diet/dietFoodLoading.jsp").forward(req, resp);
    }

}

