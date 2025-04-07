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
	padding: 20px;
}

/* 테이블 스타일 */
#boardtable {
	text-align: inherit;
	width: 1000px;  
	padding: 50px;
	border-radius: 20px;
	border-top: 2px solid #000000;
	border-bottom: 2px solid #000000;
}

#boardtable td, th {
	text-align: center;
	padding: 15px 0;
	border-top: 1px solid #000000;
	border-bottom: 1px solid #000000;
	font-size: 12px;
}

/* 테이블 컬럼 너비 */
#boardtable th:nth-child(1) { width: 60px; }  /* 번호 */
#boardtable th:nth-child(2) { width: auto; }  /* 제목 */
#boardtable th:nth-child(3) { width: 150px; } /* 작성자 */
#boardtable th:nth-child(4) { width: 150px; } /* 날짜 */
#boardtable th:nth-child(5), 
#boardtable th:nth-child(6) { width: 80px; }  /* 추천수, 조회수 */

/* 게시글 호버 효과 */
#boardtable td a {
    color: #333;
    text-decoration: none;
    transition: all 0.3s ease;
}

#boardtable td a:hover {
    background-color: #f5f5f5;
    cursor: pointer;
    color: #666666;
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

.pagination a:hover {
    background-color: #f5f5f5;
    border-color: #999;
}

.pagination .active {
    color: #333;
}

/* 검색 및 글쓰기 영역 */
#board_etc_box {
    position: relative;
    padding: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.search_area {
    display: flex;
    align-items: center;
    gap: 10px;
}

#board_etc_box #search_sel, 
.search_btn, 
.search_txt, 
#search_category {
    display: inline-block;
    padding: 10px;
    border-radius: 20px;
    border: 2px solid #000000;
}

/* 글쓰기 버튼 */
#btnadd_post {
    position: absolute;
    right: 20px;
    display: inline-block;
    padding: 10px 20px;
    border-radius: 20px;
    border: 2px solid #000000;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

/* 버튼 호버 효과 */
#search_category:hover,
#btnadd_post:hover,
.search_btn:hover,
#search_sel:hover {
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
			<%@ include file="/WEB-INF/views/common/left_menu_community.jsp"%>
		</div>

		<div class="grid_center">

			<div class="grid_center_L"></div>

			<div class="grid_center_R">

				<main>
				<div id="mainbox">
					<div id="smallbox">
						<h1>
							<strong>자유 게시판</strong>
						</h1>
						
						
						<table id="boardtable" >
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>날짜</th>
								<th>추천수</th>
								<th>조회수</th>
							</tr>
							<c:forEach items="${bulletin_list}" var="dto" varStatus="status">
							<tr>
								<td>${(page - 1) * pageSize + status.index + 1}</td>
								<td><a href="bulletinPost.do?post_no=${dto.post_no}
								">[${dto.header_name}] ${dto.post_subject}</a></td>
								<td><a href="">${dto.nickname}(${dto.creator_id})</a></td>
								<td>${dto.regdate}</td>
								<td>${dto.post_recommend}</td>
								<td>${dto.views}</td>
							</tr>
							</c:forEach>
						</table>
						
						<!-- 페이지네이션 -->
						<div class="pagination">
							<c:if test="${page > 1}">
								<a href="bulletinList.do?page=${page-1}&search_category=${searchCategory}&search_sel=${searchSel}&searchWord=${searchWord}">이전</a>
							</c:if>
							
							<c:forEach begin="${startPage}" end="${endPage}" var="i">
								<c:choose>
									<c:when test="${page == i}">
										<span class="active">${i}</span>
									</c:when>
									<c:otherwise>
										<a href="bulletinList.do?page=${i}&search_category=${searchCategory}&search_sel=${searchSel}&searchWord=${searchWord}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${page < totalPages}">
								<a href="bulletinList.do?page=${page+1}&search_category=${searchCategory}&search_sel=${searchSel}&searchWord=${searchWord}">다음</a>
							</c:if>
						</div>
						
					</div>

					<div>
						
					</div>					

					<form action="/fitralpark/bulletinList.do" method="get">
					<div id="board_etc_box">
						<div class="search_area">
							<select id="search_category" name="search_category">
								<option value="">전체</option>
								<c:forEach items="${headerList}" var="headerDto">
									<option value="${headerDto.header_no}" ${searchCategory == headerDto.header_no ? 'selected' : ''}>${headerDto.header_name}</option>
								</c:forEach>
							</select>
							<select id="search_sel" name="search_sel">
								<option value="post_subject" ${searchSel == 'post_subject' ? 'selected' : ''}>제목</option>
								<option value="post_subject&post_content" ${searchSel == 'post_subject&post_content' ? 'selected' : ''}>제목&내용</option>
								<option value="creator_id" ${searchSel == 'creator_id' ? 'selected' : ''}>작성자</option>
								<option value="regdate" ${searchSel == 'regdate' ? 'selected' : ''}>날짜</option>
							</select>
							<input type="text" name="searchWord" class="search_txt" placeholder="  검색" value="${searchWord}">
							<input type="submit" class="search_btn" id="btn_search" value="검색">
						</div>
						<button type="button" id="btnadd_post" onclick="location.href='bulletinPostWrite.do'">글쓰기</button>
					</div>
					</form>
				</div>
	
	
	
			</main>
			</div>

		</div>

		<div class="grid_bottom">
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>

	</div>



</body>

<script>

	function search() {
    const category = document.getElementById('search_category').value;
    const sel = document.getElementById('search_sel').value;
    const word = document.getElementById('searchWord').value;
    location.href = '/fitralpark/bulletinList.do?search_category=' + category + '&search_sel=' + sel + '&searchWord=' + word;
}

</script>



</html>