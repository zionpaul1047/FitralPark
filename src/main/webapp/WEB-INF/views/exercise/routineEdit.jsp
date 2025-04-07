<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK 루틴 수정</title>
<script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: rgb(218, 243, 211);
        }
        .popup-container {
        	background-color: #FFF;
            max-width: 1100px;
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
        
        a {
        	font-size: 14px;
        	font-style: Arial;
        	color: black;
        	text-decoration: none;
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
		<h2>루틴 수정</h2>
	        
	        <form action="${pageContext.request.contextPath}/exercise/updateRoutine.do" method="POST">
	            <input type="hidden" name="routineNo" value="${routine.routineNo}">
	            
	            <div class="form-group">
	                <label for="routine-name">루틴 명칭:</label>
	                <input type="text" id="routine-name" name="routineName" class="form-control" value="${routine.routineName}" required>
	            </div>
	            
	            <div class="form-group">
	                <label for="routine-category">루틴 카테고리:</label>
	                <select id="routine-category" name="routineCategory" class="form-control" required>
	                    <option value="">카테고리 선택</option>
	                    <option value="1" ${routine.routineCategoryNo == '1' ? 'selected' : ''}>초보자 운동 루틴</option>
	                    <option value="2" ${routine.routineCategoryNo == '2' ? 'selected' : ''}>중급자 운동 루틴</option>
	                    <option value="3" ${routine.routineCategoryNo == '3' ? 'selected' : ''}>상급자 운동 루틴</option>
	                    <option value="4" ${routine.routineCategoryNo == '4' ? 'selected' : ''}>재활 운동 루틴</option>
	                </select>
	            </div>
	            
	            <div class="form-group">
	                <label>루틴 공개 여부:</label>
	                <div class="radio-group">
	                    <label>
	                        <input type="radio" name="publicCheck" value="1" ${routine.publicCheck == '1' ? 'checked' : ''}>
	                        공개
	                    </label>
	                    <label>
	                        <input type="radio" name="publicCheck" value="0" ${routine.publicCheck == '0' ? 'checked' : ''}>
	                        비공개
	                    </label>
	                </div>
	            </div>
	            
	            <div class="routine-table-container">
	                <table class="routine-table" id="exerciseTable">
	                    <thead>
	                        <tr>
	                            <th>번호</th>
	                            <th>운동명</th>
	                            <th>운동 카테고리</th>
	                            <th>운동 부위</th>
	                            <th>소모 열량(kcal)</th>
	                            <th>세트</th>
	                            <th>횟수</th>
	                            <th>시간(분)</th>
	                            <th>중량(kg)</th>
	                            <th>삭제</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="exercise" items="${exercises}" varStatus="status">
	                            <tr>
	                                <td>${status.count}</td>
	                                <td>${exercise.exerciseName}</td>
	                                <td>${exercise.exerciseCategoryNames}</td>
	                                <td>${exercise.exercisePartNames}</td>
	                                <td>${exercise.caloriesPerUnit}</td>
	                                <td>
	                                    <input type="hidden" name="exerciseIds" value="${exercise.customExerciseNo != null ? 'cus_'.concat(exercise.customExerciseNo) : 'ex_'.concat(exercise.exerciseNo)}">
	                                    <input type="number" name="sets" min="0" value="${exercise.sets}" class="form-control">
	                                </td>
	                                <td><input type="number" name="reps" min="0" value="${exercise.repsPerSet}" class="form-control"></td>
	                                <td><input type="number" name="time" min="0" value="${exercise.exerciseTime}" class="form-control"></td>
	                                <td><input type="number" name="weight" min="0" step="0.1" value="${exercise.weight}" class="form-control"></td>
	                                <td>
	                                    <button type="button" class="btn delete-row">
	                                        <i class="fa-solid fa-xmark"></i>
	                                    </button>
	                                </td>
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	            </div>
	            
	            <div class="buttons-row">
	                <button type="button" class="btn" onclick="resetForm()">초기화</button>
	                <button type="button" class="btn btn-primary" onclick="openExercisePopup()">↪ 불러오기</button>
	            </div>
	            
	            <div class="action-buttons">
	                <button type="submit">루틴 수정하기</button>
	                <button type="button" onclick="window.close()">취소</button>
	            </div>
	        </form>
	    </div>
    
    <script>
        // 행 삭제
        document.querySelectorAll('.delete-row').forEach(button => {
            button.addEventListener('click', function() {
                const row = this.closest('tr');
                row.remove();
                reorderRows();
            });
        });

        // 행 번호 재정렬
        function reorderRows() {
            const rows = document.querySelectorAll('#exerciseTable tbody tr');
            rows.forEach((row, index) => {
                row.cells[0].textContent = index + 1;
            });
        }

        // 운동 추가 팝업
        function openExercisePopup() {
            const popup = window.open(
                '${pageContext.request.contextPath}/exercise/routineAddExerciseList.do',
                'exercisePopup',
                'width=1100, height=900, scrollbars=yes, resizable=yes'
            );
            popup.focus();
        }

        // 팝업에서 선택된 운동 추가
        function setResList(exercises) {
            const tbody = document.querySelector('#exerciseTable tbody');
            
            exercises.forEach(exercise => {
                const row = document.createElement('tr');
                const exerciseId = exercise.exerciseNo;
                
                row.innerHTML = `
                    <td>${tbody.children.length + 1}</td>
                    <td>${exercise.exerciseName}</td>
                    <td>${exercise.exerciseCategoryName}</td>
                    <td>${exercise.exercisePartName}</td>
                    <td>${exercise.caloriesPerUnit}</td>
                    <td>
                        <input type="hidden" name="exerciseIds" value="ex_${exerciseId}">
                        <input type="number" name="sets" min="0" value="0" class="form-control">
                    </td>
                    <td><input type="number" name="reps" min="0" value="0" class="form-control"></td>
                    <td><input type="number" name="time" min="0" value="0" class="form-control"></td>
                    <td><input type="number" name="weight" min="0" step="0.1" value="0" class="form-control"></td>
                    <td>
                        <button type="button" class="btn delete-row">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </td>
                `;
                
                tbody.appendChild(row);
                
                // 새로 추가된 삭제 버튼에 이벤트 리스너 추가
                row.querySelector('.delete-row').addEventListener('click', function() {
                    row.remove();
                    reorderRows();
                });
            });
        }

        // 폼 초기화
        function resetForm() {
            if (!confirm('입력한 내용을 초기화하시겠습니까?')) {
                return;
            }
            location.reload();
        }
    </script>
</body>
</html>