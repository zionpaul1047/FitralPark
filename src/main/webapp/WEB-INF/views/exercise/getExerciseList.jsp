<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>{routineInfo.routineName} - 운동 목록</title>
	<style>
	
	 	body {
            font-family: 'Noto Sans KR', sans-serif;
            padding: 20px;
        }

        .routine-info {
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }

        .routine-info h2 {
            margin: 0;
        }

        .routine-meta {
            margin-top: 10px;
            font-size: 14px;
            color: #555;
        }

        table {
        	font-size: 14px; 
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }
	</style>
</head>
<body>
	
	<div class="routine-info">
        <h2>${routineInfo.routineName}</h2>
        <div class="routine-meta">
            카테고리: <strong>${routineInfo.routineCategoryName}</strong> |
            작성자: <strong>${routineInfo.memberNickname}</strong> |
            등록일: <strong>${routineInfo.creationDate}</strong>
        </div>
    </div>

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
    <tbody>
        <c:forEach var="exercise" items="${exercises}">
            <tr>
                <td>${exercise.exerciseName}</td>
                <td>${exercise.exerciseCategoryNames}</td>
                <td>${exercise.exercisePartNames}</td>
                <td>${exercise.caloriesPerUnit}</td>
                <td>${exercise.exerciseTime}</td>
                <td>${exercise.sets}</td>
                <td>${exercise.repsPerSet}</td>
                <td>${exercise.weight}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>