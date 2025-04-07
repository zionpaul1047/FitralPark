<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>루틴 불러오기</title>
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
      max-width: 1035px;
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

    .routine-category {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .routine-select {
      padding: 8px;
      width: 150px;
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

    .routine-list-section h2 {
      font-size: 16px;
      margin-bottom: 15px;
    }

    .routine-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
      table-layout: fixed;
    }

    .routine-table th, .routine-table td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: center;
      font-size: 14px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .routine-table th {
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
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      max-width: 100%;
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

.routine-table th:nth-child(1) { width: 5%; }  /* 체크박스 열 */
.routine-table th:nth-child(2) { width: 29%; } /* 루틴명 */
.routine-table th:nth-child(3) { width: 20%; } /* 루틴 카테고리 */
.routine-table th:nth-child(4) { width: 15%; } /* 작성일 */
.routine-table th:nth-child(5) { width: 15%; } /* 작성자 */
.routine-table th:nth-child(6) { width: 8%; } /* 즐겨찾기 */
.routine-table th:nth-child(7) { width: 8%; } /* 보기 */

.routine-table td {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;

  </style>
</head>
<body>
  <div class="container">
    <h1 class="title">■ 루틴 불러오기</h1>
    
    <div class="content-box">
      <div class="search-section">
        <h2>루틴 검색</h2>
        
        <div class="search-row">
          <div class="routine-category">
            <span>루틴 카테고리</span>
            <select class="routine-select">
              <option value="">전체</option>
              <option value="초보자 운동 루틴">초보자 운동 루틴</option>
              <option value="중급자 운동 루틴">중급자 운동 루틴</option>
              <option value="상급자 운동 루틴">상급자 운동 루틴</option>
              <option value="재활 운동 루틴">재활 운동 루틴</option>
            </select>
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
              <span>나의 루틴</span>
            </label>
          </div>
          <br>
        
      </div>
      
      <div class="routine-list-section">
        <h2>조회된 루틴</h2>
        
        <table class="routine-table">
          <thead>
            <tr>
              <th></th>
              <th>루틴 이름</th>
              <th>루틴 카테고리</th>
              <th>작성일</th>
              <th>작성자(닉네임)</th>
              <th>즐겨찾기</th>
              <th></th>
            </tr>
          </thead>
          <tbody id="routine-data">
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
      
      <!-- 상세 정보 팝업 -->
      <div class="detail-popup" id="detailPopup">
        <div class="popup-content">
          <h3 id="popup-routine-name">루틴의 운동리스트</h3>
          <table class="detail-table">
            <thead>
              <tr>
                <th>운동명</th>
                <th>소모칼로리(kcal)</th>
                <th>시간(분)</th>
              </tr>
            </thead>
            <tbody id="exercise-details">
              <!-- 상세 정보는 JavaScript로 동적 생성 -->
            </tbody>
          </table>
          <button class="close-btn">닫기</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // 샘플 데이터
      const routineData = [
        { id: 1, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: true },
        { id: 2, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 3, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 4, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 5, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 6, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 7, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 8, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 9, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 10, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 11, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 12, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 13, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false },
        { id: 14, name: "진성 발달 루틴", category: "초보자 운동 루틴", date: "2025.03.26", author: "김개반", favorite: false }

      ];

      // 운동 상세 정보 샘플 데이터
      const exerciseDetailsData = {
        1: [
          { name: "달리기", calories: 300, duration: 40 },
          { name: "팔굽혀 펴기", calories: 100, duration: 20 },
          { name: "윗몸 일으키기", calories: 100, duration: 20 }
        ],
        2: [
          { name: "달리기", calories: 300, duration: 40 },
          { name: "팔굽혀 펴기", calories: 100, duration: 20 },
          { name: "윗몸 일으키기", calories: 100, duration: 20 }
        ]
      };

      // 현재 페이지와 페이지당 항목 수
      let currentPage = 1;
      const itemsPerPage = 10;

      // 루틴 목록 렌더링 (페이지네이션 적용)
      function renderRoutineList() {
        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = Math.min(startIndex + itemsPerPage, routineData.length);
        const currentPageData = routineData.slice(startIndex, endIndex);
        
        const tbody = document.getElementById('routine-data');
        tbody.innerHTML = currentPageData.map(routine => `
          <tr>
            <td><input type="checkbox" data-id="${routine.id}"></td>
            <td>${routine.name}</td>
            <td>${routine.category}</td>
            <td>${routine.date}</td>
            <td>${routine.author}</td>
            <td><button class="star-btn" data-id="${routine.id}">${routine.favorite ? '★' : '☆'}</button></td>
            <td><button class="view-btn" data-id="${routine.id}" data-name="${routine.name}">
      <img src="assets/images/icon/search-file.png" alt="View" width="20" height="20">
    </button></td>
          </tr>
        `).join('');

        // 보기 버튼 이벤트 리스너
        document.querySelectorAll('.view-btn').forEach(btn => {
          btn.addEventListener('click', function(e) {
            const routineId = this.getAttribute('data-id');
            const routineName = this.getAttribute('data-name');
            showDetailPopup(routineId, routineName, e);
          });
        });
      }

      // 운동 상세 정보 팝업 표시
      function showDetailPopup(routineId, routineName, event) {
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
        document.getElementById('popup-routine-name').textContent = routineName;
        
        // 운동 상세 정보 렌더링
        const details = exerciseDetailsData[routineId] || [];
        const tbody = document.getElementById('exercise-details');
        tbody.innerHTML = details.map(exercise => `
          <tr>
            <td>${exercise.name}</td>
            <td>${exercise.calories}</td>
            <td>${exercise.duration}</td>
          </tr>
        `).join('');
        
        // 팝업 표시
        popup.classList.add('active');
      }

      // 페이지네이션 렌더링
      function renderPagination() {
        const totalPages = Math.ceil(routineData.length / itemsPerPage);
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';
        
        if (totalPages <= 1) return;

        // 이전 버튼
        const prevBtn = document.createElement('button');
        prevBtn.innerHTML = '&lt;';
        prevBtn.classList.add('page-btn', 'prev');
        prevBtn.disabled = currentPage === 1;
        prevBtn.addEventListener('click', () => {
          if (currentPage > 1) {
            currentPage--;
            renderRoutineList();
            renderPagination();
          }
        });
        pagination.appendChild(prevBtn);

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
            renderRoutineList();
            renderPagination();
          });
          
          pagination.appendChild(button);
        }

        // 다음 버튼
        const nextBtn = document.createElement('button');
        nextBtn.innerHTML = '&gt;';
        nextBtn.classList.add('page-btn', 'next');
        nextBtn.disabled = currentPage === totalPages;
        nextBtn.addEventListener('click', () => {
          if (currentPage < totalPages) {
            currentPage++;
            renderRoutineList();
            renderPagination();
          }
        });
        pagination.appendChild(nextBtn);
      }

      // 초기 데이터 로드 및 렌더링
      renderRoutineList();
      renderPagination();

      // 팝업 닫기 버튼
      document.querySelector('.close-btn').addEventListener('click', function() {
        document.getElementById('detailPopup').classList.remove('active');
      });

      // 즐겨찾기 토글
      document.addEventListener('click', function(e) {
        if (e.target.classList.contains('star-btn')) {
          e.target.textContent = e.target.textContent === '★' ? '☆' : '★';
        }
      });

      // 검색 기능
      document.querySelector('.search-icon').addEventListener('click', function() {
        const searchTerm = document.querySelector('.search-input').value;
        const routineCategory = document.querySelector('.routine-select').value;
        
        console.log('검색:', searchTerm, routineCategory);
      });

      // 불러오기 버튼 클릭 이벤트
      document.querySelector('.load-btn').addEventListener('click', function() {
        const selectedItems = [...document.querySelectorAll('input[type="checkbox"]:checked')].map(cb => {
          const row = cb.closest('tr');
          return {
            name: row.cells[1].textContent,
            category: row.cells[2].textContent,
            date: row.cells[3].textContent,
            author: row.cells[4].textContent
          };
        });
        
        if (selectedItems.length === 0) {
          alert('선택된 루틴이 없습니다.');
          return;
        }
        
        console.log('선택된 루틴:', selectedItems);
      });
    });
  </script>
</body>
</html>
