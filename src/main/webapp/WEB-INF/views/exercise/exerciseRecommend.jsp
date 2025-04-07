<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <title>FITRALPARK</title>
   <%@ include file="/WEB-INF/views/common/asset.jsp" %>
   <script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
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
            border: 2px solid var(--border-color);
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
            margin: auto 10px;
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

        /* 첫 번째 선언 */
        .exercise-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: var(--spacing-unit);
            border: 1px solid #e0e0e0;
            table-layout: fixed;
        }

        .exercise-table th {
            background-color: #f5f5f5;
            font-weight: 600;
            border-right: 1px solid #e0e0e0;
            border-bottom: 2px solid #e0e0e0;
            padding: 15px 10px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .exercise-table td {
            padding: 15px 10px;
            border-right: 1px solid #e0e0e0;
            border-bottom: 1px solid #e0e0e0;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: center;
            word-break: break-word;
        }

        /* 각 열의 너비 조정 */
        .exercise-table th:nth-child(1), /* 선택 */
        .exercise-table td:nth-child(1) {
            width: 5%;
        }

        .exercise-table th:nth-child(2), /* 루틴 이름 */
        .exercise-table td:nth-child(2) {
            width: 15%;
        }

        .exercise-table th:nth-child(3), /* 루틴 카테고리 */
        .exercise-table td:nth-child(3) {
            width: 11%;
        }

        .exercise-table th:nth-child(4), /* 운동 카테고리 */
        .exercise-table td:nth-child(4) {
            width: 12%;
        }

        .exercise-table th:nth-child(5), /* 운동 부위 */
        .exercise-table td:nth-child(5) {
            width: 10%;
        }

        .exercise-table th:nth-child(6), /* 소모 총 열량 */
        .exercise-table td:nth-child(6) {
            width: 10%;
        }

        .exercise-table th:nth-child(7), /* 등록일 */
        .exercise-table td:nth-child(7) {
            width: 10%;
        }

        .exercise-table th:nth-child(8), /* 작성자 */
        .exercise-table td:nth-child(8) {
            width: 7%;
        }

        .exercise-table th:nth-child(9), /* 즐겨찾기 */
        .exercise-table td:nth-child(9) {
            width: 8%;
        }

        .exercise-table th:nth-child(10), /* 조회수 */
        .exercise-table td:nth-child(10) {
            width: 7%;
        }

        .exercise-table th:nth-child(11), /* 수정 */
        .exercise-table td:nth-child(11) {
            width: 5%;
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
            margin: 10px 0;  /* 상하 여백 조정 */
            padding: 20px 30px;  /* 좌우 패딩 증가 */
            border: 1px solid #ddd;  /* 테두리 색상 밝게 */
            background-color: #f8f8f8;  /* 배경색 밝게 */
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);  /* 미묘한 그림자 추가 */
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
            
		    
		    .sub-table th, .sub-table td {
		        padding: 6px;  /* 모바일에서는 패딩만 조정 */
		    }
        }

        /* 서브 테이블 스타일 */
        .sub-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border: 1px solid #e0e0e0;
            table-layout: fixed;
        }

        .sub-table th, 
        .sub-table td {
            border: 1px solid #e0e0e0;
            padding: 12px 8px;
            text-align: center;
            font-size: 14px;
            overflow: hidden;
            text-overflow: ellipsis;
            word-break: break-word;
        }

        /* 서브 테이블 열 너비 조정 */
        .sub-table th:nth-child(1), /* 운동 이름 */
        .sub-table td:nth-child(1) {
            width: 20%;
        .sub-table th {
            background-color: #f5f5f5;
            font-weight: 600;
            color: #333;
        }

        .sub-table tr:hover {
            background-color: #fafafa;
        }

        /* 운동 리스트 테이블 스타일 수정 */
        .routine-row {
            background-color: #ffffff;
            transition: background-color 0.3s;
        }

        .routine-row:hover {
            background-color: #f8f8f8;
        }

        .routine-row td {
            padding: 15px 10px;
            border-right: 1px solid #e0e0e0;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: middle;
            height: 50px;
        }

        .routine-row td:last-child {
            border-right: none;
        }

        .btn-edit {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        
        .btn-edit:hover {
            background-color: #45a049;
        }

        /* 즐겨찾기 별표 스타일 */
        .favorite-star {
            cursor: pointer;
		    font-size: 1.2em;
		    color: #ccc;
		    transition: color 0.3s;
        }

        .favorite-star:not(.favorite) {
            color: #ccc; /* 비활성화된 별표 색상 */
        }

        .favorite-star.favorite {
            color: #ff6b6b; /* 활성화된 별표 색상 (빨간색) */
        }

        .favorite-star:hover {
            transform: scale(1.2);
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
        <h2 class="title">루틴 추천</h2>
        
        <!-- 운동 검색 영역 -->
        <div class="search-section">
            <div class="search-header">
                <h3>루틴 검색</h3>
                <div class="search-input-group">
                    <input type="text" class="search-input" placeholder="루틴 검색">
                    <button class="search-btn">검색</button>
                </div>
            </div>
            <div class="search-options">
                <div class="search-row">
                    <span>소모 칼로리(kcal)</span>
                    <input type="text" class="calorie-min" placeholder="최소값">~ 
                    <input type="text" class="calorie-max" placeholder="최대값">
                    <span>운동 카테고리</span>
                    <select class="category-select">
                        <option value="">전체</option>
                        <option value="1">근력</option>
                        <option value="2">유산소</option>
                        <option value="3">유연성</option>
                        <option value="4">균형</option>
                        <option value="5">복합</option>
                        <option value="6">저항</option>
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
                <span>운동 난이도 수준</span>
                <label><input type="checkbox" name="level" value="1"> 초급</label>
                <label><input type="checkbox" name="level" value="2"> 중급</label>
                <label><input type="checkbox" name="level" value="3"> 상급</label>
                <label><input type="checkbox" name="level" value="4"> 재활</label>
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
						<th>운동 카테고리</th>
						<th>운동 부위</th>
						<th>소모 총 열량(kcal)</th>
						<th>등록일</th>
						<th>작성자</th>
						<th>즐겨찾기</th>
						<th>조회수</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr class="routine-row" data-routine-no="${dto.routineNo}">
							<td><input type="checkbox" /></td>
							<td>
                                <a href="javascript:void(0);" 
					            onclick="openExercisePopup('${dto.routineNo}')">
					            ${dto.routineName}
					    		</a>
					    	</td>
							<td>${dto.routineCategoryName}</td>
							<td>${dto.exerciseCategories}</td>
							<td>${dto.exerciseParts}</td>
							<td>${dto.totalCalories}</td>
							<td>${dto.creationDate}</td>
							<td>${dto.memberNickname}</td>
							<td class="favorite-star" data-routine-no="${dto.routineNo}" 
							    onclick="toggleFavorite('${dto.routineNo}', this)">
							    <c:choose>
							        <c:when test="${dto.favoriteCheck == '1'}">★</c:when>
							        <c:otherwise>☆</c:otherwise>
							    </c:choose>
							</td>
							<td>${dto.views}</td>
							<td>
								<c:if test="${dto.memberId eq sessionScope.loginUser.memberId}">
									<button type="button" class="btn-edit" onclick="openRoutineEditPopup('${dto.routineNo}')"><i class="fa-solid fa-pen-to-square"></i></button>
								</c:if>
							</td>
						</tr>
						<tr class="exercise-detail" data-parent="${dto.routineNo}" style="display: none;">
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
					            <tbody id="exercise-tbody-${dto.routineNo}">
					                <!-- JS로 동적 렌더링 -->
					            </tbody>
					        </table>
					    </td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
            <div class="button-section">
                <button class="btn-large" onclick="openRoutineAddPopup()">+ 루틴 생성</button>
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
	    
	    function openExercisePopup(routineNo) {
	        window.open(
	            '${pageContext.request.contextPath}/getExerciseList.do?routineNo=' + routineNo,
	            'exercisePopup',
	            'width=900,height=600,resizable=yes,scrollbars=yes'
	        );
	    }
	    
		function openRoutineAddPopup() {
            
            // 팝업창 열기
            const popup = window.open(
                '${pageContext.request.contextPath}/exercise/routineAdd.do',
                'routineAddPopup',
                'width=1100, height=900, scrollbars=yes, resizable=yes'
            );
            popup.focus();
        }

        function openRoutineEditPopup(routineNo) {
            window.open(
                '${pageContext.request.contextPath}/exercise/editRoutine.do?routineNo=' + routineNo,
                'routineEditPopup',
                'width=1100, height=900, scrollbars=yes, resizable=yes'
            );
        }
        
        function toggleFavorite(routineNo, element) {
            fetch('${pageContext.request.contextPath}/exercise/toggleFavorite.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ routineNo: routineNo })
            })
            
            .then(res => res.json())
            .then(data => {
            	console.log('응답:', data);
                if (data.success) {
                    // 즐겨찾기 상태에 따라 별 색상/상태 변경
                    if (data.favorite) {
                        element.classList.add('favorite');
                    } else {
                        element.classList.remove('favorite');
                    }
                } else {
                    alert('즐겨찾기 처리 중 오류 발생: ' + data.message);
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('즐겨찾기 요청 실패');
            });
        }
        
	</script>

</body>
</html>