package fitralpark.exercise.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/exerciseLoading.do")
public class ExerciseLoading extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //ExerciseLoading.java
    

        req.getRequestDispatcher("/WEB-INF/views/exercise/exerciseLoading.jsp").forward(req, resp);
    }

}

