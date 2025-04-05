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

    /* 삭제 확인 스타일 */
    .delete-confirm {
        padding: 20px;
        margin: 20px;
        text-align: center;
    }

    .post-info {
        margin: 20px 0;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 4px;
        background-color: #f8f9fa;
    }

    .post-info p {
        margin: 10px 0;
    }

    .warning-message {
        color: #dc3545;
        font-weight: bold;
        margin: 20px 0;
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

    .button-container button.delete {
        background-color: #dc3545;
        color: white;
        border-color: #dc3545;
    }

    .button-container button:hover {
        background-color: #f5f5f5;
    }

    .button-container button.delete:hover {
        background-color: #c82333;
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
                                <strong>공지사항 삭제</strong>
                            </h1>
                            
                            <!-- 삭제 확인 -->
                            <div class="delete-confirm">
                                <div class="post-info">
                                    <p><strong>제목:</strong> ${dto.post_subject}</p>
                                    <p><strong>작성자:</strong> ${dto.nickname}(${dto.creator_id})</p>
                                    <p><strong>작성일:</strong> ${dto.regdate}</p>
                                </div>
                                
                                <p class="warning-message">
                                    이 공지사항을 정말 삭제하시겠습니까?<br>
                                    삭제된 공지사항은 복구할 수 없습니다.
                                </p>
                                
                                <div class="button-container">
                                    <button type="button" class="delete" onclick="location.href='announcementPostDelOK.do?post_no=${dto.post_no}'">삭제</button>
                                    <button type="button" onclick="location.href='announcementPost.do?post_no=${dto.post_no}'">취소</button>
                                </div>
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