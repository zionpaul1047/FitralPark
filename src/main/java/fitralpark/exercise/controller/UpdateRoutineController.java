package fitralpark.exercise.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 클래스 설명: 자신의 루틴 목록을 수정하는 서블릿 클래스입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
@WebServlet("/exercise/updateRoutine.do")
public class UpdateRoutineController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO: 구현 예정
        resp.sendRedirect(req.getContextPath() + "/exercise/routineList.do");
    }
} 