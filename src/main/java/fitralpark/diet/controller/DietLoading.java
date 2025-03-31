package fitralpark.diet.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

    @WebServlet("/dietLoading.do")
    public class DietLoading extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            //DietLoading.java
            

            req.getRequestDispatcher("/WEB-INF/views/diet/dietLoading.jsp").forward(req, resp);
        }

    }



