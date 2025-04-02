<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>식단 라이브러리</title>
    <style>
    
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
    position:relative;
    right: 155px;
    bottom:15px;
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
    right:30px;
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
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
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
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
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

.diet-table th,
.diet-table td {
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

.star-btn {
    background: none;
    border: none;
    color: #ccc;
    font-size: 18px;
    cursor: pointer;
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

.food-table th,
.food-table td {
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

.confirm-btn,
.cancel-btn {
    padding: 8px 15px;
    border
}

.diet-table {
    table-layout: fixed;
    width: 100%;
}

.diet-table th:nth-child(1) { width: 5%; }  /* 체크박스 열 */
.diet-table th:nth-child(2) { width: 23%; } /* 식단명 */
.diet-table th:nth-child(3) { width: 15%; } /* 식단 카테고리 */
.diet-table th:nth-child(4) { width: 10%; } /* 작성일 */
.diet-table th:nth-child(5) { width: 10%; } /* 총열량 */
.diet-table th:nth-child(6) { width: 9%; } /* 식사시간대 */
.diet-table th:nth-child(7) { width: 10%; } /* 작성자 */
.diet-table th:nth-child(8) { width: 8%; }  /* 즐겨찾기 */
.diet-table th:nth-child(9) { width: 10%; } /* 조회수 */

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
                <%@ include file="/WEB-INF/views/common/header.jsp" %>
                <!-- 오른쪽메뉴 -->
                <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
                <!-- 왼쪽메뉴 -->
                <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>
        </div>
        
        <div class="grid_center">
        
            <div class="grid_center_L"></div>
            
            <div class="grid_center_R">
                
                <div class="container">
        
        <main class="content-box">
            <h2 style="font-size: 20px; margin-bottom: 20px; font-weight: bold;">식단 라이브러리</h2>
            
            <div class="search-section">
                <h3 style="font-size: 16px; margin-bottom: 15px;">식단 검색</h3>
                
                <div class="search-filters">
                    <div class="search-row">
                        <div class="filter-group">
                            <span>열량</span>
                            <input type="text" placeholder="최소값" class="calorie-input">
                            <span>~</span>
                            <input type="text" placeholder="최대값" class="calorie-input">
                        </div>
                        
                        <div class="filter-item">
                            <span class="filter-label">시간대</span>
                            <div class="select-wrapper">
                                <select class="filter-select">
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
                                <select class="filter-select">
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
                            <input type="text" placeholder="검색어를 입력하세요" class="search-input">
                            <button class="search-btn">🔍</button>
                        </div>
                </div>
            </div>
            <br>
            <div class="filter-options">
            <label class="checkbox-container">
              <input type="checkbox" class="favorite-filter">
              <span>즐겨찾기</span>
            </label>
            <label class="checkbox-container">
              <input type="checkbox" class="my-meal-filter">
              <span>나의 식단</span>
            </label>
          </div>
         
        </div>
            
            <div class="diet-list-section">
                <h3>식단 리스트</h3>
                
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
  <tbody>
    <!-- 식단 목록 -->
    <tr data-row-id="1">
      <td><input type="checkbox" class="row-checkbox" data-id="1"></td>
      <td>단백질이 풍부한 아침식사</td>
      <td>근육 증가</td>
      <td>2023.03.20.</td>
      <td>500</td>
      <td>아침</td>
      <td>김제트</td>
      <td><button class="star-btn" data-id="1">★</button></td>
      <td>150</td>
    </tr>

    <!-- 상세정보 행 -->
    <tr class="detail-row" id="detail-1">
      <td colspan="9">
        <div class="food-details">
          <table class="food-table">
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
            <tbody>
              <tr>
                <td>삶은계란</td>
                <td>155.4</td>
                <td>100</td>
                <td>0</td>
                <td>3.7</td>
                <td>39</td>
              </tr>
            </tbody>
          </table>

          <!-- 추천/비추천 버튼 -->
          <div class="detail-buttons">
            <button class="confirm-btn">추천 21</button>
            <button class="cancel-btn">비추천 2</button>
          </div>

        </div>
      </td>
    </tr>

    <!-- 추가 식단 항목들 -->
    <!-- 동일한 구조 반복 -->
  </tbody>
</table>
</div>

<div class="food-section">  
  <div class="food-details" id="foodDetailsContainer" style="display: none;">
    <table class="food-table">
      <thead>
        <tr>
          <th>음식명</th>
          <th>열량(kcal)</th>
          <th>단백질(g)</th>
          <th>탄수화물(g)</th>
          <th>지방(g)</th>
          <th>나트륨(mg)</th>
          <th>용량(g)</th>
        </tr>
      </thead>

    </table>
    <div class="detail-buttons">
      <button class="confirm-btn">추천 21</button>
      <button class="cancel-btn">비추천 2</button>
    </div>
  </div>
                <div class="pagination" id="pagination">
                    <!-- 페이지 버튼은 JavaScript로 동적 생성 -->
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
            
        </div>
        
        <div class="grid_bottom">
                <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
        
    
</body>
</html>

<script>
document.addEventListener('DOMContentLoaded', function () {
	  // 기본 설정
	  let currentPage = 1; // 현재 페이지
	  const itemsPerPage = 10; // 페이지당 항목 수

	  // 샘플 데이터 (실제 데이터는 서버에서 가져와야 함)
	  const dietData = [
	    { id: 1, name: "단백질이 풍부한 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "김제트", favorite: true, views: 150 },
	    { id: 2, name: "다양한 종류로 만든 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "박블랙", favorite: false, views: 10 },
	       { id: 3, name: "단백질이 풍부한 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "김제트", favorite: true, views: 150 },
	        { id: 4, name: "다양한 종류로 만든 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "박블랙", favorite: false, views: 10 },
	        { id: 5, name: "단백질이 풍부한 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "김제트", favorite: true, views: 150 },
	        { id: 6, name: "다양한 종류로 만든 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "박블랙", favorite: false, views: 10 },
	           { id: 7, name: "단백질이 풍부한 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "김제트", favorite: true, views: 150 },
	            { id: 8, name: "다양한 종류로 만든 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "박블랙", favorite: false, views: 10 },
	            { id: 9, name: "단백질이 풍부한 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "김제트", favorite: true, views: 150 },
	            { id: 10, name: "다양한 종류로 만든 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "박블랙", favorite: false, views: 10 },
	               { id: 11, name: "단백질이 풍부한 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "김제트", favorite: true, views: 150 },
	                { id:12, name: "다양한 종류로 만든 아침식사", category: "근육 증가", date: "2023.03.20.", calories: 500, mealTime: "아침", author: "박블랙", favorite: false, views: 10 },
	    // 더 많은 데이터 추가 가능
	  ];

	  // 식단 목록 렌더링
	  function renderDietList() {
	    const startIndex = (currentPage - 1) * itemsPerPage;
	    const endIndex = Math.min(startIndex + itemsPerPage, dietData.length);
	    const currentPageData = dietData.slice(startIndex, endIndex);

	    const tbody = document.querySelector('.diet-table tbody');
	    tbody.innerHTML = ''; // 기존 내용 초기화

	    currentPageData.forEach((diet) => {
	      const row = document.createElement('tr');
	      row.innerHTML = `
	        <td><input type="checkbox" class="row-checkbox" data-id="${diet.id}"></td>
	        <td>${diet.name}</td>
	        <td>${diet.category}</td>
	        <td>${diet.date}</td>
	        <td>${diet.calories}</td>
	        <td>${diet.mealTime}</td>
	        <td>${diet.author}</td>
	        <td><button class="star-btn" data-id="${diet.id}">${diet.favorite ? '★' : '☆'}</button></td>
	        <td>${diet.views}</td>
	      `;
	      tbody.appendChild(row);
	    });
	  }

	  // 페이지네이션 렌더링
	  function renderPagination() {
	    const totalPages = Math.ceil(dietData.length / itemsPerPage);
	    const paginationContainer = document.getElementById('pagination');
	    paginationContainer.innerHTML = ''; // 기존 내용 초기화

	    // 이전 버튼
	    if (currentPage > 1) {
	      const prevButton = document.createElement('button');
	      prevButton.textContent = '<';
	      prevButton.classList.add('page-btn');
	      prevButton.addEventListener('click', () => {
	        currentPage--;
	        renderDietList();
	        renderPagination();
	      });
	      paginationContainer.appendChild(prevButton);
	    }

	    // 페이지 번호 버튼
	    for (let i = 1; i <= totalPages; i++) {
	      const pageButton = document.createElement('button');
	      pageButton.textContent = i;
	      pageButton.classList.add('page-btn');
	      if (i === currentPage) {
	        pageButton.classList.add('active');
	      }
	      pageButton.addEventListener('click', () => {
	        currentPage = i;
	        renderDietList();
	        renderPagination();
	      });
	      paginationContainer.appendChild(pageButton);
	    }

	    // 다음 버튼
	    if (currentPage < totalPages) {
	      const nextButton = document.createElement('button');
	      nextButton.textContent = '>';
	      nextButton.classList.add('page-btn');
	      nextButton.addEventListener('click', () => {
	        currentPage++;
	        renderDietList();
	        renderPagination();
	      });
	      paginationContainer.appendChild(nextButton);
	    }
	  }

	  // 초기화 함수
	  function init() {
	    renderDietList();
	    renderPagination();
	  }

	  init(); // 초기화 실행
	});

document.addEventListener('DOMContentLoaded', function () {
	  // 체크박스 선택 시 상세정보 표시/숨김
	  document.querySelectorAll('.row-checkbox').forEach(checkbox => {
	    checkbox.addEventListener('change', function () {
	      const rowId = this.getAttribute('data-id');
	      const detailRow = document.getElementById(`detail-${rowId}`);

	      if (this.checked) {
	        // 다른 체크박스 해제
	        document.querySelectorAll('.row-checkbox').forEach(cb => {
	          if (cb !== this) cb.checked = false;
	        });

	        // 상세정보 표시
	        if (detailRow) {
	          detailRow.style.display = 'table-row';
	        }
	      } else {
	        // 상세정보 숨김
	        if (detailRow) {
	          detailRow.style.display = 'none';
	        }
	      }
	    });
	  });

	  // 별표 버튼 클릭 시 즐겨찾기 상태 토글 (상세정보와 관련 없음)
	  document.querySelectorAll('.star-btn').forEach(button => {
	    button.addEventListener('click', function (e) {
	      e.stopPropagation(); // 상위 이벤트 방지
	      const currentText = this.textContent;
	      this.textContent = currentText === '★' ? '☆' : '★';

	      // 즐겨찾기 상태 변경 후 체크박스 상태는 변경하지 않음
	      const rowId = this.getAttribute('data-id');
	      const checkbox = document.querySelector(`.row-checkbox[data-id="${rowId}"]`);
	      if (checkbox && checkbox.checked) {
	        checkbox.checked = false;
	        checkbox.dispatchEvent(new Event('change'));
	      }
	    });
	  });

	  // 초기화: 모든 상세정보 숨기기
	  document.querySelectorAll('.detail-row').forEach(row => {
	    row.style.display = 'none';
	  });
	});

</script>