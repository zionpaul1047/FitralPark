<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단 불러오기</title>
<style>
.detail-popup {
	position: absolute;
	background: white;
	border: 1px solid #ddd;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	z-index: 1000;
	width: 400px;
	padding: 15px;
}

.detail-table {
	width: 100%;
	border-collapse: collapse;
}

.detail-table th, .detail-table td {
	border: 1px solid #eee;
	padding: 8px;
	text-align: center;
}

.close-btn {
	float: right;
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

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Malgun Gothic', sans-serif;
	color: #333;
}

.container {
	max-width: 1035px; /* 해상도를 1035px로 조정 */
	margin: 20px auto;
	padding: 0 15px;
}

.title {
	font-size: 18px;
	margin-bottom: 15px;
	font-weight: bold;
}

.content-box {
	border: 1px solid #ccc;
	border-radius: 8px;
	padding: 20px;
	position: relative;
}

.search-section h2 {
	font-size: 16px;
	margin-bottom: 15px;
}

.search-row {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 20px;
}

.calorie-range {
	display: flex;
	align-items: center;
	gap: 5px;
}

.calorie-min, .calorie-max {
	width: 90px;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.time-select-container {
	display: flex;
	align-items: center;
	gap: 5px;
}

.custom-select {
	position: relative;
}

.time-select {
	padding: 8px;
	width: 130px;
	border: 1px solid #ddd;
	border-radius: 4px;
	appearance: none;
	background-image:
		url('data:image/svg+xml;utf8,<svg fill="black" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
	background-repeat: no-repeat;
	background-position: right 8px center;
}

.search-input {
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: 180px;
}

.search-icon {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 18px;
}

.meal-list-section h2 {
	font-size: 16px;
	margin-bottom: 15px;
}

.meal-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.meal-table th, .meal-table td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
	font-size: 14px;
	position: relative;
}

.meal-table th {
	background-color: #f8f8f8;
}

.star-btn {
	background: none;
	border: none;
	color: gold;
	cursor: pointer;
	font-size: 16px;
}

.view-btn {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 16px;
}

.pagination {
	display: flex;
	justify-content: center;
	gap: 5px;
	margin: 20px 0;
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

.page-btn:disabled {
	cursor: default;
	opacity: 0.5;
}

.action-buttons {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.load-btn, .cancel-btn {
	padding: 8px 25px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: white;
	cursor: pointer;
}

.detail-popup {
	position: absolute;
	background: white;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 15px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: none;
	width: 300px;
	z-index: 1000;
}

.detail-popup.active {
	display: block;
}

.popup-content h3 {
	margin-bottom: 10px;
}

.detail-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 15px;
}

.detail-table th, .detail-table td {
	padding: 6px;
	border: 1px solid #ddd;
	text-align: center;
	font-size: 14px;
}

.detail-table th {
	background-color: #f8f8f8;
}

.close-btn {
	padding: 5px 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: white;
	cursor: pointer;
	float: right;
}

.meal-table {
	table-layout: fixed;
	width: 100%;
}

.meal-table th:nth-child(1) {
	width: 5%;
} /* 체크박스 열 */
.meal-table th:nth-child(2) {
	width: 30%;
} /* 식단명 */
.meal-table th:nth-child(3) {
	width: 15%;
} /* 작성일 */
.meal-table th:nth-child(4) {
	width: 10%;
} /* 총열량 */
.meal-table th:nth-child(5) {
	width: 10%;
} /* 식사시간대 */
.meal-table th:nth-child(6) {
	width: 14%;
} /* 작성자 */
.meal-table th:nth-child(7) {
	width: 8%;
} /* 즐겨찾기 */
.meal-table th:nth-child(8) {
	width: 8%;
} /* 보기 버튼 */
.meal-table td {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.popup-content h3 {
	margin-bottom: 10px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	max-width: 100%;
}
</style>
</head>
<body>
	<div class="container">
		<h1 class="title">■ 식단 불러오기</h1>


		<div class="content-box">
			<form method="GET" action="/fitralpark/dietLoading.do">
				<div class="search-section">
					<div class="search-row">
						<div class="calorie-range">
							<span>열량</span> <input type="number" placeholder="최소값"
								class="calorie-min" min="0" step="10" name="calorieMin">
							<span>~</span> <input type="number" placeholder="최대값"
								class="calorie-max" min="0" step="10" name="calorieMax">
						</div>
						<div class="time-select-container">
							<span>시간대</span> <select class="time-select" name="mealClassify">
								<option value="">식사 시간대</option>
								<option value="아침">아침</option>
								<option value="점심">점심</option>
								<option value="저녁">저녁</option>
								<option value="간식">간식</option>
							</select>
						</div>
						<input type="text" placeholder="검색어를 입력하세요" class="search-input"
							name="searchTerm">
						<button class="search-icon">🔍</button>
					</div>
					<div class="filter-options">
						<label><input type="checkbox" class="favorite-filter"
							name="favoriteFilter"> 즐겨찾기</label> <label><input
							type="checkbox" class="my-meal-filter" name="myMealFilter">
							나의 식단</label>
					</div>
				</div>
				<br>
			</form>
		</div>

		<div class="meal-list-section">
			<h2>조회된 식단</h2>

			<table class="meal-table">
				<thead>
					<tr>
						<th>선택</th>
						<th>식단명</th>
						<th>작성일</th>
						<th>총열량(kcal)</th>
						<th>식사시간대</th>
						<th>작성자(닉네임)</th>
						<th>즐겨찾기</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="meal-data">
					<!-- 데이터는 JavaScript로 동적 생성 -->
					<c:forEach items="${list}" var="dto">
						<tr>
							<td><input type="checkbox" data-id="${dto.diet_no}"></td>
							<td>${dto.diet_name}</td>
							<td>${dto.regdate}</td>
							<td>${dto.diet_total_kcal}</td>
							<td>${dto.meal_classify}</td>
							<td>${dto.creator_id }</td>
							<td>
								<button class="star-btn" data-id="${dto.diet_no}">
									${dto.diet_bookmark_no > 0 ? '★' : '☆'}</button>
							</td>
							<td><button class="view-btn" data-id="${dto.diet_no}">
									<img src="assets/images/icon/search-file.png" alt="View"
										width="20" height="20">
								</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<c:if test="${isSearch}">
				<div class="pagination">
					<%-- 이전 버튼 --%>
					<c:if test="${currentPage > 1}">
						<a href="dietLoading.do?page=${currentPage - 1}"
							class="pagination-link">&lt;</a>
					</c:if>

					<%-- 페이지 번호 --%>
					<c:forEach begin="1" end="${totalPages}" var="page">
						<c:choose>
							<c:when test="${page == currentPage}">
								<span class="pagination-link active">${page}</span>
							</c:when>
							<c:otherwise>
								<a href="dietLoading.do?page=${page}" class="pagination-link">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<%-- 다음 버튼 --%>
					<c:if test="${currentPage < totalPages}">
						<a href="dietLoading.do?page=${currentPage + 1}"
							class="pagination-link">&gt;</a>
					</c:if>
				</div>
				<div class="action-buttons">
					<button class="load-btn">불러오기</button>
					<button class="cancel-btn">취소</button>
				</div>
			</c:if>
		</div>

		<!-- 상세정보 드롭다운 -->
		<div class="detail-popup" id="detailPopup" style="display: none;">
			<div class="popup-content">
				<h3 id="popup-title">식단 이름</h3>
				<table class="detail-table">
					<thead>
						<tr>
							<th>음식명</th>
							<th>열량(kcal)</th>
							<th>용량(g)</th>
						</tr>
					</thead>
					<tbody id="detail-body">
						<!-- 음식 상세정보는 JavaScript로 동적 생성 -->
					</tbody>
				</table>
				<button class="close-btn">닫기</button>
			</div>
		</div>
	</div>

	<script src="script.js"></script>
	<script>
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

	
	
	//상세정보
	document.addEventListener('DOMContentLoaded', function () {
	    document.querySelectorAll('.view-btn').forEach(button => {
	        button.addEventListener('click', async function () {
	        	
	            const dietNo = this.dataset.id;

	            try {
	                const response = await fetch(`/fitralpark/dietView.do?dietNo=\${dietNo}`);
	                if (!response.ok) throw new Error('서버 오류');
	                
	                const data = await response.json();
	                
	                console.log(data, data.map);

	                const popupTitle = document.querySelector('#popup-title');
	                const detailBody = document.querySelector('#detail-body');

	                detailBody.innerHTML = '';
	                
	                popupTitle.textContent = `\${data.dietName}`;
	                
	                data.foods.forEach(food => {
	                	detailBody.innerHTML += `
                        <tr>
                            <td>\${food.food_name}</td>
                            <td>\${food.enerc} kcal</td>
                            <td>\${food.food_size} g</td>
                        </tr>
                    `
	                });
	                
	                
	                document.querySelector('#detailPopup').style.display = 'block';
	            } catch (error) {
	                console.error('상세 정보 로딩 실패:', error);
	            }
	        });
	    });

	    document.querySelector('.close-btn').addEventListener('click', function () {
	        document.querySelector('#detailPopup').style.display = 'none';
	    });
	});


	
	//검색 기능
	document.querySelector('.search-icon').addEventListener('click', function() {
	    const calorieMin = document.querySelector('.calorie-min').value || 0;
	    const calorieMax = document.querySelector('.calorie-max').value || 99999;
	    const mealClassify = document.querySelector('.time-select').value;
	    const searchTerm = document.querySelector('.search-input').value;
	    const favoriteFilter = document.querySelector('.favorite-filter').checked ? 1 : 0;
	    const myMealFilter = document.querySelector('.my-meal-filter').checked ? 1 : 0;

	    fetch(`/dietLoading.do?calorieMin=${calorieMin}&calorieMax=${calorieMax}&mealClassify=${mealClassify}&searchTerm=${searchTerm}&favoriteFilter=${favoriteFilter}&myMealFilter=${myMealFilter}`)
	        .then(response => response.json())
	        .then(data => {
	            const tbody = document.querySelector('#meal-data');
	            tbody.innerHTML = data.map(dto => `
	                <tr>
	                    <td>${dto.diet_name}</td>
	                    <td>${dto.regdate}</td>
	                    <td>${dto.diet_total_kcal}</td>
	                    <td>${dto.meal_classify}</td>
	                    <td>${dto.creator_id}</td>
	                    <td>${dto.diet_bookmark_no > 0 ? '★' : '☆'}</td>
	                </tr>
	            `).join('');
	        });
	});
	
	
	//검색기능
	
	document.querySelector('.search-icon').addEventListener('click', function() {
    const calorieMin = document.querySelector('.calorie-min').value || 0;
    const calorieMax = document.querySelector('.calorie-max').value || 99999;
    const mealClassify = document.querySelector('.time-select').value;
    const searchTerm = document.querySelector('.search-input').value;
    const favoriteFilter = document.querySelector('.favorite-filter').checked ? 1 : 0;
    const myMealFilter = document.querySelector('.my-meal-filter').checked ? 1 : 0;

    fetch(`/dietLoading.do?calorieMin=${calorieMin}&calorieMax=${calorieMax}&mealClassify=${mealClassify}&searchTerm=${searchTerm}&favoriteFilter=${favoriteFilter}&myMealFilter=${myMealFilter}`)
        .then(response => response.json())
        .then(data => renderTable(data));
});

function renderTable(data) {
    const tbody = document.querySelector('#meal-data');
    tbody.innerHTML = data.map(dto => `
        <tr>
            <td>${dto.diet_name}</td>
            <td>${dto.regdate}</td>
            <td>${dto.diet_total_kcal}</td>
            <td>${dto.meal_classify}</td>
            <td>${dto.creator_id}</td>
            <td>${dto.diet_bookmark_no > 0 ? '★' : '☆'}</td>
        </tr>
    `).join('');
}


//즐겨찾기 토글
/* document.querySelectorAll('.star-btn').forEach(btn => {
    btn.addEventListener('click', async function(evt) {
    	
    	
        const dietNo = this.dataset.id;
        const isBookmarked = this.textContent.trim() === '★';
        
        try {
            const response = await fetch(`/fitralpark/dietFavorite.do?dietNo=${dietNo}`);
            if(response.ok) {
                this.textContent = isBookmarked ? '☆' : '★';
                this.dataset.bookmark = isBookmarked ? 0 : 1;
            }
        } catch(error) {
            console.error('북마크 처리 실패:', error);
        }
        

        evt.stopPropagation();
        return false;
    });
}); */


/* 
	document.addEventListener('DOMContentLoaded', function() {
	    // 상세 팝업 표시
	    document.querySelectorAll('.view-btn').forEach(btn => {
	        btn.addEventListener('click', async function(e) {
	            const dietNo = this.dataset.id;
	            const mealName = this.dataset.name;
	            showDetailPopup(dietNo, mealName, e);
	        });
	    });

	    // 팝업 닫기
	    document.querySelector('.close-btn').addEventListener('click', () => {
	        document.getElementById('detailPopup').style.display = 'none';
	    });

	    

	    // 검색 실행
	    document.querySelector('.search-icon').addEventListener('click', executeSearch);
	});

	async function showDetailPopup(dietNo, mealName, event) {
	    const popup = document.getElementById('detailPopup');
	    const tbody = document.getElementById('food-details');
	    
	    try {
	        const response = await fetch(`/diet/details?dietNo=${dietNo}`);
	        const details = await response.json();
	        
	        tbody.innerHTML = details.map(item => `
	            <tr>
	                <td>${item.foodName}</td>
	                <td>${item.calories}</td>
	                <td>${item.amount}</td>
	            </tr>
	        `).join('');
	        
	        // 팝업 위치 계산
	        const btnRect = event.target.getBoundingClientRect();
	        popup.style.left = `${btnRect.left + window.scrollX}px`;
	        popup.style.top = `${btnRect.bottom + window.scrollY}px`;
	        popup.style.display = 'block';
	        
	        document.getElementById('popup-meal-name').textContent = mealName;
	    } catch(error) {
	        console.error('상세 정보 조회 오류:', error);
	    }
	}

	function executeSearch() {
	    const params = new URLSearchParams({
	        search: document.querySelector('.search-input').value,
	        minCal: document.querySelector('.calorie-min').value || 0,
	        maxCal: document.querySelector('.calorie-max').value || 9999,
	        time: document.querySelector('.time-select').value
	    });
	    
	    window.location.href = `/dietLoading?${params.toString()}`;
	}

// 열량 입력 필드에 대한 이벤트 리스너 추가
document.querySelector('.calorie-min').addEventListener('change', validateCalories);
document.querySelector('.calorie-max').addEventListener('change', validateCalories);

// 열량 값 검증 함수
function validateCalories() {
  const minInput = document.querySelector('.calorie-min');
  const maxInput = document.querySelector('.calorie-max');
  
  // 최소값과 최대값 가져오기
  const minValue = parseInt(minInput.value) || 0;
  const maxValue = parseInt(maxInput.value) || 0;
  
  // 최소값이 0보다 작으면 0으로 설정
  if (minValue < 0) {
    minInput.value = 0;
  }
  
  // 최대값이 최소값보다 작으면 최소값으로 설정
  if (maxValue < minValue && maxValue !== 0) {
    maxInput.value = minValue;
  }
}

//JavaScript에서 팝업 내용 설정 시
document.getElementById('popup-meal-name').textContent = mealName;
document.getElementById('popup-meal-name').title = mealName; // 툴팁 추가

//페이지네이션
document.addEventListener('DOMContentLoaded', function () {
    let currentPage = 1;
    const itemsPerPage = 10;

    // 페이지네이션 및 데이터 로드
    async function loadPage(page) {
        try {
            const response = await fetch(`/diet/load?page=${page}&size=${itemsPerPage}`);
            const { list, totalPages } = await response.json();

            renderMealList(list);
            renderPagination(totalPages, page);
        } catch (error) {
            console.error('데이터 로드 실패:', error);
        }
    } 

    // 식단 목록 렌더링
    function renderMealList(mealData) {
        const tbody = document.getElementById('meal-data');
        tbody.innerHTML = mealData.map(meal => `
            <tr>
                <td><input type="checkbox" data-id="${meal.diet_no}"></td>
                <td>${meal.diet_name}</td>
                <td>${meal.regdate}</td>
                <td>${meal.diet_total_kcal}</td>
                <td>${meal.meal_classify}</td>
                <td>${meal.creator_id}</td>
                <td>
                    <button class="star-btn" data-id="${meal.diet_no}">
                        ${meal.diet_bookmark_no > 0 ? '★' : '☆'}
                    </button>
                </td>
                <td>
                    <button class="view-btn" data-id="${meal.diet_no}" data-name="${meal.diet_name}">
                        <img src="assets/images/icon/search-file.png" alt="View" width="20" height="20">
                    </button>
                </td>
            </tr>
        `).join('');
    }
    */


  </script>
</body>
</html>