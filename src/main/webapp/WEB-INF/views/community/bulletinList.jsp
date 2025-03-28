<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
<!-- favicon.png" -->
<%@ include file="/WEB-INF/views/common/asset.jsp" %>
	<style>
		body {
			background-color: rgb(218, 243, 211);
		}

		main {
			margin-left: 200px;
			display: flex;
			justify-content: flex-start;
			margin-top: 150px;
			margin-bottom: 30px;
		}

		body>main h1 {
			font-size: 40px;
			padding: 50px;
		}

		#mainbox {
			border-radius: 20px;
			background-color: #FFFFFF;
		}

		#smallbox {
			padding-top: 20px;
			padding-left: 20px;
			padding-right: 20px;
		}


		#boardtable {
			text-align: inherit;
			width: 1000px;

			padding: 50px;

			border-radius: 20px;
			border-top: 2px solid #000000;
			border-bottom: 2px solid #000000;
		}

		#boardtable td, 
					th {
			text-align: center;
			
			padding-top: 15px;
			padding-bottom: 15px;

			border-top: 1px solid #000000;
			border-bottom: 1px solid #000000;
		}

		#boardtable th:nth-child(1) {
			width: 60px;
		}

		#boardtable th:nth-child(2) {
			width: auto;
		}

		#boardtable th:nth-child(3) {
			width: 100px;
		}

		#boardtable th:nth-child(4) {
			width: 150px;
		}

		#boardtable th:nth-child(5),
					th:nth-child(6) {
			width: 80px;
		}
				
		#board_etc_box {
			text-align: center;
			padding: 20px;
			
			display: flex;
			justify-content: center;
			align-items: center;
		}

		#board_etc_box  #search_sel,
						#btnadd_post, 
						.search_btn, 
						.search_txt {
			display: inline-block;

			padding-top: 10px;
			padding-bottom: 10px;
			padding-left: 5px;
			padding-right: 5px;

			border-radius: 20px;
			border: 2px solid #000000;
			margin-left: 10px;
		}
	</style>
</head>

<body>

	<!-- 메인메뉴 --> 
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<!-- 오른쪽메뉴 -->
	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		<!-- 왼쪽메뉴 -->
	<%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>

	<main>

		<div id="mainbox">
			<div id="smallbox">
				<h1><strong>자유 게시판</strong></h1>

				<table id="boardtable">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>추천수</th>
						<th>조회수</th>
					</tr>
					<%-- <c:forEach items="${list}" var="dto"> --%>
					<tr>
						<td>1</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>2</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>2</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>2</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>2</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>3</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>						
					</tr>
					<tr>
						<td>4</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>						
					</tr>
					<tr>
						<td>5</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>					
					</tr>
					<tr>
						<td>1</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>2</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>3</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>						
					</tr>
					<tr>
						<td>4</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>						
					</tr>
					<tr>
						<td>5</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>					
					</tr>
					<tr>
						<td>1</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>2</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>
					</tr>
					<tr>
						<td>3</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>						
					</tr>
					<tr>
						<td>4</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>						
					</tr>
					<tr>
						<td>5</td>
						<td>아 운동 너무 어렵다</td>
						<td>김진혁</td>
						<td>2025-03-28</td>
						<td>김진혁</td>
						<td>15</td>					
					</tr>
					<%-- </c:forEach> --%>
				</table>

			</div>
			
			<div id="board_no">
				
			</div>
			
			<div id="board_etc_box">
				<select id="search_sel">
					<option value="제목">제목</option>
					<option value="작성자">작성자</option>
					<option value="날짜">날짜</option>
				</select>
				
				<input type="search" class="search_txt" placeholder="  검색">
				<button type="submit" class="search_btn" id="btn_search">검색</button>
				<button type="submit" class="add" id="btnadd_post">글쓰기</button>
				
			</div>

		</div>

	</main>

<!-- Footer -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>

</html>