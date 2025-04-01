<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <title>FITRALPARK</title>
   <%@ include file="/WEB-INF/views/common/asset.jsp" %>
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
        	width: 1060px;
        }
        .grid_bottom{
        /* border: 1px solid black; */
            grid-row: 3;
        }
   
		:root {
            --primary-color: #333;
            --secondary-color: #f8f8f8;
            --border-color: black;
            --container-width: 1060px;
            --spacing-unit: 20px;
            --font-family: 'Noto Sans KR', sans-serif;
            --transition-speed: 0.3s;
        }

        body {
            font-family: var(--font-family);
            line-height: 1.6;
            color: var(--primary-color);
            font-size: 14px;
        }

        .content-box {
            background-color: #fff;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            padding: var(--spacing-unit);
        }

        .container {
        	background-color: #FFF;
            max-width: var(--container-width);
            margin: 0 auto;
            padding: var(--spacing-unit);
            /* border: 1px solid var(--border-color); */
            margin-bottom: 20px;	
            border-radius: 20px;
        }

        /* 제목 스타일 조정 */
        h2.title {
            font-size: 24px;
            margin-bottom: var(--spacing-unit);
        }

        h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        /* 공통 스타일 */
        .table-cell {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid var(--border-color);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 200px;
            vertical-align: middle;
        }

        /* 체크박스 정렬 */
        .exercise-table input[type="checkbox"] {
            margin: 0 auto;
            display: block;
        }

        /* 테이블 셀 내부 요소 정렬 */
        .exercise-table td,
        .detail-table td {
            text-align: center;
        }

        .exercise-table td > *,
        .detail-table td > * {
            display: inline-block;
            text-align: center;
        }

        /* 별표 정렬 */
        .star {
            display: inline-block;
            text-align: center;
            width: 100%;
        }

        /* 각 컬럼별 최대 너비 설정 */
        .exercise-table th:nth-child(1),
        .exercise-table td:nth-child(1) {
            max-width: 40px; /* 체크박스 열 */
        }

        .exercise-table th:nth-child(2),
        .exercise-table td:nth-child(2) {
            max-width: 150px; /* 운동 이름 */
        }

        .exercise-table th:nth-child(3),
        .exercise-table td:nth-child(3) {
            max-width: 120px; /* 운동 카테고리 */
        }

        .exercise-table th:nth-child(4),
        .exercise-table td:nth-child(4) {
            max-width: 180px; /* 운동 효과 카테고리 */
        }

        .exercise-table th:nth-child(5),
        .exercise-table td:nth-child(5),
        .exercise-table th:nth-child(6),
        .exercise-table td:nth-child(6) {
            max-width: 100px; /* 칼로리, 시간 */
        }

        .exercise-table th:nth-child(7),
        .exercise-table td:nth-child(7) {
            max-width: 100px; /* 작성일 */
        }

        .exercise-table th:nth-child(8),
        .exercise-table td:nth-child(8) {
            max-width: 100px; /* 작성자 */
        }

        .exercise-table th:nth-child(9),
        .exercise-table td:nth-child(9) {
            max-width: 80px; /* 즐겨찾기 */
        }

        .exercise-table th:nth-child(10),
        .exercise-table td:nth-child(10) {
            max-width: 80px; /* 조회수 */
        }

        .spacing-1 { margin-bottom: 10px; }
        .spacing-2 { margin-bottom: 20px; }
        .spacing-3 { margin-bottom: 30px; }

        /* 검색 영역 스타일 */
        .search-section {
            margin-bottom: var(--spacing-unit);
            padding: 15px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .search-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .search-header h3 {
            margin: 0;
            margin-right: 15px;
        }

        .search-header .search-input-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-header .search-input {
        	border: 1px solid black;
            width: 200px;
        }

        .search-header .search-btn {
            padding: 5px 15px;
            background-color: var(--secondary-color);
            border: 1px solid var(--border-color);
            cursor: pointer;
            transition: all var(--transition-speed);
        }

        .search-options {
            display: flex;
            flex-direction: column;
        }

        .search-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .search-row span {
            margin-right: 10px;
            font-size: 14px;
        }

        .search-row input, 
        .search-row select {
            padding: 6px 8px;
            margin-right: 10px;
            border: 1px solid var(--border-color);
            transition: border-color var(--transition-speed);
            font-size: 14px;
        }

        .search-row input:focus,
        .search-row select:focus {
            outline: none;
            border-color: #007bff;
        }

        .calorie-min, .calorie-max {
            width: 100px;
        }

        .category-select {
            width: 150px;
        }

        .search-input {
            width: 200px;
        }

        .search-btn {
            padding: 5px 15px;
            background-color: var(--secondary-color);
            border: 1px solid var(--border-color);
            cursor: pointer;
            transition: all var(--transition-speed);
        }

        .search-btn:hover {
            background-color: #e9e9e9;
        }

        .search-btn:focus {
            outline: 2px solid #007bff;
            outline-offset: 2px;
        }

        /* 필터 영역 스타일 */
        .filter-section {
            margin-bottom: var(--spacing-unit);
            padding: 15px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .filter-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .filter-row span {
            margin-right: 20px;
            font-weight: bold;
            font-size: 14px;
        }

        .filter-row label {
            margin-right: 15px;
            display: flex;
            align-items: center;
            cursor: pointer;
            font-size: 14px;
        }

        .filter-row input[type="checkbox"] {
            margin-right: 5px;
            cursor: pointer;
        }

        /* 운동 리스트 영역 스타일 */
        .exercise-list-section {
            margin-bottom: var(--spacing-unit);
        }

        .exercise-list-section h3 {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .exercise-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: var(--spacing-unit);
        }

        .exercise-table th, 
        .exercise-table td {
            composes: table-cell;
            font-size: 14px;
            height: 50px;
            line-height: 1.5;
        }

        .exercise-table th {
            background-color: var(--secondary-color);
            font-weight: bold;
        }

        .star {
            color: gold;
            font-size: 16px;
            cursor: pointer;
            transition: opacity var(--transition-speed);
        }

        .star:hover {
            opacity: 0.8;
        }

        /* 운동 세부 정보 테이블 스타일 */
        .exercise-detail {
            margin-bottom: var(--spacing-unit);
            padding: 15px;
            border: 1px solid var(--border-color);
            background-color: #f9f9f9;
        }

        .exercise-detail h3 {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }

        .detail-table th, 
        .detail-table td {
            padding: 10px;
            text-align: center;
            border: 1px solid var(--border-color);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px; /* 기본 최대 너비 */
            font-size: 14px;
        }

        /* 세부 정보 테이블 컬럼별 최대 너비 설정 */
        .detail-table th:nth-child(1),
        .detail-table td:nth-child(1) {
            max-width: 120px; /* 운동 이름 */
        }

        .detail-table th:nth-child(2),
        .detail-table td:nth-child(2) {
            max-width: 180px; /* 세부적 효과 */
        }

        .detail-table th:nth-child(3),
        .detail-table td:nth-child(3) {
            max-width: 100px; /* 난이도 */
        }

        .detail-table th:nth-child(4),
        .detail-table td:nth-child(4) {
            max-width: 100px; /* 소모 칼로리 */
        }

        .detail-table th:nth-child(5),
        .detail-table td:nth-child(5),
        .detail-table th:nth-child(6),
        .detail-table td:nth-child(6),
        .detail-table th:nth-child(7),
        .detail-table td:nth-child(7),
        .detail-table th:nth-child(8),
        .detail-table td:nth-child(8) {
            max-width: 80px; /* 나머지 숫자 데이터 */
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 8px 15px;
            background-color: var(--secondary-color);
            border: 1px solid var(--border-color);
            border-radius: 4px;
            cursor: pointer;
            transition: all var(--transition-speed);
            font-size: 14px;
        }

        .btn:hover {
            background-color: #e9e9e9;
        }

        .btn:focus {
            outline: 2px solid #007bff;
            outline-offset: 2px;
        }

        /* 페이지네이션 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            margin: var(--spacing-unit) 0;
        }

        .pagination a {
            display: inline-block;
            padding: 5px 10px;
            margin: 0 5px;
            border: 1px solid var(--border-color);
            text-decoration: none;
            color: var(--primary-color);
            transition: all var(--transition-speed);
            font-size: 14px;
        }

        .pagination a:hover {
            background-color: var(--secondary-color);
        }

        .button-section {
            display: flex;
            justify-content: flex-end;
            margin-top: var(--spacing-unit);
        }

        .btn-large {
            padding: 10px 20px;
            background-color: #fff;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all var(--transition-speed);
        }

        .btn-large:hover {
            background-color: var(--secondary-color);
        }

        .btn-large:focus {
            outline: 2px solid #007bff;
            outline-offset: 2px;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .search-row {
                flex-direction: column;
                gap: 10px;
            }
            
            .search-row input,
            .search-row select {
                width: 100%;
                margin-right: 0;
            }
            
            .exercise-table {
                display: block;
                overflow-x: auto;
            }

            .filter-row {
                flex-wrap: wrap;
                gap: 10px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 5px;
            }

            .exercise-detail {
                padding: 10px;
            }

            .pagination {
                flex-wrap: wrap;
            }

            .pagination a {
                margin: 2px;
            }
            
            .sub-table {
		        width: 100%;
		        border-collapse: collapse;
		        background-color: #f9f9f9;
		    }
		    
		    .sub-table th, .sub-table td {
		        border: 1px solid #ccc;
		        padding: 6px;
		        text-align: center;
		        font-size: 14px;
		    }
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
        <h2 class="title">운동 라이브러리</h2>
        
        <!-- 운동 검색 영역 -->
        <div class="search-section">
            <div class="search-header">
                <h3>루틴 검색</h3>
                <div class="search-input-group">
                    <input type="text" class="search-input" placeholder="운동 검색">
                    <button class="search-btn">검색</button>
                </div>
            </div>
            <div class="search-options">
                <div class="search-row">
                    <span>소모 칼로리(kcal)</span>
                    <input type="text" class="calorie-min" placeholder="최소값"> ~ 
                    <input type="text" class="calorie-max" placeholder="최대값">
                    <span>운동 카테고리</span>
                    <select class="category-select">
                        <option value="">전체</option>
                        <option value="유산소 운동">유산소 운동</option>
                        <option value="근력 운동">근력 운동</option>
                        <option value="스트레칭">스트레칭</option>
                        <option value="코어 운동">코어 운동</option>
                        <option value="유연성 운동">유연성 운동</option>
                    </select>
                </div>
            </div>
        </div>
        
        <!-- 운동 필터 영역 -->
        <div class="filter-section">
            
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
            <div class="filter-row">
                <span>운동 분류 카테고리</span>
                <label><input type="checkbox" name="category" value="전신 운동"> 전신 운동</label>
                <label><input type="checkbox" name="category" value="코어/복부"> 코어/복부</label>
                <label><input type="checkbox" name="category" value="상체 운동"> 상체 운동</label>
                <label><input type="checkbox" name="category" value="하체/둔근 운동"> 하체/둔근 운동</label>
                <label><input type="checkbox" name="category" value="유산소 운동"> 유산소 운동</label>
                <label><input type="checkbox" name="category" value="맨몸 운동"> 맨몸 운동</label>
            </div>
            <div class="filter-row">
                <span>운동 난이도 수준</span>
                <label><input type="checkbox" name="level" value="초급"> 초급</label>
                <label><input type="checkbox" name="level" value="중급"> 중급</label>
                <label><input type="checkbox" name="level" value="고급"> 고급</label>
                <label><input type="checkbox" name="level" value="프로"> 프로</label>
            </div>
        </div>
        
        <!-- 운동 리스트 영역 -->
        <div class="exercise-list-section">
            <h3>운동 리스트</h3>
			<table class="exercise-table">
				<thead>
					<tr>
						<th>선택</th>
						<th>루틴 이름</th>
						<th>루틴 카테고리</th>
						<th>포함 운동 카테고리</th>
						<th>포함 운동 부위</th>
						<th>소모 총 열량(kcal)</th>
						<th>등록일</th>
						<th>작성자</th>
						<th>즐겨찾기</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr class="routine-row" data-routine-no="${dto.routineNo}">
							<td><input type="checkbox" /></td>
							<td>${dto.routineName}</td>
							<td>${dto.routineCategoryName}</td>
							<td>${dto.exerciseCategories}</td>
							<td>${dto.exerciseParts}</td>
							<td>${dto.totalCalories}</td>
							<td>${dto.creationDate}</td>
							<td>${dto.memberNickname}</td>
							<td>⭐</td>
							<td>${dto.views}</td>
						</tr>
						<tr class="exercise-detail" data-parent="${routine.routineNo}"
							style="display: none;">
							<td colspan="10">
								<table class="sub-table">
									<thead>
										<tr>
											<th>운동 이름</th>
											<th>운동 카테고리</th>
											<th>운동 부위</th>
											<th>소모 열량(kcal)</th>
											<th>시간(분)</th>
											<th>세트(회)</th>
											<th>세트 당 회수(회)</th>
											<th>중량(kg)</th>
										</tr>
									</thead>
									<tbody>
										<%-- <c:forEach var="exercise" items="${routine.exerciseList}"> --%>
											<tr>
												<td>${exercise.name}</td>
												<td>${exercise.category}</td>
												<td>${exercise.part}</td>
												<td>${exercise.calories}</td>
												<td>${exercise.time}</td>
												<td>${exercise.sets}</td>
												<td>${exercise.reps}</td>
												<td>${exercise.weight}</td>
											</tr>
										<%-- </c:forEach> --%>
									</tbody>
								</table>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
            <div class="button-section">
                <button class="btn-large">+ 운동 생성</button>
            </div>
        </div>
    </div>
</div>
			
		</div>
		
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>


	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script>
	
	const menuItems = document.querySelectorAll('.sf_submenu_1 div');
	
	    // 클릭 이벤트 추가
	    menuItems.forEach(item => {
	        item.addEventListener('click', () => {
                // 모든 항목의 스타일 초기화
                menuItems.forEach(menu => {
                menu.classList.remove('active'); // active 클래스 제거
                menu.style.backgroundColor = 'lightgray'; // 기본 배경색 설정
                menu.style.fontWeight = 'normal'; // 기본 글씨 굵기 설정
                });
        
                // 클릭된 항목에 스타일 적용
                item.classList.add('active'); // active 클래스 추가
                item.style.backgroundColor = 'oldlace'; // 클릭된 항목 배경색 설정
                item.style.fontWeight = 'bold'; // 클릭된 항목 글씨 굵게 설정
	        });
	    });
	
	
	
		$(document).ready(function () {
		    $('.routine-row').click(function() {
				const routineNo = $(this).data('routine-no');
                // 다른 펼쳐진 행은 닫기
				$('.exercise-detail').not('[data-parent="' + routineNo+ '"]').slideUp();
                // 해당 루틴의 상세 영역만 toggle
				const target = $('.exercise-detail[data-parent="' + routineNo + '"]');
				target.slideToggle();
			});
		});
        
	</script>
</body>
</html>