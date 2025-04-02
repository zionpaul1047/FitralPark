<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>운동 목록 불러오기</title>
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
			margin-top: 10px;
		}
        
    </style>
	</head>
<body>
	
	<div class="popup-container">

    <h3>운동 검색</h3>
    <input type="text" id="searchKeyword" placeholder="검색어 입력">
    <select id="categoryFilter">
        <option value="">운동 카테고리</option>
        <option value="1">근력</option>
        <option value="2">유산소</option>
        <option value="3">유연성</option>
        <option value="4">균형</option>
        <option value="5">복구</option>
        <option value="6">저항</option>
    </select>
    <button onclick="searchExercise()">🔍</button>

    <h3>운동 목록</h3>
    <form id="exerciseForm">
        <table>
            <thead>
                <tr>
                    <th style="width: 5%">✔</th>
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
                        <td><input type="checkbox" name="selectExercise" value="${ex.exerciseNo}"></td>
                        <td>${ex.exerciseName}</td>
                        <td>${ex.exerciseCategoryName}</td>
                        <td>${ex.exercisePartName}</td>
                        <td>${ex.caloriesPerUnit}</td>
                        <td>☆</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <hr>
        <h3>사용자 정의 운동 목록</h3>
		<table id="exercise-table">
		    <thead>
		        <tr>
		            <th style="width: 5%">✔</th>
		            <th style="width: 20%">운동명</th>
		            <th style="width: 15%">운동 카테고리</th>
		            <th style="width: 15%">운동 부위</th>
		            <th style="width: 15%">소모 열량(kcal)</th>
		            <th style="width: 5%"></th>
		            <th style="width: 5%"></th>
		            <th style="width: 5%"></th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach items="${customExerciseList}" var="ex">
		            <tr>
		                <td><input type="checkbox" name="customSelectExercise" value="${ex.customExerciseNo}"></td>
		                <td>${ex.exerciseName}</td>
		                <td>${ex.exerciseCategoryName}</td>
		                <td>${ex.exercisePartName}</td>
		                <td>${ex.caloriesPerUnit}</td>
		                <td>
		                    <button type="button" onclick="editCustomExercise('${ex.customExerciseNo}')">✏️</button>
		                    <button type="button" onclick="deleteCustomExercise('${ex.customExerciseNo}')">❌</button>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>

        <button class="btn-add" onclick="addExerciseItem()">
	            <span>➕</span> 운동 추가하기
	        </button>
        
		<div class="action-buttons">
            <button type="button" class="btn btn-primary" onclick="sendToParent()">불러오기</button>
            <button type="button" class="btn" onclick="window.close()">취소</button>
        </div>

    </form>
	</div>

    <script>
    
	    function sendToParent() {
	        const checked = document.querySelectorAll('input[name="selectExercise"]:checked');
	        const selected = Array.from(checked).map(chk => chk.value);
	
	        if (window.opener && typeof window.opener.receiveExerciseList === 'function') {
	            window.opener.receiveExerciseList(selected);
	            window.close();
	        }
	        
	        
	    }
	    
	    function addExerciseItem() {
            const table = document.getElementById('exercise-table').getElementsByTagName('tbody')[0];
            const newRow = table.insertRow();
            newRow.innerHTML = `
                <td><input type="checkbox"></td>
                <td><input type="text" name="exerciseName" placeholder="운동명 입력"></td>
                <td>
	                <select class="exercise-category">
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
	                <select class="exercise-part">
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
                <td><input type="text" name="caloriesPerUnit" placeholder="소모 열량"></td>
                <td></td>
                <td></td>
                <td></td>
            `;
        }

    
    </script>
</body>
</html>