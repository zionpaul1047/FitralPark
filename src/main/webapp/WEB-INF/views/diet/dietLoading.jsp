<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식단 불러오기</title>
<style>
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
  background-image: url('data:image/svg+xml;utf8,<svg fill="black" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
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
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
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

.meal-table th:nth-child(1) { width: 5%; }  /* 체크박스 열 */
.meal-table th:nth-child(2) { width: 30%; } /* 식단명 */
.meal-table th:nth-child(3) { width: 15%; } /* 작성일 */
.meal-table th:nth-child(4) { width: 10%; } /* 총열량 */
.meal-table th:nth-child(5) { width: 10%; } /* 식사시간대 */
.meal-table th:nth-child(6) { width: 14%; } /* 작성자 */
.meal-table th:nth-child(7) { width: 8%; } /* 즐겨찾기 */
.meal-table th:nth-child(8) { width: 8%; } /* 보기 버튼 */

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
        <div class="search-section">
          <h2>식단 검색</h2>
          
          <div class="search-row">
            <div class="calorie-range">
                <span>열량</span>
                <input type="number" placeholder="최소값" class="calorie-min" min="0" step="10">
                <span>~</span>
                <input type="number" placeholder="최대값" class="calorie-max" min="0" step="10">
              </div>
              
            
            <div class="time-select-container">
              <span>시간대</span>
              <div class="custom-select">
                <select class="time-select">
                  <option value="">식사 시간대</option>
                  <option value="아침">아침</option>
                  <option value="점심">점심</option>
                  <option value="저녁">저녁</option>
                  <option value="간식">간식</option>
                </select>
              </div>
            </div>
            
            <input type="text" placeholder="검색어를 입력하세요" class="search-input">
            <button class="search-icon">🔍</button>
          </div>
          
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
          <br>
          
        </div>
        
        <div class="meal-list-section">
          <h2>조회된 식단</h2>
          
          <table class="meal-table">
            <thead>
              <tr>
                <th></th>
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
            </tbody>
          </table>
          
          <div class="pagination" id="pagination">
            <!-- 페이지 버튼은 JavaScript로 동적 생성 -->
          </div>
          
          <div class="action-buttons">
            <button class="load-btn">불러오기</button>
            <button class="cancel-btn">취소</button>
          </div>
        </div>
        
        <!-- 상세 정보 팝업 (위치는 JavaScript로 동적 설정) -->
        <div class="detail-popup" id="detailPopup">
          <div class="popup-content">
            <h3 id="popup-meal-name">음식명</h3>
            <table class="detail-table">
              <thead>
                <tr>
                  <th>음식명</th>
                  <th>열량(kcal)</th>
                  <th>용량(g)</th>
                </tr>
              </thead>
              <tbody id="food-details">
                <!-- 상세 정보는 JavaScript로 동적 생성 -->
              </tbody>
            </table>
            <button class="close-btn">닫기</button>
          </div>
        </div>
      </div>
    </div>
  
    <script src="script.js"></script>
  </body>
  </html>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
  // 샘플 데이터
  const mealData = [
    { id: 1, name: "진성 평강인을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "김개반", favorite: true },
    { id: 2, name: "대표 훈련을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "이동욱", favorite: false },
    { id: 3, name: "진성 평강인을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "김개반", favorite: false },
    { id: 4, name: "대표 훈련을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "이동욱", favorite: false },
    { id: 5, name: "진성 평강인을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "김개반", favorite: false },
    { id: 6, name: "대표 훈련을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "이동욱", favorite: false },
    { id: 7, name: "진성 평강인을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "김개반", favorite: false },
    { id: 8, name: "대표 훈련을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "이동욱", favorite: false },
    { id: 9, name: "진성 평강인을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "김개반", favorite: false },
    { id: 10, name: "대표 훈련을 위한 아침식사", date: "2025.03.20.", calories: 500, time: "아침", author: "이동욱", favorite: false },
    { id: 11, name: "진성 평강인을 위한 점심식사", date: "2025.03.20.", calories: 700, time: "점심", author: "김개반", favorite: false },
    { id: 12, name: "대표 훈련을 위한 점심식사", date: "2025.03.20.", calories: 700, time: "점심", author: "이동욱", favorite: false }
  ];

  // 음식 상세 정보 샘플 데이터
  const foodDetailsData = {
    1: [
      { name: "닭가슴살", calories: 164.9, amount: 100 },
      { name: "치커리샐러드", calories: 24, amount: 100 },
      { name: "삶은 달걀", calories: 70, amount: 50 }
    ],
    2: [
      { name: "현미밥", calories: 130, amount: 100 },
      { name: "소고기", calories: 250, amount: 100 },
      { name: "된장국", calories: 45, amount: 200 }
    ],
    3: [
      { name: "닭가슴살", calories: 164.9, amount: 100 },
      { name: "치커리샐러드", calories: 24, amount: 100 },
      { name: "삶은 달걀", calories: 70, amount: 50 }
    ]
  };

  // 현재 페이지와 페이지당 항목 수
  let currentPage = 1;
  const itemsPerPage = 10;

  // 식단 목록 렌더링 (페이지네이션 적용)
  function renderMealList() {
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = Math.min(startIndex + itemsPerPage, mealData.length);
    const currentPageData = mealData.slice(startIndex, endIndex);
    
    const tbody = document.getElementById('meal-data');
    tbody.innerHTML = currentPageData.map(meal => `
      <tr>
        <td><input type="checkbox" data-id="${meal.id}"></td>
        <td>${meal.name}</td>
        <td>${meal.date}</td>
        <td>${meal.calories}</td>
        <td>${meal.time}</td>
        <td>${meal.author}</td>
        <td><button class="star-btn" data-id="${meal.id}">${meal.favorite ? '★' : '☆'}</button></td>
        <td><button class="view-btn" data-id="${meal.id}" data-name="${meal.name}">
      <img src="assets/images/icon/search-file.png" alt="View" width="20" height="20">
    </button></td>
      </tr>
    `).join('');

    // 보기 버튼 이벤트 리스너
    document.querySelectorAll('.view-btn').forEach(btn => {
      btn.addEventListener('click', function(e) {
        const mealId = this.getAttribute('data-id');
        const mealName = this.getAttribute('data-name');
        showDetailPopup(mealId, mealName, e);
      });
    });
  }

 // 음식 상세보기 팝업
 function showDetailPopup(mealId, mealName, event) {
  const popup = document.getElementById('detailPopup');
  
  // 팝업 위치 설정 (클릭한 버튼 옆에 표시)
  const button = event.target;
  const buttonRect = button.getBoundingClientRect();
  const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
  const popupWidth = 300; // 팝업의 너비
  
  // 화면 오른쪽 경계를 넘어가는지 확인
  const rightEdge = buttonRect.right + popupWidth;
  const windowWidth = window.innerWidth;
  

  popup.style.left = '800px';
  
  popup.style.top = (buttonRect.top + scrollTop) + 'px';
  
  // 팝업 내용 설정
  document.getElementById('popup-meal-name').textContent = mealName;
  
  // 음식 상세 정보 렌더링
  const details = foodDetailsData[mealId] || [];
  const tbody = document.getElementById('food-details');
  tbody.innerHTML = details.map(food => `
    <tr>
      <td>${food.name}</td>
      <td>${food.calories}</td>
      <td>${food.amount}</td>
    </tr>
  `).join('');
  
  // 팝업 표시
  popup.classList.add('active');
}



  // 페이지네이션 렌더링
  function renderPagination() {
    const totalPages = Math.ceil(mealData.length / itemsPerPage);
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';
    
    // 이전 버튼
    if (totalPages > 1) {
      const prevBtn = document.createElement('button');
      prevBtn.innerHTML = '&lt;';
      prevBtn.classList.add('page-btn', 'prev');
      prevBtn.disabled = currentPage === 1;
      prevBtn.addEventListener('click', () => {
        if (currentPage > 1) {
          currentPage--;
          renderMealList();
          renderPagination();
        }
      });
      pagination.appendChild(prevBtn);
    }

    // 페이지 번호 버튼
    const maxVisiblePages = 5;
    let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
    let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);
    
    if (endPage - startPage + 1 < maxVisiblePages) {
      startPage = Math.max(1, endPage - maxVisiblePages + 1);
    }
    
    for (let i = startPage; i <= endPage; i++) {
      const button = document.createElement('button');
      button.textContent = i;
      button.classList.add('page-btn');
      if (i === currentPage) button.classList.add('active');
      
      button.addEventListener('click', () => {
        currentPage = i;
        renderMealList();
        renderPagination();
      });
      
      pagination.appendChild(button);
    }

    // 다음 버튼
    if (totalPages > 1) {
      const nextBtn = document.createElement('button');
      nextBtn.innerHTML = '&gt;';
      nextBtn.classList.add('page-btn', 'next');
      nextBtn.disabled = currentPage === totalPages;
      nextBtn.addEventListener('click', () => {
        if (currentPage < totalPages) {
          currentPage++;
          renderMealList();
          renderPagination();
        }
      });
      pagination.appendChild(nextBtn);
    }
  }

  // 초기 데이터 로드 및 렌더링
  renderMealList();
  renderPagination();

  // 팝업 닫기 버튼
  document.querySelector('.close-btn').addEventListener('click', function() {
    document.getElementById('detailPopup').classList.remove('active');
  });

    // 즐겨찾기 토글
    document.addEventListener('click', function(e) {
    if (e.target.classList.contains('star-btn')) {
      e.target.textContent = e.target.textContent === '★' ? '☆' : '★';
      // 여기에 오라클 DB 업데이트 코드가 들어갈 수 있음
    }
  });

  // 검색 기능
  document.querySelector('.search-icon').addEventListener('click', function() {
    const searchTerm = document.querySelector('.search-input').value;
    const minCalorie = document.querySelector('.calorie-min').value;
    const maxCalorie = document.querySelector('.calorie-max').value;
    const mealTime = document.querySelector('.time-select').value;
    
    // 여기에 오라클 DB 검색 쿼리 코드가 들어갈 예정
    console.log('검색:', searchTerm, minCalorie, maxCalorie, mealTime);
    
    // 검색 결과 렌더링 (예시)
    // const searchResults = searchFromOracle(searchTerm, minCalorie, maxCalorie, mealTime);
    // renderMealList(searchResults);
    // renderPagination(searchResults.length);
  });

  // 불러오기 버튼 클릭 이벤트
  document.querySelector('.load-btn').addEventListener('click', function() {
    // 선택된 체크박스 찾기
    const selectedItems = [...document.querySelectorAll('input[type="checkbox"]:checked')].map(cb => {
      const row = cb.closest('tr');
      return {
        name: row.cells[1].textContent,
        date: row.cells[2].textContent,
        calories: row.cells[3].textContent,
        time: row.cells[4].textContent,
        author: row.cells[5].textContent
      };
    });
    
    if (selectedItems.length === 0) {
      alert('선택된 식단이 없습니다.');
      return;
    }
    
    // 여기에 선택된 식단을 부모 창으로 전달하는 코드가 들어갈 수 있음
    console.log('선택된 식단:', selectedItems);
    
    // 창 닫기 또는 다른 처리
    // window.close();
  });

  // 취소 버튼 클릭 이벤트
  document.querySelector('.cancel-btn').addEventListener('click', function() {
    // 창 닫기 또는 다른 처리
    // window.close();
  });
});

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

  </script>