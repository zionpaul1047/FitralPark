<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식 불러오기</title>
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

.food-list-section h2 {
    font-size: 16px;
    margin-bottom: 15px;
}

.food-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.food-table th, .food-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
    font-size: 14px;
    position: relative;
}

.food-table th {
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

.food-table {
    table-layout: fixed;
    width: 100%;
}

.food-table th:nth-child(1) {
    width: 5%;
} /* 체크박스 열 */
.food-table th:nth-child(2) {
    width: 20%;
} /* 음식명 */
.food-table th:nth-child(3) {
    width: 10%;
} /* 대표음식명 */
.food-table th:nth-child(4) {
    width: 7%;
} /* 용량 */
.food-table th:nth-child(5) {
    width: 7%;
} /* 열량 */
.food-table th:nth-child(6) {
    width: 8%;
} /* 탄수화물 */
.food-table th:nth-child(7) {
    width: 8%;
} /* 단백질 */
.food-table th:nth-child(8) {
    width: 8%;
}  /* 지방 */
.food-table th:nth-child(9) {
    width: 8%;
}  /* 당류 */
.food-table th:nth-child(10) {
    width: 8%;}
}  /* 나트륨 */
.food-table th:nth-child(11) {
    width: 5%;
    /* 즐겨찾기 */

}

.custom-food-table {
    table-layout: fixed;
    width: 100%;
}

.custom-food-table th:nth-child(1) {
    width: 5%;
} 
.custom-food-table th:nth-child(2) {
    width: 15%;
} 
.custom-food-table th:nth-child(3) {
    width: 10%;
} 
.custom-food-table th:nth-child(4) {
    width: 10%;
}
.custom-food-table th:nth-child(5) {
    width: 10%;
} 
.custom-food-table th:nth-child(6) {
    width: 10%;
} 
.custom-food-table th:nth-child(7) {
    width: 10%;
} 
.custom-food-table th:nth-child(8) {
    width: 10%;
}  
.custom-food-table th:nth-child(9) {
    width: 10%;
} 
.custom-food-table th:nth-child(10) {
    width: 10%;}
} 

.custom-food-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.custom-food-table th, .custom-food-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
    font-size: 14px;
    position: relative;
}

.custom-food-table th {
    background-color: #f8f8f8;
}
</style>
</head>
<body>
    <div class="container">
        <h1 class="title">■ 음식 불러오기</h1>


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
                
                        <input type="text" placeholder="검색어를 입력하세요" class="search-input"
                            name="searchTerm">
                        <button class="search-icon">🔍</button>
                    </div>
<!--                     <div class="filter-options">
                        <label><input type="checkbox" class="favorite-filter"
                            name="favoriteFilter"> 즐겨찾기</label> <label><input
                            type="checkbox" class="my-meal-filter" name="myMealFilter">
                            나의 음식</label>
                    </div> -->
                </div>
            </form>
        </div>
<br>
        <div class="food-list-section">
            <h2>음식 리스트</h2>

            <table class="food-table">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>음식명</th>
                        <th>대표 음식명</th>
                        <th>용량(g)</th>
                        <th>열량(kcal)</th>
                        <th>탄수화물(g)</th>
                        <th>단백질(g)</th>
                        <th>지방(g)</th>
                        <th>당류(g)</th>
                        <th>나트륨(mg)</th>
                        <th>즐겨찾기</th>
                    </tr>
                </thead>
                <tbody id="food-data">
                    <!-- 데이터는 JavaScript로 동적 생성 -->
                    <c:forEach items="${list}" var="dto">
                        <tr>
                            <td><input type="checkbox" data-id="${dto.food_cd}"></td>
                            <td>${dto.food_name}</td>
                            <td>${dto.foodlv4_name}</td>
                            <td>${dto.nut_con_str_qua}</td>
                            <td>${dto.enerc}</td>
                            <td>${dto.chocdf}</td>
                            <td>${dto.protein}</td>
                            <td>${dto.fatce}</td>
                            <td>${dto.sugar}</td>
                            <td>${dto.na}</td>
                            <td>
                                <button class="star-btn" data-id="${dto.food_no}">
                                    ${dto.food_bookmark_no > 0 ? '★' : '☆'}</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <h2>나의 음식 리스트</h2>
                        <table class="custom-food-table">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>음식명</th>
                        <th>용량(g)</th>
                        <th>열량(kcal)</th>
                        <th>탄수화물(g)</th>
                        <th>단백질(g)</th>
                        <th>지방(g)</th>
                        <th>당류(g)</th>
                        <th>나트륨(mg)</th>
                        <th>즐겨찾기</th>
                    </tr>
                </thead>
                <tbody id="custom-food-data">
                        <tr>
                            <td><input type="checkbox" data-id=""></td>
                            <td>닭가슴살</td>
                            <td>100</td>
                            <td>165</td>
                            <td>0</td>
                            <td>31</td>
                            <td>3.6</td>
                            <td>0</td>
                            <td>74</td>
                            <td>
                                <button class="star-btn" >★
                                   </button>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" data-id=""></td>
                            <td>사과</td>
                            <td>100</td>
                            <td>48</td>
                            <td>12.76</td>
                            <td>1</td>
                            <td>3.6</td>
                            <td>10.1</td>
                            <td>0</td>
                            <td>
                                <button class="star-btn" >★
                                   </button>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" data-id=""></td>
                            <td>오렌지</td>
                            <td>100</td>
                            <td>47</td>
                            <td>0</td>
                            <td>11</td>
                            <td>3.6</td>
                            <td>9.35</td>
                            <td>74</td>
                            <td>
                                <button class="star-btn" >★
                                   </button>
                            </td>
                        </tr>
                </tbody>
                <%-- <tbody id="custom-food-data">
                    <!-- 데이터는 JavaScript로 동적 생성 -->
                    <c:forEach items="${list2}" var="dto">
                        <tr>
                            <td><input type="checkbox" data-id="${dto.food_cd}"></td>
                            <td>${dto.food_name}</td>
                            <td>${dto.foodlv4_name}</td>
                            <td>${dto.nut_con_str_qua}</td>
                            <td>${dto.chocdf}</td>
                            <td>${dto.protein}</td>
                            <td>${dto.fatce}</td>
                            <td>${dto.sugar}</td>
                            <td>${dto.na}</td>
                            <td>
                                <button class="star-btn" data-id="${dto.diet_no}">
                                    ${dto.diet_bookmark_no > 0 ? '★' : '☆'}</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody> --%>
            </table>

            <c:if test="${isSearch}">
                <div class="pagination">
                    <%-- 이전 버튼 --%>
                    <c:if test="${currentPage > 1}">
                        <a href="dietFoodLoading.do?page=${currentPage - 1}"
                            class="pagination-link">&lt;</a>
                    </c:if>

                    <%-- 페이지 번호 --%>
                    <c:forEach begin="1" end="${totalPages}" var="page">
                        <c:choose>
                            <c:when test="${page == currentPage}">
                                <span class="pagination-link active">${page}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="dietFoodLoading.do?page=${page}" class="pagination-link">${page}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <%-- 다음 버튼 --%>
                    <c:if test="${currentPage < totalPages}">
                        <a href="dietFoodLoading.do?page=${currentPage + 1}"
                            class="pagination-link">&gt;</a>
                    </c:if>
                </div>
                <div class="action-buttons">
                    <button class="load-btn">불러오기</button>
                    <button class="cancel-btn">취소</button>
                </div>
            </c:if>
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



  </script>
</body>
</html>