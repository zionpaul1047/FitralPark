<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK 루틴 생성</title>
<style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
        }
        .popup-container {
            max-width: 800px;
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
        
        /* 루틴틴 테이블 스타일 */
        .routine-table-container {
            margin: 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        .routine-table {
        	font-size: 14px;
            width: 100%;
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
		
		.routine-table th:nth-child(2) { width: 150px; } /* 운동명 */
		.routine-table th:nth-child(3) { width: 150px; } /* 운동 카테고리 */
		.routine-table th:nth-child(4) { width: 150px; } /* 운동 부위 */
		.routine-table th:nth-child(5) { width: 100px; } /* 소모 열량 */
		
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
					        <th></th>
					        <th></th>
					        <th></th>
	                    </tr>
	                </thead>
	                <tbody>
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

        function deleteSelectedItems() {
            const table = document.getElementById('routine-table').getElementsByTagName('tbody')[0];
            const rows = table.getElementsByTagName('tr');
            for (let i = rows.length - 1; i >= 0; i--) {
                const checkbox = rows[i].getElementsByTagName('input')[0];
                if (checkbox.checked) {
                    table.deleteRow(i);
                }
            }
        }

        function removeRow(button) {
            const row = button.closest('tr');
            row.parentNode.removeChild(row);
        }

        function resetForm() {
            document.getElementById('routine-name').value = '';
            document.getElementById('routine-category').selectedIndex = 0;
            document.getElementById('time-slot').selectedIndex = 0;
            document.querySelector('input[name="visibility"][value="public"]').checked = true;
            
            const tbody = document.getElementById('routine-table').getElementsByTagName('tbody')[0];
            tbody.innerHTML = '';
        }
        
        function openExercisePopup() {
            window.open(
                '${pageContext.request.contextPath}/exercise/routineAddExerciseList.do',
                'exercisePopup',
                'width=1000,height=1000,scrollbars=yes'
            );
        }
        
        
        
        
    
    </script>
</body>
</html>