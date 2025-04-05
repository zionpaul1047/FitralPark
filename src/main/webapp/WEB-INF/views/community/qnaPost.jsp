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
        .grid {
            display: grid;
            grid-template-rows: 125px auto 1fr;
            grid-template-columns: 1fr;
            min-height: 100%;
        }
        .grid_top {
            grid-row: 1;
        }
        .grid_center {
            grid-row: 2;
            display: grid;
            grid-template-columns: calc(50% - 424px) auto;
        }
        .grid_center_L {
        }
        .grid_center_R {
        }
        .grid_bottom {
            grid-row: 3;
        }
        
        main {
            display: flex;
            justify-content: center;
            margin: 50px 0;
        }
        
        #mainbox {
            border-radius: 20px;
            background-color: #FFFFFF;
            border: 2px solid #000000;
            width: 848px;
            padding: 20px 40px;
        }
        
        #smallbox {
            margin-bottom: 20px;
        }
        
        body h1 {
            font-size: 24px;
            padding: 0;
            margin: 20px 0 30px;
            text-align: center;
            border: none;
        }
        
        body h1 strong {
            display: inline-block;
            font-weight: bold;
            position: relative;
        }
        
        body h1 strong::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: -5px;
            right: -5px;
            height: 1px;
            background-color: #000;
        }
        
        .post-header {
            border-top: 2px solid #000;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
            margin-bottom: 20px;
        }
        
        .post-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .post-info {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 14px;
        }
        
        .post-content {
            min-height: 300px;
            padding: 20px 0;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }
        
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        
        .button-group button {
            background-color: #666666;
            color: white;
            border: 1px solid #666666;
            border-radius: 0;
            padding: 0 15px;
            height: 32px;
            font-size: 14px;
            cursor: pointer;
        }
        
        .button-group button:hover {
            background-color: #444444;
        }
        
        .comment-section {
            margin-top: 30px;
        }
        
        .comment-form {
            margin-bottom: 20px;
        }
        
        .comment-form textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border: 1px solid #999999;
            border-radius: 0;
            resize: none;
            margin-bottom: 10px;
        }
        
        .comment-list {
            border-top: 1px solid #ddd;
        }
        
        .comment-item {
            padding: 15px 0;
            border-bottom: 1px solid #ddd;
        }
        
        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        .comment-author {
            font-weight: bold;
        }
        
        .comment-date {
            color: #666;
        }
        
        .comment-content {
            margin-bottom: 10px;
        }
        
        .comment-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        
        .comment-actions button {
            background-color: #666666;
            color: white;
            border: 1px solid #666666;
            border-radius: 0;
            padding: 0 10px;
            height: 28px;
            font-size: 12px;
            cursor: pointer;
        }
        
        .comment-actions button:hover {
            background-color: #444444;
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
            <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>
        </div>
        
        <div class="grid_center">
            <div class="grid_center_L"></div>
            
            <div class="grid_center_R">
                <main>
                    <div id="mainbox">
                        <div id="smallbox">
                            <h1>
                                <strong>Q&A</strong>
                            </h1>
                            
                            <div class="post-header">
                                <div class="post-title">[${dto.header_name}] ${dto.post_subject}</div>
                                <div class="post-info">
                                    <span>${dto.nickname}(${dto.creator_id})</span>
                                    <span>
                                        작성일: ${dto.regdate} | 
                                        조회수: ${dto.views} | 
                                        추천수: ${dto.post_recommend}
                                    </span>
                                </div>
                            </div>
                            
                            <div class="post-content">
                                ${dto.post_content}
                            </div>
                            
                            <div class="button-group">
                                <div>
                                    <button type="button" onclick="location.href='qnaList.do'">목록</button>
                                </div>
                                <div>
                                    <c:if test="${loginUser.memberId == dto.creator_id}">
                                        <button type="button" onclick="location.href='qnaPostEdit.do?post_no=${dto.post_no}'">수정</button>
                                        <button type="button" onclick="location.href='qnaPostDel.do?post_no=${dto.post_no}'">삭제</button>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- 댓글 섹션 -->
                            <div class="comment-section">
                                <div class="comment-form">
                                    <form action="qnaCommentAdd.do" method="post">
                                        <input type="hidden" name="post_no" value="${dto.post_no}">
                                        <textarea name="comment_content" placeholder="댓글을 입력하세요"></textarea>
                                        <div style="text-align: right;">
                                            <button type="submit">댓글 작성</button>
                                        </div>
                                    </form>
                                </div>
                                
                                <div class="comment-list">
                                    <c:forEach items="${commentList}" var="comment">
                                        <div class="comment-item">
                                            <div class="comment-header">
                                                <span class="comment-author">${comment.nickname}(${comment.creator_id})</span>
                                                <span class="comment-date">${comment.regdate}</span>
                                            </div>
                                            <div class="comment-content">
                                                ${comment.comment_content}
                                            </div>
                                            <c:if test="${loginUser.memberId == comment.creator_id}">
                                                <div class="comment-actions">
                                                    <button type="button" onclick="location.href='qnaCommentEdit.do?comment_no=${comment.comment_no}&post_no=${dto.post_no}'">수정</button>
                                                    <button type="button" onclick="location.href='qnaCommentDel.do?comment_no=${comment.comment_no}&post_no=${dto.post_no}'">삭제</button>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <div class="grid_bottom">
            <%@ include file="/WEB-INF/views/common/footer.jsp"%>
        </div>
    </div>

    <script>
        // 모든 메뉴 항목을 선택
        const menuItems = document.querySelectorAll('.sf_submenu_1 div');

        // 클릭 이벤트 추가
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                // 모든 항목의 스타일 초기화
                menuItems.forEach(menu => {
                    menu.classList.remove('active');
                    menu.style.backgroundColor = 'lightgray';
                    menu.style.fontWeight = 'normal';
                });

                // 클릭된 항목에 스타일 적용
                item.classList.add('active');
                item.style.backgroundColor = 'oldlace';
                item.style.fontWeight = 'bold';
            });
        });
    </script>
</body>
</html> 