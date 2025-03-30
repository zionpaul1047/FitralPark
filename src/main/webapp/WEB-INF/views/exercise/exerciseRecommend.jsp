<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   
   
   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <title>FITRALPARK</title>
   <script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
   <style>
		/* 간단한 스타일 */
		html {
			background-color: rgb(218, 243, 211);
		}
		
		body {
			border: 2px solid black;
			border-radius: 20px;
			background-color: #FFF;
			width: 1050px;
			padding: 20px;
		}
		
		.filter-section {
			margin: 15px 0;
			padding: 10px;
			display: flex;
			flex-wrap: wrap;
			gap: 15px;
			border-bottom: 1px solid #eee;
		}
		
		.filter-section label {
			font-size: 14px;
			cursor: pointer;
		}
		
		input[type="checkbox"] {
			margin-right: 5px;
			transform: scale(1.1);
		}
		
		.routine-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
	    }
	
	    .routine-table th, .routine-table td {
	        border: 1px solid #ccc;
	        padding: 8px;
	        text-align: center;
	        font-size: 14px;
	    }
	
	    .routine-create-box {
	        border: 1px solid #ddd;
	        padding: 15px;
	        margin-top: 30px;
	        width: 400px;
	    }
	
	    .routine-create-box h3 {
	        margin-bottom: 10px;
	    }
	
	    .routine-create-box input, select {
	        margin-top: 5px;
	        margin-bottom: 10px;
	        padding: 5px;
	        width: 100%;
	    }
	
	    .exercise-item {
	        margin-bottom: 10px;
	    }
	</style>
</head>
<body>
	<h2>루틴 검색</h2>

	<!-- 검색 및 필터 -->
	<form method="get" action="routineSearch.jsp">
		<div class="filter-section"
			style="display: flex; align-items: center; gap: 20px; margin-bottom: 20px;">
			<!-- 검색어 입력 -->
			<label> 루틴 검색 <input type="text" name="keyword"
				placeholder="검색어를 입력해주세요..." />
				<button type="submit">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</label>

			<!-- 칼로리 범위 -->
			<label> 소모 칼로리(kcal) <input type="number" name="minCal"
				placeholder="열량 최소값" style="width: 100px;" /> ~ <input
				type="number" name="maxCal" placeholder="열량 최대값"
				style="width: 100px;" />
			</label>

			<!-- 루틴 카테고리 -->
			<label> 루틴 카테고리 <select name="routineCategory">
					<option value="">루틴</option>
					<option value="beginner">초보자 운동 루틴</option>
					<option value="intermediate">중급자 운동 루틴</option>
					<option value="advanced">상급자 운동 루틴</option>
					<option value="rehab">재활 운동 루틴</option>
			</select>
			</label>
		</div>

		<!-- 카테고리 필터 -->
		<div class="filter-section">
			<label class="filter-group"><input type="checkbox"
				name="category" value="스트레칭"> 스트레칭</label> <label
				class="filter-group"><input type="checkbox" name="category"
				value="전신운동"> 전신 운동</label> <label class="filter-group"><input
				type="checkbox" name="category" value="상체운동"> 상체 운동</label> <label
				class="filter-group"><input type="checkbox" name="category"
				value="하체운동"> 하체 운동</label> <label class="filter-group"><input
				type="checkbox" name="category" value="코어운동"> 코어 운동</label>
		</div>

		<!-- 운동 부위 필터 -->
		<div class="filter-section">
			<label class="filter-group"><input type="checkbox"
				name="part" value="상체"> 상체</label> <label class="filter-group"><input
				type="checkbox" name="part" value="하체"> 하체</label> <label
				class="filter-group"><input type="checkbox" name="part"
				value="전신"> 전신</label> <label class="filter-group"><input
				type="checkbox" name="part" value="코어"> 코어</label>
		</div>
	</form>
	<table class="routine-table">
    <thead>
        <tr>
            <th><input type="checkbox" /></th>
            <th>루틴 이름</th>
            <th>루틴 카테고리</th>
            <th>운동 목록</th>
            <th>소모 열량 (kcal)</th>
            <th>등록일</th>
            <th>작성자</th>
            <th>즐겨찾기</th>
            <th>조회수</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><input type="checkbox" /></td>
            <td>하체 강화 루틴</td>
            <td>중급자 운동 루틴</td>
            <td>스쿼트, 런지</td>
            <td>500</td>
            <td>2025-03-28</td>
            <td>김트레이너</td>
            <td>⭐</td>
            <td>153</td>
        </tr>
        <!-- 반복 루프 처리 영역 -->
        <%-- 예시용, 실제로는 루틴 목록을 forEach 등으로 출력 --%>
        
    </tbody>
</table>



	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script>
      
      
      
      
   </script>
</body>
</html>