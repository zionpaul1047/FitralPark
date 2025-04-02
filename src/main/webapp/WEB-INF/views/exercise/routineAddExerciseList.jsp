<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>운동 목록 불러오기</title>
	<style>
	
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
        
        .btn btn-primary {
		    background-color: #f8f8f8;
		    font-weight: 500;
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
                    <th>✔</th>
                    <th>운동명</th>
                    <th>운동 카테고리</th>
                    <th>운동 부위</th>
                    <th>소모 열량(kcal)</th>
                    <th>즐겨찾기</th>
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

        <button type="button" id="exerciseAddBtn" onclick="sendToParent()">선택 운동 추가하기</button>
        
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
    </script>
</body>
</html>