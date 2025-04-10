package fitralpark.exercise.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fitralpark.exercise.dao.RoutineDAO;

/**
 * 클래스 설명: 운동 즐겨찾기를 등록하는 서블릿 클래스 입니다.
 * 
 * @author 김진혁
 * @since 2025.04.10
 */
@WebServlet("/exercise/getFavorites.do")
public class GetFavoritesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
    }
    
} 