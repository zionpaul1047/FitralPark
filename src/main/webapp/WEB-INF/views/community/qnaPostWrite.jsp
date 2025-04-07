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
        
        .write-form {
            margin-top: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group select,
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #999999;
            border-radius: 0;
            font-size: 14px;
        }
        
        .form-group select {
            height: 35px;
        }
        
        .form-group textarea {
            height: 300px;
            resize: none;
        }
        
        .privacy-check {
            margin: 20px 0;
        }
        
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
        }
        
        .button-group button {
            background-color: #666666;
            color: white;
            border: 1px solid #666666;
            border-radius: 0;
            padding: 0 20px;
            height: 35px;
            font-size: 14px;
            cursor: pointer;
        }
        
        .button-group button:hover {
            background-color: #444444;
        }
        
        .required {
            color: red;
            margin-left: 3px;
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
                                <strong>Q&A 작성</strong>
                            </h1>
                            
                            <form action="qnaPostWriteOK.do" method="post" class="write-form">
                                <div class="form-group">
                                    <label>말머리<span class="required">*</span></label>
                                    <select name="header_no" required>
                                        <option value="">말머리 선택</option>
                                        <c:forEach items="${headerList}" var="header">
                                            <option value="${header.header_no}">${header.header_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label>제목<span class="required">*</span></label>
                                    <input type="text" name="post_subject" required>
                                </div>
                                
                                <div class="form-group">
                                    <label>내용<span class="required">*</span></label>
                                    <textarea name="post_content" required></textarea>
                                </div>
                                
                                <div class="privacy-check">
                                    <label>
                                        <input type="checkbox" name="privacy_check" value="Y">
                                        비밀글
                                    </label>
                                </div>
                                
                                <div class="button-group">
                                    <button type="submit">등록</button>
                                    <button type="button" onclick="location.href='qnaList.do'">취소</button>
                                </div>
                            </form>
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