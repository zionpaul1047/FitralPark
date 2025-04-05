<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
<%@ include file="/WEB-INF/views/common/asset.jsp" %>
<style>
    body {
        background-color: rgb(218, 243, 211);
    }  
    .grid{
        display: grid;
        grid-template-rows: 125px auto 1fr;
        grid-template-columns: 1fr;
        min-height: 100%;
    }
    .grid_top{
        /* border: 1px solid black; */
        grid-row: 1;
    }
    .grid_center{
        /* border: 1px solid black; */
        grid-row: 2;
        display: grid;
        grid-template-columns: calc(50% - 424px) auto;
    }
    .grid_center_L{
        /* border: 1px solid black; */
    }
    .grid_center_R{
        /* border: 1px solid black; */
    }
    .grid_bottom{
        /* border: 1px solid black; */
        grid-row: 3;
    }
    
    main {
        display: flex;
        justify-content: flex-start;
        margin-bottom: 50px;
    }
    
    #mainbox {
        border-radius: 20px;
        background-color: #FFFFFF;
        border: 2px solid #000000;
    }

    body h1 {
        font-size: 30px;
        padding: 50px;
    }
    
    #smallbox {
        padding: 20px;
    }

    /* 글쓰기 폼 스타일 */
    .edit-form {
        padding: 20px;
        margin: 20px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }

    .form-group select,
    .form-group input[type="text"],
    .form-group textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }

    .form-group textarea {
        height: 300px;
        resize: vertical;
    }

    /* 버튼 스타일 */
    .button-container {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 20px;
    }

    .button-container button {
        padding: 10px 20px;
        border: 1px solid #000;
        border-radius: 4px;
        background-color: white;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .button-container button:hover {
        background-color: #f5f5f5;
    }

    /* 에디터 스타일 */
    .editor-toolbar {
        border: 1px solid #ddd;
        border-radius: 4px 4px 0 0;
        padding: 8px;
        background-color: #f8f9fa;
    }

    .editor-content {
        border: 1px solid #ddd;
        border-top: none;
        border-radius: 0 0 4px 4px;
        padding: 8px;
    }
</style>
</head>
<body>
    <div class="grid">
        <div class="grid_top">
            <!-- 메인메뉴 -->
            <%@ include file="/WEB-INF/views/common/header.jsp" %>
            <!-- 오른쪽메뉴 -->
            <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
            <!-- 왼쪽메뉴 -->
            <%@ include file="/WEB-INF/views/common/left_menu_community.jsp" %>
        </div>
        
        <div class="grid_center">
            <div class="grid_center_L"></div>
            
            <div class="grid_center_R">
                <main>
                    <div id="mainbox">
                        <div id="smallbox">
                            <h1>
                                <strong>공지사항 수정</strong>
                            </h1>
                            
                            <!-- 수정 폼 -->
                            <div class="edit-form">
                                <form method="POST" action="announcementPostEditOK.do">
                                    <input type="hidden" name="post_no" value="${dto.post_no}">
                                    
                                    <div class="form-group">
                                        <label for="header">말머리</label>
                                        <select name="header" id="header">
                                            <option value="공지" ${dto.header_name == '공지' ? 'selected' : ''}>공지</option>
                                            <option value="이벤트" ${dto.header_name == '이벤트' ? 'selected' : ''}>이벤트</option>
                                            <option value="점검" ${dto.header_name == '점검' ? 'selected' : ''}>점검</option>
                                            <option value="안내" ${dto.header_name == '안내' ? 'selected' : ''}>안내</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="subject">제목</label>
                                        <input type="text" name="subject" id="subject" value="${dto.post_subject}" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="content">내용</label>
                                        <div class="editor-toolbar">
                                            <!-- 에디터 툴바 -->
                                        </div>
                                        <div class="editor-content">
                                            <textarea name="content" id="content" required>${dto.post_content}</textarea>
                                        </div>
                                    </div>
                                    
                                    <div class="button-container">
                                        <button type="submit">수정</button>
                                        <button type="button" onclick="location.href='announcementPost.do?post_no=${dto.post_no}'">취소</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <div class="grid_bottom">
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
    </div>
</body>
</html> 