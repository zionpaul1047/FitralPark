<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
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
			width: 1000px;
			padding: 20px 40px;
		}

        body h1 {
			font-size: 24px;
			padding: 20px 0;
			margin-bottom: 20px;
			border-bottom: 1px solid #ddd;
		}
        
		#content {
			width: 100%;
			height: 400px;
			padding: 10px;
			border: 1px solid #ddd;
			border-radius: 4px;
			resize: none;
		}

        /* 게시글 작성 폼 스타일 */
        .write-form {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .write-form .form-group {
            display: flex;
            margin-bottom: 20px;
            position: relative;
        }

        .write-form label {
            width: 80px;
            font-weight: bold;
            padding-top: 8px;
        }

        .write-form input[type="text"],
        .write-form select,
        .write-form textarea {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 8px 12px;
            font-size: 14px;
            margin-left: 15px;
        }

        .write-form input[type="text"] {
            width: calc(100% - 95px);
        }

        .write-form select {
            width: 150px;
            appearance: none;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath d='M6 9L1 4h10z'/%3E%3C/svg%3E") no-repeat right 8px center;
            background-color: white;
            padding-right: 30px;
        }

        .write-form textarea {
            width: calc(100% - 95px);
            height: 350px;
            line-height: 1.5;
            resize: none;
        }

        .write-form .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            padding-bottom: 20px;
        }

        .write-form button {
            padding: 10px 30px;
            border-radius: 20px;
            font-size: 14px;
        }

        .write-form button[type="submit"] {
            background-color: #4CAF50;
            color: white;
        }

        .write-form button[type="button"] {
            background-color: #f44336;
            color: white;
        }

        .write-form button:hover {
            opacity: 0.9;
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
				<h1>공지사항 쓰기</h1>
				<form class="write-form" action="/community/bulletinWrite" method="post">
					<div class="form-group">
						<label for="category">말머리</label>
						<select name="category" id="category" required>
							<option value="">말머리 선택</option>
							<option value="공지">공지</option>
							<option value="이벤트">이벤트</option>
							<option value="점검">점검</option>
							<option value="안내">안내</option>
						</select>
					</div>
					<div class="form-group">
						<label for="title">제목</label>
						<input type="text" name="title" id="title" required>
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea name="content" id="content" required></textarea>
					</div>
					<div class="button-group">
						<button type="submit">작성하기</button>
						<button type="button" onclick="history.back()">취소</button>
					</div>
				</form>
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