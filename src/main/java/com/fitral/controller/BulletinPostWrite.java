package com.fitral.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bulletinWrite.do")
public class BulletinPostWrite extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 글쓰기 페이지로 이동
        request.getRequestDispatcher("/WEB-INF/views/community/bulletinWrite.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST 요청 처리 (글쓰기 완료)
        request.setCharacterEncoding("UTF-8");
        
        // 폼 데이터 받기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
        
        // TODO: 데이터베이스에 저장하는 로직 구현
        
        // 저장 후 목록 페이지로 리다이렉트
        response.sendRedirect("bulletinList.do");
    }
} 