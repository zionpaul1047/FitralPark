<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>운동 목록 불러오기</title>
	<script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
	<style>
	
		hr {
			border: 0;
			height: 1px;
			background: black;
		}
	
        .popup-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #FFD700;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }

        #searchKeyword, #categoryFilter, button {
            padding: 8px;
            margin-right: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            font-size: 14px;
        }

        table th, table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f5f5f5;
            font-weight: 500;
        }

        table tr:nth-child(even) {
            background-color: #fafafa;
        }

        button[type="button"] {
        	
        }

        button[type="button"]:hover {
            background-color: #f0f0f0;
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
        
        .btn btn-primary {
		    background-color: #f8f8f8;
		    font-weight: 500;
		}

        .btn btn-primary:hover {
            background-color: #f0f0f0;
		}
		
		.btn-add {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-add:hover {
            background-color: #f0f0f0;
        }
        .btn-add span {
            margin-right: 5px;
            font-size: 18px;
        }
		
		#exerciseAddBtn {
			margin-top: 15px;
            width: 100%;
            background-color: #fff;
            font-weight: 500;
            transition: all 0.2s;
		}
		
		.action-buttons {
			display: flex;
			justify-content: flex-end;
			margin: 10px auto;
		}

        .rudBtn {
            width: 32px;
            height: 34px;
            border: 0;
            background: none;
            padding: 0;
        }
        
        .rudBtn:hover {

        }
        
        .buttons-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            align-items: center;
        }
        
    </style>
	</head>
<body>
	
	<div class="popup-container">

    <h3>운동 검색</h3>
    <form method="get" action="/fitralpark/exercise/routineAddExerciseList.do">
    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
    <select name="category">
        <option value="">운동 카테고리</option>
        <option value="1" ${param.category == '1' ? 'selected' : ''}>근력</option>
        <option value="2" ${param.category == '2' ? 'selected' : ''}>유산소</option>
        <option value="3" ${param.category == '3' ? 'selected' : ''}>유연성</option>
        <option value="4" ${param.category == '4' ? 'selected' : ''}>균형</option>
        <option value="5" ${param.category == '5' ? 'selected' : ''}>복구</option>
        <option value="6" ${param.category == '6' ? 'selected' : ''}>저항</option>
    </select>
    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i> 검색</button>
</form>
    <h3>운동 목록</h3>
    <form id="exerciseForm">
        <table>
            <thead>
                <tr>
                    <th style="width: 5%">✅</th>
                    <th style="width: 20%">운동명</th>
                    <th style="width: 15%">운동 카테고리</th>
                    <th style="width: 15%">운동 부위</th>
                    <th style="width: 15%">소모 열량(kcal)</th>
                    <th style="width: 15%">즐겨찾기</th>
                </tr>
            </thead>
            <tbody id="exerciseTableBody">
                <c:forEach items="${exerciseList}" var="ex">
                    <tr>
                        <td><input type="checkbox" id="selectExercise" value="${ex.exerciseNo}"></td>
                        <td>${ex.exerciseName}</td>
                        <td>${ex.exerciseCategoryName}</td>
                        <td>${ex.exercisePartName}</td>
                        <td>${ex.caloriesPerUnit}</td>
                        <td>⭐</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <hr>
        <h3>사용자 정의 운동 목록</h3>
		<table id="exercise-table">
		    <thead>
		        <tr>
		            <th style="width: 5%">✅</th>
		            <th style="width: 20%">운동명</th>
		            <th style="width: 15%">운동 카테고리</th>
		            <th style="width: 15%">운동 부위</th>
		            <th style="width: 15%">소모 열량(kcal)</th>
		            <th style="width: 15%"></th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach items="${customExerciseList}" var="customex">
		            <tr>
		                <td style="width: 5%"><input type="checkbox" name="customSelectExercise" value="${customex.customExerciseNo}"></td>
		                <td style="width: 20%">${customex.customExerciseName}</td>
		                <td style="width: 15%">${customex.customExerciseCategoryName}</td>
		                <td style="width: 15%">${customex.customExercisePartName}</td>
		                <td style="width: 15%">${customex.customCaloriesPerUnit}</td>
		                <td style="width: 5%">
		                	<button type="button" class="rudBtn" onclick="editCustomExercise('${customex.customExerciseNo}')"><i class="fa-solid fa-magnifying-glass"></i></button>
		                	<button type="button" class="rudBtn" onclick="editCustomExercise('${customex.customExerciseNo}')"><i class="fa-solid fa-pen-to-square"></i></button>
		                	<button type="button" class="rudBtn" onclick="deleteCustomExercise('${customex.customExerciseNo}')"><i class="fa-solid fa-x"></i></button>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>

        <div class="buttons-row">
	        	<div>
		            <button class="btn" onclick="resetForm()">초기화</button>
		            <button class="btn" onclick="deleteSelectedItems()">
		            선택 항목 삭제</button>
		        </div>
	            <div>
	                <button class="btn btn-primary" onclick="">등록하기</button>
	            </div>
	        </div>

        <button type="button" class="btn-add" onclick="addExerciseItem()">
    		<span><i class="fa-solid fa-plus"></i></span> 운동 추가하기
		</button>
        
		<div class="action-buttons">
            <button type="button" class="btn btn-primary" onclick="sendToParent()">불러오기</button>
            <button type="button" class="btn" onclick="window.close()">취소</button>
        </div>

    </form>
	</div>

    <script>
    
    
	    function sendToParent() {
	        const checked = document.querySelectorAll('input[name="selectExercise"]:checked, input[name="customSelectExercise"]:checked');
	        const selected = Array.from(checked).map(chk => chk.value);
	        
	        if (selected.length === 0) {
	            alert("운동을 하나 이상 선택해주세요.");
	            return;
	        }
	
	        if (window.opener && typeof window.opener.receiveExerciseList === 'function') {
	            window.opener.receiveExerciseList(selected); // 부모창 함수로 값 전달
	            window.close(); // 팝업 닫기
	        }
	        
	        
	    }
	    
	    function addExerciseItem() {
	        const tbody = document.querySelector('#exercise-table tbody');
	        const newRow = document.createElement('tr');

	        newRow.innerHTML = `
	        	<td><input type="checkbox" name="customSelectExercise"></td>
	            <td><input type="text" name="exerciseName" placeholder="운동명 입력" style="width: 100%"></td>
	            <td>
	                <select name="exerciseCategory" class="exercise-category" style="width: 100%">
	                    <option value="">카테고리 선택</option>
	                    <option value="1">근력</option>
	                    <option value="2">유산소</option>
	                    <option value="3">유연성</option>
	                    <option value="4">균형</option>
	                    <option value="5">복구</option>
	                    <option value="6">저항</option>
	                </select>
	            </td>
	            <td>
	                <select name="exercisePart" class="exercise-part" style="width: 100%">
	                    <option value="">부위 선택</option>
	                    <option value="1">하체</option>
	                    <option value="2">가슴</option>
	                    <option value="3">등</option>
	                    <option value="4">어깨</option>
	                    <option value="5">팔</option>
	                    <option value="6">복부</option>
	                    <option value="7">근육</option>
	                    <option value="8">기타</option>
	                    <option value="9">유산소</option>
	                </select>
	            </td>
	            <td><input type="text" name="caloriesPerUnit" placeholder="소모 열량" style="width: 100%"></td>
	            <td>
	                <button type="button" class="rudBtn" onclick="this.closest('tr').remove()">
	                    <i class="fa-solid fa-xmark"></i>
	                </button>
	            </td>
	        `;
	        
	        tbody.appendChild(newRow);
	    }
	    
		// 이후 수정, 삭제 함수들도 여기에 추가 가능
	    function editCustomExercise(id) {
	        alert('수정 기능 준비 중입니다. (ID: ' + id + ')');
	    }
	    
	    function deleteCustomExercise(id) {
	        if (confirm('정말 삭제하시겠습니까?')) {
	            // 실제 삭제 요청 필요 시 AJAX 또는 form submit 구현
	            alert('삭제 요청: ID = ' + id);
	        }
	    }

        

    
    </script>
</body>
</html>