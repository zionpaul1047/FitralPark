<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
<link rel="stylesheet" href="asset/css/style.css">
<style>
    .grid-container {
        display: grid;
        grid-template-columns: 200px 1fr;
        grid-template-rows: 100px 1fr;
        gap: 20px;
        height: 100vh;
        padding: 20px;
    }
    
    .header {
        grid-column: 1 / -1;
        background-color: #f0f0f0;
        padding: 20px;
    }
    
    .sidebar {
        background-color: #f0f0f0;
        padding: 20px;
    }
    
    .main-content {
        background-color: #ffffff;
        padding: 20px;
    }
    
    .delete-form {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 5px;
    }
    
    .delete-form h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    
    .delete-form p {
        margin-bottom: 20px;
    }
    
    .button-group {
        text-align: center;
    }
    
    .button-group button {
        padding: 10px 20px;
        margin: 0 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    
    .delete-button {
        background-color: #ff4444;
        color: white;
    }
    
    .cancel-button {
        background-color: #666666;
        color: white;
    }
</style>
</head>
<body>
    <div class="grid-container">
        <div class="header">
            <h1>커뮤니티</h1>
        </div>
        
        <div class="sidebar">
            <ul class="left-menu">
                <li><a href="announcementList.do">공지사항</a></li>
                <li><a href="qnaList.do">Q&A</a></li>
            </ul>
        </div>
        
        <div class="main-content">
            <div class="delete-form">
                <h2>게시글 삭제</h2>
                <p>다음 게시글을 삭제하시겠습니까?</p>
                <p>제목: ${dto.post_subject}</p>
                <p>작성자: ${dto.creator_id}</p>
                <p>작성일: ${dto.reg_date}</p>
                
                <div class="button-group">
                    <button type="button" class="delete-button" onclick="location.href='qnaPostDelete.do?post_no=${dto.post_no}';">삭제하기</button>
                    <button type="button" class="cancel-button" onclick="history.back();">취소하기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 