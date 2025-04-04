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

.grid {
	display: grid;
	grid-template-rows: 125px auto 1fr;
	grid-template-columns: 1fr;
	min-height: 100%;
}

.grid_top {
	/* border: 1px solid black; */
	grid-row: 1;
}

.grid_center {
	/* border: 1px solid black; */
	grid-row: 2;
	display: grid;
	grid-template-columns: calc(50% - 424px) auto;
}

.grid_center_L {
	/* border: 1px solid black; */
	
}

.grid_center_R {
	/* border: 1px solid black; */
	
}

.grid_bottom {
	/* border: 1px solid black; */
	grid-row: 3;
}

main {
	display: flex;
	justify-content: flex-start;
	margin-bottom: 50px;
}

body h1 {
	font-size: 30px;
	padding: 50px;
}

#mainbox {
	border-radius: 20px;
	background-color: #FFFFFF;
	border: 2px solid #000000;
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

body main #boardtable td, th {
	text-align: center;
	padding-top: 15px;
	padding-bottom: 15px;
	border-top: 1px solid #000000;
	border-bottom: 1px solid #000000;
	
	font-size: 12px;
}

/* 게시글 호버 효과 */
#boardtable tr:hover {
    background-color: #f5f5f5;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    gap: 5px;
}

.pagination a {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    transition: all 0.3s ease;
}

.pagination a:hover {
    background-color: #f5f5f5;
    border-color: #999;
}

.pagination .active {
    background-color: #4CAF50;
    color: white;
    border-color: #4CAF50;
}

#boardtable th:nth-child(1) {
	width: 40px;
}

#boardtable th:nth-child(2) {
	width: 40px;
}

#boardtable th:nth-child(3) {
	width: auto;
}

#boardtable th:nth-child(4) {
	width: 100px;
}

#boardtable th:nth-child(5) {
	width: 150px;
}

#boardtable th:nth-child(6), th:nth-child(7) {
	width: 80px;
}

/* 게시글 호버 효과 */
#boardtable tr:hover {
    background-color: #f5f5f5;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

/* 페이지네이션 스타일 */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    gap: 5px;
}

.pagination a {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    transition: all 0.3s ease;
}

.pagination .active {
    background-color: #4CAF50;
    color: white;
    border-color: #4CAF50;
}

#board_etc_box {
    position: relative;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.search_area {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    align-items: center;
    gap: 10px;
}

.button_group {
    margin-left: auto;
    display: flex;
    gap: 10px;
}

#board_etc_box #search_sel, .search_btn, .search_txt {
    display: inline-block;
    padding: 10px;
    border-radius: 20px;
    border: 2px solid #000000;
}

#btnadd_post, #btn_answer {
    display: inline-block;
    padding: 10px 20px;
    border-radius: 20px;
    border: 2px solid #000000;
    background-color: #FFFFFF;
    color: #000000;
    cursor: pointer;
}

/* 버튼 호버 효과 */
.search_btn:hover,
#search_sel:hover,
#btnadd_post:hover,
#btn_answer:hover {
    background-color: #f5f5f5;
    border-color: #999;
}

</style>
</head>
<body>
	<div class="grid">

		<div class="grid_top">

			<!-- 메인메뉴 -->
			<%@ include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 오른쪽메뉴 -->
			<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
			<!-- 왼쪽메뉴 -->
			<%@ include file="/WEB-INF/views/common/left_menu1.jsp"%>
		</div>

		<div class="grid_center">

			<div class="grid_center_L"></div>

			<div class="grid_center_R">

				<main>
				<div id="mainbox">
					<div id="smallbox">
						<h1>
							<strong>Q&A 게시판</strong>
						</h1>
						<table id="boardtable" >
							<tr>
								<th><input type="checkbox" id="selectAll"></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>날짜</th>
								<th>추천수</th>
								<th>조회수</th>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[운동] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[식단] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[헬스장] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[후기] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[운동] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>3</td>
								<td>[식단] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>4</td>
								<td>[헬스장] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>5</td>
								<td>[후기] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>1</td>
								<td>[운동] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[식단] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>3</td>
								<td>[헬스장] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>4</td>
								<td>[후기] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>5</td>
								<td>[운동] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>1</td>
								<td>[식단] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[헬스장] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>3</td>
								<td>[후기] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>4</td>
								<td>[운동] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>5</td>
								<td>[식단] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>1</td>
								<td>[헬스장] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="post-checkbox"></td>
								<td>2</td>
								<td>[후기] 아 운동 너무 어렵다</td>
								<td>김진혁</td>
								<td>2025-03-28</td>
								<td>15</td>
								<td>15</td>
							</tr>
						</table>
						
						<!-- 페이지네이션 -->
						<div class="pagination">
							<a href="#" class="active">1</a>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>
							<a href="#">5</a>
							<a href="#">6</a>
							<a href="#">7</a>
							<a href="#">8</a>
							<a href="#">9</a>
							<a href="#">10</a>
							<a href="#">다음</a>
						</div>
						
					</div>

					<div>
						
					</div>					


					<div id="board_etc_box">
						<div class="search_area">
							<select id="search_sel">
								<option value="제목">제목</option>
								<option value="작성자">작성자</option>
								<option value="날짜">날짜</option>
							</select>
							<input type="search" class="search_txt" placeholder="  검색">
							<button type="submit" class="search_btn" id="btn_search">검색</button>
						</div>
						<div class="button_group">
							<button type="button" id="btnadd_post" onclick="location.href='qnaQuestion.do'">질문하기</button>
							<button type="button" id="btn_answer" onclick="location.href='qnaAnswer.do'">답변하기</button>
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



</body>


</html>