<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>식단 라이브러리</title>
<style>
/* 추천/비추천 버튼 컨테이너 */
#recommend-info {
    display: flex;
    align-items: center;
    gap: 8px; /* 버튼과 텍스트 간격 */
    font-size: 14px;
    color: #555; /* 기본 텍스트 색상 */
}

/* 추천/비추천 버튼 공통 스타일 */
button.recommend-btn, button.disrecommend-btn {
    cursor: pointer;
    border: none;
    outline: none;
    padding: 8px 12px;
    font-size: 14px;
    border-radius: 5px;
    transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.2s ease;
}

/* 추천 버튼 스타일 */
button.recommend-btn {
    background-color: #eafaf1; /* 연한 초록색 배경 */
    color: #28a745; /* 초록색 텍스트 */
    border: 1px solid #d4edda; /* 연한 초록색 테두리 */
}

button.recommend-btn:hover {
    background-color: #d4edda; /* 호버 시 더 진한 초록색 배경 */
    color: #155724; /* 호버 시 더 진한 초록색 텍스트 */
}

/* 비추천 버튼 스타일 */
button.disrecommend-btn {
    background-color: #fdecea; /* 연한 빨간색 배경 */
    color: #dc3545; /* 빨간색 텍스트 */
    border: 1px solid #f5c6cb; /* 연한 빨간색 테두리 */
}

button.disrecommend-btn:hover {
    background-color: #f5c6cb; /* 호버 시 더 진한 빨간색 배경 */
    color: #721c24; /* 호버 시 더 진한 빨간색 텍스트 */
}

/* 추천/비추천 카운트 스타일 */
span.recommend-count, span.disrecommend-count {
    font-weight: bold;
    font-size: 14px;
    color: #333; /* 기본 텍스트 색상 */
}

.star-btn {
    background: none;
    border: none;
    color: gold;
    cursor: pointer;
    font-size: 16px;
}
.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 4px; /* 버튼 간격 */
	margin-top: 15px;
}

.pagination-link {
	display: inline-flex;
	justify-content: center;
	align-items: center;
	width: 30px; /* 버튼 너비 축소 */
	height: 30px; /* 버튼 높이 축소 */
	border-radius: 4px; /* 둥근 모서리 */
	border: 1px solid #ddd;
	color: #333;
	font-size: 14px; /* 폰트 크기 축소 */
	text-decoration: none;
	background-color: #fff; /* 기본 배경색 */
	transition: all 0.3s ease; /* 부드러운 전환 효과 */
}

.pagination-link:hover {
	background-color: #f0f0f0; /* Hover 시 배경색 */
}

.pagination-link.active {
	background-color: #007bff; /* 현재 페이지 배경색 (파란색) */
	color: white; /* 현재 페이지 텍스트 색상 */
	border-color: #007bff;
}

s 
    
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
}

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

body {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

body {
	background-color: rgb(218, 243, 211);
	color: #333;
}

.container {
	max-width: 1059px;
	margin: 20px auto;
	padding: 0 15px;
}

header {
	margin-bottom: 20px;
}

h1 {
	font-size: 18px;
	font-weight: bold;
}

.content-box {
	position: relative;
	right: 155px;
	bottom: 15px;
	background-color: #fff;
	border-radius: 5px;
	padding: 20px;
}

h2 {
	font-size: 20px;
	margin-bottom: 20px;
}

h3 {
	font-size: 16px;
	margin-bottom: 15px;
}

.search-section {
	margin-bottom: 30px;
}

.search-filters {
	width: 100%;
}

.search-row {
	display: flex;
	align-items: center;
	flex-wrap: nowrap;
	gap: 10px;
}

.search-input {
	position: relative;
	right: 30px;
	display: flex;
	align-items: center;
	margin-left: auto;
}

.search-input input {
	padding: 8px 30px 8px 10px;
	border: 1px solid #ccc;
	border-radius: 3px;
	width: 150px;
}

.search-btn {
	position: absolute;
	right: 2px;
	background: none;
	border: none;
	cursor: pointer;
	font-size: 18px;
}

.search-icon {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 18px;
}

.filter-group {
	display: flex;
	align-items: center;
	gap: 5px;
}

.filter-item {
	display: flex;
	align-items: center;
	white-space: nowrap;
}

.filter-label {
	margin-right: 5px;
}

.filter-separator {
	margin: 0 5px;
}

.calorie-input {
	width: 80px;
	padding: 6px 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

.select-wrapper {
	position: relative;
}

.filter-select {
	padding: 6px 25px 6px 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: white;
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	background-image:
		url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
	background-repeat: no-repeat;
	background-position: right 8px center;
	background-size: 1em;
	min-width: 140px;
}

.search-box {
	display: flex;
	align-items: center;
	position: relative;
	margin-left: auto;
}

.search-input {
	padding: 6px 30px 6px 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
	width: 200px;
}

.search-btn {
	position: absolute;
	right: 5px;
	background: none;
	border: none;
	cursor: pointer;
	font-size: 16px;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-btn {
	padding: 8px 12px;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 3px;
	cursor: pointer;
	min-width: 130px;
	text-align: left;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: white;
	min-width: 130px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	border: 1px solid #ddd;
	border-radius: 3px;
	max-height: 200px;
	overflow-y: auto;
}

.dropdown-content.show {
	display: block;
}

.dropdown-item {
	padding: 10px 15px;
	cursor: pointer;
}

.dropdown-item:hover {
	background-color: #f1f1f1;
}

.dropdown-item.selected {
	background-color: #f0f0f0;
	font-weight: bold;
}

.diet-list-section {
	margin-top: 30px;
}

.diet-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	font-size: 14px;
}

.diet-table th, .diet-table td {
	padding: 8px 5px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

.diet-table th {
	background-color: #f9f9f9;
	font-weight: bold;
}

.checkbox-col {
	width: 40px;
}


.star-btn.active {
	color: gold;
}

.detail-row {
	display: none;
	background-color: #f9f9f9;
}

.food-details {
	padding: 15px;
}

.food-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 15px;
}

.food-table th, .food-table td {
	padding: 8px;
	text-align: center;
	border: 1px solid #ddd;
}

.food-table th {
	background-color: #f1f1f1;
}

.detail-buttons {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 10px;
}

.confirm-btn, .cancel-btn {
	padding: 8px 15px;
	border
}

.diet-table {
	table-layout: fixed;
	width: 100%;
}

.diet-table th:nth-child(1) {
	width: 5%;
} /* 체크박스 열 */
.diet-table th:nth-child(2) {
	width: 23%;
} /* 식단명 */
.diet-table th:nth-child(3) {
	width: 15%;
} /* 식단 카테고리 */
.diet-table th:nth-child(4) {
	width: 10%;
} /* 작성일 */
.diet-table th:nth-child(5) {
	width: 10%;
} /* 총열량 */
.diet-table th:nth-child(6) {
	width: 9%;
} /* 식사시간대 */
.diet-table th:nth-child(7) {
	width: 10%;
} /* 작성자 */
.diet-table th:nth-child(8) {
	width: 8%;
} /* 즐겨찾기 */
.diet-table th:nth-child(9) {
	width: 10%;
} /* 조회수 */
.diet-table td {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.pagination {
	display: flex;
	justify-content: center;
	gap: 5px;
	margin: 20px 0;
}

.page-btn:disabled {
	cursor: default;
	opacity: 0.5;
}

.page-btn {
	width: 25px;
	height: 25px;
	border: 1px solid #ddd;
	background: white;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
}

.page-btn.active {
	background-color: #007bff;
	color: white;
	border-color: #007bff;
}

.add-diet-btn {
	padding: 8px 25px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: white;
	cursor: pointer;
}

.fix-diet-btn {
	padding: 8px 25px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: white;
	cursor: pointer;
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

				<div class="container">

					<main class="content-box">
						<h2
							style="font-size: 20px; margin-bottom: 20px; font-weight: bold;">식단
							라이브러리</h2>
                        <form method="GET" action="/fitralpark/dietRecommend.do">
						<div class="search-section">
							<h3 style="font-size: 16px; margin-bottom: 15px;">식단 검색</h3>

							<div class="search-filters">
								<div class="search-row">
									<div class="filter-group">
										<span>열량</span> <input type="text" placeholder="최소값"
											class="calorie-input" name="calorieMin"> <span>~</span> <input
											type="text" placeholder="최대값" class="calorie-input" name="calorieMax">
									</div>

									<div class="filter-item">
										<span class="filter-label">시간대</span>
										<div class="select-wrapper">
											<select class="filter-select" name="mealClassify">
												<option value="">식사 시간대</option>
												<option value="아침">아침</option>
												<option value="점심">점심</option>
												<option value="저녁">저녁</option>
												<option value="간식">간식</option>
											</select>
										</div>
									</div>

									<div class="filter-item">
										<span class="filter-label">식단 카테고리</span>
										<div class="select-wrapper">
											<select class="filter-select" name="dietCategory">
												<option value="">식단 카테고리</option>
												<option value="체중 감량">체중 감량</option>
												<option value="근육 증가">근육 증가</option>
												<option value="체중 관리 및 유지">체중 관리 및 유지</option>
												<option value="건강 관리">건강 관리</option>
												<option value="특정 목표를 위한 식단">특정 목표를 위한 식단</option>
												<option value="연령 및 성별 맞춤">연령 및 성별 맞춤</option>
											</select>
										</div>
									</div>

									<div class="filter-item search-box">
										<input type="text" placeholder="검색어를 입력하세요"
											class="search-input" name="searchTerm">
										<button class="search-icon">🔍</button>
									</div>
								</div>
							</div>
							<br>
							<div class="filter-options">
								<label class="checkbox-container"> <input
									type="checkbox" class="favorite-filter" name="favoriteFilter"> <span>즐겨찾기</span>
								</label> <label class="checkbox-container"> <input
									type="checkbox" class="my-meal-filter"  name="myMealFilter"> <span>나의
										식단</span>
								</label>
							</div>

						</div>
						</form>

						<div class="diet-list-section">
							<h3 style="font-wieght: bold; margin-bottom: 15px;">식단 리스트</h3>
							<div class="diet-list">
								<table class="diet-table">
									<thead>
										<tr>
											<th>선택</th>
											<th>식단명</th>
											<th>카테고리</th>
											<th>작성일</th>
											<th>열량</th>
											<th>식사시간대</th>
											<th>작성자</th>
											<th>즐겨찾기</th>
											<th>조회수</th>
										</tr>
									</thead>
									<tbody id="diet-data">
										<c:forEach items="${list}" var="dto">
											<tr>
												<td><input type="checkbox" data-id="${dto.diet_no}"></td>
												<td>${dto.diet_name}</td>
												<td>${dto.diet_category_name}</td>
												<td>${dto.regdate}</td>
												<td>${dto.diet_total_kcal}</td>
												<td>${dto.meal_classify}</td>
												<td>${dto.creator_id}</td>
												<td>
													<button class="star-btn" data-id="${dto.diet_no}">
														${dto.diet_bookmark_no > 0 ? '★' : '☆'}</button>
												</td>
												<td><span class="views-count" data-id="${dto.diet_no}">${dto.views}</span>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<!-- 음식 영양소 테이블 -->
								<div id="food-nutrients-section"
									style="margin-top: 20px; display: none;">
									<table class="food-table" border="1"
										style="width: 100%; text-align: center; border-collapse: collapse;">
										<thead>
											<tr>
												<th>음식명</th>
												<th>열량(kcal)</th>
												<th>단백질(g)</th>
												<th>탄수화물(g)</th>
												<th>지방(g)</th>
												<th>나트륨(mg)</th>
											</tr>
										</thead>
										<tbody id="food-data">
											<!-- 데이터가 없을 경우 -->
											<c:if test="${empty foods}">
												<tr>
													<td colspan="6">등록된 음식 정보가 없습니다.</td>
												</tr>
											</c:if>

											<!-- 데이터가 있을 경우 -->
											<c:forEach items="${foods}" var="food">
												<tr>
													<td>${food.food_name}</td>
													<td>${food.enerc}</td>
													<td>${food.protein}</td>
													<td>${food.chocdf}</td>
													<td>${food.fatce}</td>
													<td>${food.na}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- 추천/비추천 버튼 -->
									<div id="recommend-info" class="detail-buttons">
										
											<button class="recommend-btn">추천</button>
											<span class="recommend-count">0</span>
                                            /
                                            <button class="disrecommend-btn">비추천</button>
											<span class="disrecommend-count">0</span>
										
									</div>
								</div>


								<c:if test="${isSearch}">
									<div class="pagination">
										<%-- 이전 버튼 --%>
										<c:if test="${currentPage > 1}">
											<a href="dietRecommend.do?page=${currentPage - 1}"
												class="pagination-link">&lt;</a>
										</c:if>

										<%-- 페이지 번호 --%>
										<c:forEach begin="1" end="${totalPages}" var="page">
											<c:choose>
												<c:when test="${page == currentPage}">
													<span class="pagination-link active">${page}</span>
												</c:when>
												<c:otherwise>
													<a href="dietRecommend.do?page=${page}"
														class="pagination-link">${page}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>

										<%-- 다음 버튼 --%>
										<c:if test="${currentPage < totalPages}">
											<a href="dietLoading.do?page=${currentPage + 1}"
												class="pagination-link">&gt;</a>
										</c:if>
								    </div>
								
                                </c:if>
							</div>
							<div class="add-diet-section">
								<button class="add-diet-btn">
									<span class="plus-icon">+</span>새로운 식단 생성하기
								</button>
								<button class="fix-diet-btn">
									<span class="plus-icon">+</span>선택된 식단 불러오기
								</button>
							</div>
						</div>

				</main>
			</div>

		</div>
	</div>




	<div class="grid_bottom">
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>


</body>
<script>
//추천 식단 검색 기능
document.querySelector('.search-icon').addEventListener('click', function() {
    const calorieMin = document.querySelector('.calorie-min').value || 0;
    const calorieMax = document.querySelector('.calorie-max').value || 99999;
    const mealClassify = document.querySelector('.time-select').value;
    const searchTerm = document.querySelector('.search-input').value;
    const dietCategory = document.querySelector('.category-select').value; // 카테고리 추가
    const favoriteFilter = document.querySelector('.favorite-filter').checked ? 1 : 0;
    const myMealFilter = document.querySelector('.my-meal-filter').checked ? 1 : 0;

    // dietRecommend.do 엔드포인트로 요청
    fetch(`/dietRecommend.do?calorieMin=\${calorieMin}&calorieMax=\${calorieMax}&mealClassify=\${mealClassify}&searchTerm=\${searchTerm}&dietCategory=\${dietCategory}&favoriteFilter=\${favoriteFilter}&myMealFilter=\${myMealFilter}`)
        .then(response => response.json())
        .then(data => renderRecomTable(data))
        .catch(error => {
            console.error('추천 식단 로딩 실패:', error);
            alert('추천 식단을 불러오는 중 오류가 발생했습니다.');
        });
});

//즐겨찾기
    document.querySelectorAll('.star-btn').forEach(btn => {
        btn.addEventListener('click', async function(evt) {
            
            
            const dietNo = this.dataset.id;
            const isBookmarked = this.textContent.trim() === '★';
            
            try {
                const response = await fetch(`/fitralpark/dietFavorite.do?dietNo=\${dietNo}&memberId=hong`);
                if(response.ok) {
                    this.textContent = isBookmarked ? '☆' : '★';
                    this.dataset.bookmark = isBookmarked ? 0 : 1;
                    location.reload();
                }
            } catch(error) {
                console.error('북마크 처리 실패:', error);
            }
            

            evt.stopPropagation();
            return false;
        });
    });

document.addEventListener("DOMContentLoaded", function() {
    // 체크박스 클릭 이벤트 처리
    const checkboxes = document.querySelectorAll('input[type="checkbox"][data-id]');
    
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            // 다른 체크박스 모두 해제
            checkboxes.forEach(cb => {
                if (cb !== checkbox) cb.checked = false;
            });
            
            if (this.checked) {
                const dietNo = this.getAttribute('data-id');
                loadFoodNutrients(dietNo);
            } else {
                // 체크 해제시 영양소 테이블 숨김
                document.getElementById('food-nutrients-section').style.display = 'none';
            }
        });
    });
});

// 음식 영양소 정보 로드 함수
function loadFoodNutrients(dietNo) {
    fetch('/fitralpark/getFoodNuts.do?dietNo=' + dietNo)
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 오류: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            displayFoodNutrients(data.foods, data.recommend, data.disrecommend);
        })
        .catch(error => {
            console.error('데이터 로드 오류:', error);
            alert('음식 정보를 가져오는 중 오류가 발생했습니다.');
        });
    
    fetch('/fitralpark/getCount.do?dietNo=' + dietNo)
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('서버 오류: ' + response.status);
	        }
	        return response.json();
	    })
	    .then(data => {
	       document.querySelector('.recommend-count').textContent = data.recommend;
	       document.querySelector('.disrecommend-count').textContent = data.disrecommend;
	    })
	    .catch(error => {
	        console.error('데이터 로드 오류:', error);
	        alert('음식 정보를 가져오는 중 오류가 발생했습니다.');
	    });
}

// 영양소 정보 표시 함수
function displayFoodNutrients(foods, recommend, disrecommend) {
    const tableBody = document.getElementById('food-data');
    const section = document.getElementById('food-nutrients-section');
    const recommendInfo = document.getElementById('recommend-info');
    
    // 테이블 초기화
    tableBody.innerHTML = '';
    
    // 데이터가 없는 경우
    if (!foods || foods.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="6" style="text-align: center; padding: 10px;">등록된 음식 정보가 없습니다.</td></tr>';
    } else {
        // 데이터 행 추가
        foods.forEach(food => {
            tableBody.innerHTML += `
                <tr>
                    <td>\${food.food_name || ''}</td>
                    <td>\${food.enerc ? Number(food.enerc).toFixed(1) : '0'}</td>
                    <td>\${food.protein ? Number(food.protein).toFixed(1) : '0'}</td>
                    <td>\${food.chocdf ? Number(food.chocdf).toFixed(1) : '0'}</td>
                    <td>\${food.fatce ? Number(food.fatce).toFixed(1) : '0'}</td>
                    <td>\${food.na ? Number(food.na).toFixed(0) : '0'}</td>
                </tr>
            `;
        });
    }
    
    // 섹션 표시
    section.style.display = 'block';
}

//체크박스 클릭 시 조회수 증가
document.addEventListener('DOMContentLoaded', function() {
    // 체크박스 이벤트 처리
    const checkboxes = document.querySelectorAll('input[type="checkbox"][data-id]');
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            dietNo = this.getAttribute('data-id');
            updateViews(dietNo);
        });
    });
    
    // 추천 버튼 이벤트 처리
    const recommendBtns = document.querySelectorAll('.recommend-btn');
    recommendBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            //dietNo = this.getAttribute('data-id');)
            updateRecommend(dietNo);
        });
    });
    
    // 비추천 버튼 이벤트 처리
    const disrecommendBtns = document.querySelectorAll('.disrecommend-btn');
    disrecommendBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            //dietNo = this.getAttribute('data-id');
            updateDisrecommend(dietNo);
        });
    });
});

// 조회수 업데이트 함수
function updateViews(dietNo) {
    fetch('/fitralpark/dietupdate.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'dietNo=' + dietNo + '&type=views'
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            // 성공 시 화면에 조회수 업데이트 (선택사항)
            const viewsElement = document.querySelector(`.views-count[data-id="\${dietNo}"]`);
            if(viewsElement) {
                viewsElement.textContent = data.count;
            }
        }
    })
    .catch(error => console.error('Error:', error));
}

let dietNo;

// 추천수 업데이트 함수
function updateRecommend() {
    fetch('/fitralpark/dietupdate.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'dietNo=' + dietNo + '&type=recommend'
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            // 성공 시 화면에 추천수 업데이트
            //document.querySelector(`.recommend-count[data-id="\${dietNo}"]`).textContent = data.count;
            document.querySelector('.recommend-count').textContent = data.count;
        }
    })
    .catch(error => console.error('Error:', error));
}

// 비추천수 업데이트 함수
function updateDisrecommend() {
    fetch('/fitralpark/dietupdate.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'dietNo=' + dietNo + '&type=disrecommend'
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            // 성공 시 화면에 비추천수 업데이트
            //document.querySelector(`.disrecommend-count[data-id="\${dietNo}"]`).textContent = data.count;
        	document.querySelector('.disrecommend-count').textContent = data.count;
        }
    })
    .catch(error => console.error('Error:', error));
}

</script>

</html>

