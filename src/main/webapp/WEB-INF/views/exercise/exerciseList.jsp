<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>FITRALPACK</title>
	<link rel="stylesheet" href="assets/css/exercise.css">
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
        	width: 1000px;
        }
        .grid_bottom{
        /* border: 1px solid black; */
            grid-row: 3;
        }
        .routine-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
        }
        .routine-header .title {
            font-size: 20px;
            font-weight: bold;
            margin: 0;
        }
        .routine-header .date {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
            color: #333;
        }
        .routine-header > div:first-child {
            flex: 1;
        }
        .routine-header > div:last-child {
            text-align: right;
        }
        .calorie-inputs {
        	display: flex;
        	justify-content: flex-end;
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

				<main>
					<div class="calendar-container">
						<div class="calendar-header">
							<h2 id="currentMonth"></h2>
							<button id="prevBtn">&lt;</button>
							<button id="nextBtn">&gt;</button>
							<button id="todayBtn">오늘</button>
						</div>
						<div class="calendar-days">
							<div class="day">일</div>
							<div class="day">월</div>
							<div class="day">화</div>
							<div class="day">수</div>
							<div class="day">목</div>
							<div class="day">금</div>
							<div class="day">토</div>
						</div>
						<div class="calendar-dates" id="calendarDates"></div>
					</div>
					<div class="routine-panel">
						<div class="routine-header">
							<div>
								<div>김진혁님</div>
								<div>일일 식단</div>
							</div>
							<div>
								<p class="date">2025.03.10</p>
							</div>
						</div>

						<div class="routine-controls">
							<div class="meal-buttons">
								<button class="meal-btn active">아침</button>
								<button class="meal-btn">점심</button>
								<button class="meal-btn">저녁</button>
								<button class="meal-btn">간식</button>
							</div>
							<div class="action-buttons">
								<button>식단 불러오기</button>
								<button>식단 삭제하기</button>
								<button>선택 삭제</button>
							</div>
						</div>

						<div class="routine-table">
							<table>
								<thead>
									<tr>
										<th>선택</th>
										<th>음식명</th>
										<th>열량(kcal)</th>
										<th>개수</th>
										<th>수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox"></td>
										<td>닭가슴살</td>
										<td>164.4</td>
										<td>1</td>
										<td>
											<button class="edit-btn">✎</button>
											<button class="delete-btn">−</button>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox"></td>
										<td>치커리샐러드</td>
										<td>24</td>
										<td>1</td>
										<td>
											<button class="edit-btn">✎</button>
											<button class="delete-btn">−</button>
										</td>
									</tr>
								</tbody>
							</table>
							
							<div class="calorie-inputs">
								<button class="check-btn" style="margin-left: 5px; border: 1px solid black; padding: 1px; border-radius: 5px;">✓ 등록하기</button>
								<button class="reset-btn" style="margin-left: 5px; border: 1px solid black; padding: 1px; border-radius: 5px;">✓ 초기화</button>
							</div>

						<div class="routine-actions">
							<button>선택 음식 정보 조회</button>
							<button>선택 식단 정보 조회</button>
							<button>식단 생성</button>
							<button>식단 삭제</button>
						</div>
					</div>
				</main>
				<form method="POST" action="">
					<div class="routine-detail-panel">
						<div class="routine-tabs">
							<button class="main-tab active" data-tab="info">식단 정보</button>
						</div>

						<div class="sub-tabs">
							<button class="sub-tab active" data-tab="fatburn">아침</button>
							<button class="sub-tab" data-tab="category">식단 카테고리</button>
						</div>

						<div class="routine-content" id="fatburn">
							<div class="routine-grid">
								<div class="routine-card">
									<div class="exercise-title">닭가슴살</div>
									
									<label>열량(kcal)</label> <input type="text" value="123" /> <label>단백질(g)</label>
									<input type="text" value="40" /> <label>지방(g)</label> <input
										type="text" value="80" /> <label>탄수화물(g)</label> <input
										type="text" value="16" /> <label>당류(g)</label> <input
										type="text" value="0" />

									
								</div>
								<div>
									<label>열량(kcal)</label> <input type="text" value="300" /> <label>시간(분)</label>
									<input type="text" value="40" /> <label>세트(회)</label> <input
										type="text" value="3" /> <label>세트 당 횟수(회)</label> <input
										type="text" value="15" /> <label>중량(kg)</label> <input
										type="text" value="0" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>
    <script src="assets/js/calendar.js">
					
				</script>
</body>
</html>