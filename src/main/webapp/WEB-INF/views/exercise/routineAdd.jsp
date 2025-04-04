<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK 루틴 생성</title>
<script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
        }
        .popup-container {
            max-width: 1000px;
            margin: 0 auto;
            border: 1px solid #FFD700;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            font-size: 20px;
            margin-bottom: 20px;
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .form-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .form-group label {
            width: 120px;
            text-align: right;
            margin-right: 10px;
            font-weight: 500;
        }
        .form-control {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .radio-group {
            display: flex;
            align-items: center;
        }
        .radio-group label {
            margin-right: 20px;
            display: flex;
            align-items: center;
            width: auto;
        }
        .radio-group input[type="radio"] {
            margin-right: 5px;
        }
        
        /* 루틴 테이블 스타일 */
        .routine-table-container {
            margin: 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        .routine-table {
        	font-size: 14px;
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
        }
        .routine-table th, 
        .routine-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .routine-table th {
            background-color: #f5f5f5;
            font-weight: 500;
        }
        .routine-table tr:nth-child(even) {
            background-color: #fafafa;
        }
        .routine-table tr:hover {
            background-color: #f0f0f0;
        }
        .routine-table input[type="text"] {
            width: 80%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        
        /* 아이콘 버튼 스타일 */
        .icon-button {
            width: 24px;
            height: 24px;
            border: none;
            background-color: transparent;
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
            cursor: pointer;
        }
        .search-button {
            background-image: url('search.png');
        }
        .delete-button {
             background-image: url('clear.png');
        }
        
        /* 버튼 스타일 */
        .buttons-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            align-items: center;
        }
        .btn {
            padding: 8px 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            cursor: pointer;
            margin-right: 5px;
            transition: all 0.2s;
        }
        .btn:hover {
            background-color: #f0f0f0;
        }
        .btn-primary {
            background-color: #f8f8f8;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #e8e8e8;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .action-buttons button {
            width: 48%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            cursor: pointer;
            transition: all 0.2s;
        }
        .action-buttons button:hover {
            background-color: #f0f0f0;
        }
    
        .routine-table input[type="text"],
		.routine-table select {
		    width: 100%;
		    box-sizing: border-box;
		    padding: 6px;
		    font-size: 14px;
		}
		
		.routine-table td {
		    vertical-align: middle;
		}
		
		.routine-table th, .routine-table td {
		    text-align: center;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		
		.routine-table th:nth-child(1) { width: 4%; }   /* 체크박스 */
		.routine-table th:nth-child(2) { width: 16%; }  /* 운동명 */
		.routine-table th:nth-child(3) { width: 14%; }  /* 운동 카테고리 */
		.routine-table th:nth-child(4) { width: 14%; }  /* 운동 부위 */
		.routine-table th:nth-child(5) { width: 12%; }  /* 소모 열량 */
		.routine-table th:nth-child(6) { width: 10%; }  /* 세트 */
		.routine-table th:nth-child(7) { width: 10%; }  /* 횟수 */
		.routine-table th:nth-child(8) { width: 10%; }  /* 시간 */
		.routine-table th:nth-child(9) { width: 10%; }  /* 중량 */
		.routine-table th:nth-child(10) { width: 4%; }  /* 삭제 버튼 */
		
        .routine-table input[type="number"] {
            width: 60px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            text-align: center;
        }
        
        /* 중량 입력 필드는 조금 더 넓게 */
        .routine-table input[name="weight"] {
            width: 70px;
        }
    </style>
</head>
<body>
	<div class="popup-container">
		<h2>루틴 생성</h2>
	        
	        <div class="form-group">
	            <label for="routine-name">루틴 명칭:</label>
	            <input type="text" id="routine-name" class="form-control" placeholder="루틴 이름 입력">
	        </div>
	        
	        <div class="form-group">
	            <label for="routine-category">루틴 카테고리:</label>
	            <select id="routine-category" class="form-control">
	                <option value="">카테고리 선택</option>
	                <option value="초보자 운동 루틴">초보자 운동 루틴</option>
	                <option value="중급자 운동 루틴">중급자 운동 루틴</option>
	                <option value="상급자 운동 루틴">상급자 운동 루틴</option>
	                <option value="재활 운동 루틴">재활 운동 루틴</option>
	            
	            </select>
	        </div>
	        
	        
	        <div class="form-group">
	            <label>루틴 공개 여부:</label>
	            <div class="radio-group">
	                <label><input type="radio" name="visibility" value="public" checked> 공개</label>
	                <label><input type="radio" name="visibility" value="private"> 비공개</label>
	            </div>
	        </div>
	        
	        <!-- 루틴 테이블 -->
	        <div class="routine-table-container">
	            <table class="routine-table" id="routine-table">
	                <thead>
	                    <tr>
	                        <th>선택</th>
					        <th>운동명</th>
					        <th>운동 카테고리</th>
					        <th>운동 부위</th>
					        <th>소모 열량(kcal)</th>
					        <th>세트</th>
					        <th>횟수</th>
					        <th>시간(분)</th>
					        <th>중량(kg)</th>
					        <th></th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach items="${selectedExercises}" var="exercise">
	                        <tr data-exercise-no="${exercise.exerciseNo != null ? exercise.exerciseNo : 'C'.concat(exercise.customExerciseNo)}">
	                            <td><input type="checkbox" name="exercise-select"></td>
	                            <td>${exercise.exerciseName != null ? exercise.exerciseName : exercise.customExerciseName}</td>
	                            <td>${exercise.exerciseCategoryName != null ? exercise.exerciseCategoryName : exercise.customExerciseCategoryName}</td>
	                            <td>${exercise.exercisePartName != null ? exercise.exercisePartName : exercise.customExercisePartName}</td>
	                            <td>${exercise.caloriesPerUnit != null ? exercise.caloriesPerUnit : exercise.customCaloriesPerUnit}</td>
	                            <td><input type="number" class="form-control" name="sets" min="0" value="0"></td>
	                            <td><input type="number" class="form-control" name="reps" min="0" value="0"></td>
	                            <td><input type="number" class="form-control" name="time" min="0" value="0"></td>
	                            <td><input type="number" class="form-control" name="weight" min="0" step="0.1" value="0"></td>
	                            <td>
	                                <button type="button" class="btn" onclick="removeRow(this)">
	                                    <i class="fa-solid fa-xmark"></i>
	                                </button>
	                            </td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	        </div>
        
	        <div class="buttons-row">
	        	<div>
		            <button class="btn" onclick="resetForm()">초기화</button>
		            <button class="btn" onclick="deleteSelectedItems()">
		            선택 항목 삭제</button>
		        </div>
	            <div>
	                <button class="btn btn-primary" onclick="openExercisePopup()">↪ 불러오기</button>
	            </div>
	        </div>
	        
	        
	        
	        <div class="action-buttons">
	            <button>+ 루틴 등록하기</button>
	            <button>+ 루틴 추가 후 즐겨찾기 등록</button>
	        </div>
	    </div>
    
    <script>
        // 팝업창에서 전달받은 운동 데이터를 처리하는 함수
        function addExercises(exercises) {
            console.log('Adding exercises:', exercises);
            
            const tbody = document.querySelector('#routine-table tbody');
            
            exercises.forEach(exercise => {
                // 이미 존재하는 운동인지 확인
                const existingRow = tbody.querySelector(`tr[data-exercise-no="${exercise.exerciseNo}"]`);
                if (existingRow) {
                    console.log('이미 추가된 운동입니다:', exercise.exerciseName);
                    return;
                }
                
                // 새로운 행 생성
                const tr = document.createElement('tr');
                tr.setAttribute('data-exercise-no', exercise.exerciseNo);
                
                // 행 내용 설정
                tr.innerHTML = `
                    <td><input type="checkbox" name="exercise-select"></td>
                    <td>${exercise.exerciseName}</td>
                    <td>${exercise.exerciseCategoryName}</td>
                    <td>${exercise.exercisePartName}</td>
                    <td>${exercise.caloriesPerUnit}</td>
                    <td><input type="number" class="form-control" name="sets" min="0" value="0"></td>
                    <td><input type="number" class="form-control" name="reps" min="0" value="0"></td>
                    <td><input type="number" class="form-control" name="time" min="0" value="0"></td>
                    <td><input type="number" class="form-control" name="weight" min="0" step="0.1" value="0"></td>
                    <td>
                        <button type="button" class="btn" onclick="removeRow(this)">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </td>
                `;
                
                // 테이블에 행 추가
                tbody.appendChild(tr);
                console.log('Added new row:', exercise.exerciseName);
            });
        }

        // 행 삭제 함수도 순수 JavaScript로 수정
        function removeRow(button) {
            const row = button.closest('tr');
            if (row) {
                row.remove();
            }
        }

        // 선택된 항목 삭제
        function deleteSelectedItems() {
            $('#routine-table tbody tr').each(function() {
                if ($(this).find('input[name="exercise-select"]').prop('checked')) {
                    $(this).remove();
                }
            });
        }

        // 폼 초기화
        function resetForm() {
            $('#routine-name').val('');
            $('#routine-category').prop('selectedIndex', 0);
            $('input[name="visibility"][value="public"]').prop('checked', true);
            $('#routine-table tbody').empty();
        }

        function openExercisePopup() {
            // 팝업창 열기 전에 현재 창의 이름을 설정
            window.name = 'routineAddForm';
            
            // 팝업창 열기
            const popup = window.open(
                '${pageContext.request.contextPath}/exercise/routineAddExerciseList.do',
                'exercisePopup',
                'width=1000,height=1000,scrollbars=yes'
            );

            // 팝업창이 차단되었는지 확인
            if (!popup || popup.closed || typeof popup.closed == 'undefined') {
                alert('팝업이 차단되었습니다. 팝업 차단을 해제해주세요.');
            }
        }
    </script>
</body>
</html>