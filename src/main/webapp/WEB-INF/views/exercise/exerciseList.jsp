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
								<p class="username">홍길동님의</p>
								<p class="title">일일 루틴</p>
							</div>
							<div class="routine-date" id="currentMonth"></div>
						</div>

						<div class="routine-controls">
							<button>체지방 줄이기 루틴</button>
							<button>루틴 불러오기</button>
							<button>선택 삭제</button>
						</div>

						<div class="routine-table">
							<table>
								<thead>
									<tr>
										<th>선택</th>
										<th>운동명</th>
										<th>소모열량(kcal)</th>
										<th>시간(분)</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="checkbox" /></td>
										<td>천국의 계단</td>
										<td>300</td>
										<td>40</td>
										<td>
											<button>✎</button>
											<button>✕</button>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" /></td>
										<td>런지</td>
										<td>100</td>
										<td>15</td>
										<td>
											<button>✎</button>
											<button>✕</button>
										</td>
									</tr>
									<tr>
										<td></td>
										<td><input type="text" id="" value="팔굽혀펴기" /></td>
										<td><input type="text" value="100" /></td>
										<td><input type="text" value="20" /></td>
										<td>
											<button>등록하기</button>
										</td>
									</tr>
								</tbody>
							</table>

							<button class="add-exercise">+ 운동 추가하기</button>
						</div>

						<div class="routine-actions">
							<button>선택 운동 정보 조회</button>
							<button>선택 루틴 정보 조회</button>
							<button>루틴 생성</button>
							<button>루틴 삭제</button>
						</div>
					</div>
				</main>
				<form method="POST" action="">
					<div class="routine-detail-panel">
						<div class="routine-tabs">
							<button class="main-tab active" data-tab="info">루틴 정보</button>
						</div>

						<div class="sub-tabs">
							<button class="sub-tab active" data-tab="fatburn">체지방
								줄이기 루틴</button>
							<button class="sub-tab" data-tab="category">루틴 카테고리</button>
						</div>

						<div class="routine-content" id="fatburn">
							<div class="routine-grid">
								<div class="routine-card">
									<div class="exercise-title">천국의 계단</div>

									<label>소모열량(kcal)</label> <input type="text" value="300" /> <label>시간(분)</label>
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