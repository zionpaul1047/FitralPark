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
	        
	        <div class="form-group">
	            <label for="routine-name">루틴 명칭:</label>
	            <input type="text" id="routine-name" class="form-control" placeholder="루틴 이름 입력" value="${routine.routineName}">
	        </div>
	        
	        <div class="form-group">
	            <label for="routine-category">루틴 카테고리:</label>
	            <select id="routine-category" class="form-control">
	                <option value="">카테고리 선택</option>
	                <option value="1" ${routine.routineCategoryNo == 1 ? 'selected' : ''}>초보자 운동 루틴</option>
	                <option value="2" ${routine.routineCategoryNo == 2 ? 'selected' : ''}>중급자 운동 루틴</option>
	                <option value="3" ${routine.routineCategoryNo == 3 ? 'selected' : ''}>상급자 운동 루틴</option>
	                <option value="4" ${routine.routineCategoryNo == 4 ? 'selected' : ''}>재활 운동 루틴</option>
	            </select>
	        </div>
	        
	        
	        <div class="form-group">
	            <label>루틴 공개 여부:</label>
	            <div class="radio-group">
	                <label><input type="radio" name="visibility" value="public" ${routine.publicCheck == 1 ? 'checked' : ''}> 공개</label>
	                <label><input type="radio" name="visibility" value="private" ${routine.publicCheck == 0 ? 'checked' : ''}> 비공개</label>
	            </div>
	        </div>
	        
	        <!-- 루틴 테이블 -->
	        <div class="routine-table-container">
	            <table class="routine-table" id="resTb">
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
					        <th>취소</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="exercise" items="${exercises}" varStatus="status">
	                        <tr id="tr_${exercise.customExerciseNo != null ? 'cus_'.concat(exercise.customExerciseNo) : 'ex_'.concat(exercise.exerciseNo)}">
	                            <td name="no">${status.count}</td>
	                            <td name="exerciseName">${exercise.exerciseName}</td>
	                            <td name="exerciseCategoryName">${exercise.exerciseCategoryNames}</td>
	                            <td name="exercisePartName">${exercise.exercisePartNames}</td>
	                            <td name="caloriesPerUnit">${exercise.caloriesPerUnit}</td>
	                            <td name="sets"><input type="number" class="form-control" name="sets" min="0" value="${exercise.sets}"></td>
	                            <td name="reps"><input type="number" class="form-control" name="reps" min="0" value="${exercise.repsPerSet}"></td>
	                            <td name="time"><input type="number" class="form-control" name="time" min="0" value="${exercise.exerciseTime}"></td>
	                            <td name="weight"><input type="number" class="form-control" name="weight" min="0" value="${exercise.weight}"></td>
	                            <td name="cancle">
	                                <a href="javascript:void(0);" onclick="removeRow(this);return false;" class="btn">
	                                    <i class="fa-solid fa-xmark"></i>
	                                </a>
	                            </td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	        </div>
	        
            <%-- 버튼 --%>
	        <div class="buttons-row">
	        	<div>
		            <button class="btn" onclick="resetForm()">초기화</button>
		        </div>
	            <div>
	                <button class="btn btn-primary" onclick="openExercisePopup()">↪ 불러오기</button>
	            </div>
	        </div>
	        
	        <div class="table-responsive">
	        	<table class="routine-table" style="display:none;">
                    <tbody id="resTr">
                        <tr>
                            <td name="no"></td>
                            <td name="exerciseName"></td>
                            <td name="exerciseCategoryName"></td>
                            <td name="exercisePartName"></td>
                            <td name="caloriesPerUnit"></td>
                            <td name="sets"><input type="number" class="form-control" name="sets" min="0" value="0"></td>
                            <td name="reps"><input type="number" class="form-control" name="reps" min="0" value="0"></td>
                            <td name="time"><input type="number" class="form-control" name="time" min="0" value="0"></td>
                            <td name="weight"><input type="number" class="form-control" name="weight" min="0" value="0"></td>
                            <td name="cancle">
                                <a href="javascript:void(0);" onclick="removeRow(this);return false;" class="btn">
                                    <i class="fa-solid fa-xmark"></i>
                                </a>
                            </td>
                        </tr>
                    </tbody>
                </table>
	        </div>
            
            <div class="table-responsive">
                <table class="routine-table" style="display:none;">        
                    <tbody id="resInfoTr">
                        <tr id="noRes">
                            <td colspan="9">운동 목록에서 항목을 선택해주세요.</td>
                        </tr>
                    </tbody>
                </table>
            </div>
	        
	        <div class="action-buttons">
	            <button type="button" onclick="submitRoutine()">루틴 수정하기</button>
	            <button type="button" onclick="window.close()">취소</button>
	        </div>
	    </div>
    
    <script>
        // 행 삭제 함수도 순수 JavaScript로 수정
        function removeRow(button) {
            const row = button.closest('tr');
            if (row) {
                row.remove();
            }
            
            // 테이블이 비었을 때 초기 메시지 추가
            const tbody = document.querySelector('#resTb tbody');
            if (tbody.children.length === 0) {
                tbody.innerHTML = `
                    <tr id="noRes">
                        <td colspan="10">운동 목록에서 항목을 선택해주세요.</td>
                    </tr>
                `;
            }
            
            // 번호 재정렬
            reorderNumbers();
        }

        // 번호 재정렬 함수
        function reorderNumbers() {
            const rows = document.querySelectorAll('#resTb tbody tr:not(#noRes)');
            rows.forEach((row, index) => {
                row.querySelector('td[name="no"]').textContent = index + 1;
            });
        }

        // 선택된 항목 삭제
        function deleteSelectedItems() {
            $('#resTb tbody tr').each(function() {
                if ($(this).find('input[name="exercise-select"]').prop('checked')) {
                    $(this).remove();
                }
            });
            reorderNumbers();
        }

        // 폼 초기화
        function resetForm() {
            if (!confirm('입력한 내용을 초기화하시겠습니까?')) {
                return;
            }
            location.reload();
        }

        function openExercisePopup() {
            // 팝업창 열기
            const popup = window.open(
                '${pageContext.request.contextPath}/exercise/routineAddExerciseList.do',
                'exercisePopup',
                'width=1100, height=900, scrollbars=yes, resizable=yes'
            );
            popup.focus();
        }
        
        $(function(){
            if ($("#resTb tbody tr").length === 0) {
                $("#resTb tbody").append($("#resInfoTr").html());
            }
        });

        function setResList(exArr){
            if($("#noRes").length > 0) $("#noRes").remove();

            for(var i=0; i<exArr.length; i++){
                var trCnt = $("#resTb tbody tr").length;
                $("#resTb tbody").append($("#resTr").html());
                var lastTr = $("#resTb tbody tr:last");

                // exerciseNo가 ex_ 또는 cus_로 시작하는지 확인
                var exerciseId = exArr[i].exerciseNo;
                if (!exerciseId.startsWith('ex_') && !exerciseId.startsWith('cus_')) {
                    exerciseId = 'ex_' + exerciseId;
                }

                $(lastTr).attr("id", "tr_" + exerciseId);
                $(lastTr).find("td[name='no']").text(trCnt+1);
                $(lastTr).find("td[name='exerciseName']").text(exArr[i].exerciseName);
                $(lastTr).find("td[name='exerciseCategoryName']").text(exArr[i].exerciseCategoryName);
                $(lastTr).find("td[name='exercisePartName']").text(exArr[i].exercisePartName);
                $(lastTr).find("td[name='caloriesPerUnit']").text(exArr[i].caloriesPerUnit);
            }
        }

        function removeRow(ths) {
            var $tr = $(ths).parents("tr");
            $tr.remove(); 
            
            // 번호 재정렬
            $("#resTb tbody tr").each(function(index) {
                $(this).find("td[name='no']").text(index + 1);
            });
            
            // 테이블이 비었을 때 초기 메시지 추가
            if ($("#resTb tbody tr").length === 0) {
                $("#resTb tbody").append($("#resInfoTr").html());
            }
        }
        
        function submitRoutine() {
            // 필수 입력값 검증
            const routineNo = '${routine.routineNo}';
            const routineName = document.getElementById('routine-name').value;
            const routineCategory = document.getElementById('routine-category').value;
            const publicCheck = document.querySelector('input[name="visibility"]:checked').value === 'public' ? 1 : 0;
            
            if (!routineName) {
                alert('루틴 명칭을 입력해주세요.');
                return;
            }
            if (!routineCategory) {
                alert('루틴 카테고리를 선택해주세요.');
                return;
            }

            // 운동 데이터 수집
            const exercises = [];
            const rows = document.querySelectorAll('#resTb tbody tr:not(#noRes)');
            
            if (rows.length === 0) {
                alert('최소 한 개 이상의 운동을 추가해주세요.');
                return;
            }

            rows.forEach(row => {
                const rowId = row.id; // tr_ex_1 또는 tr_cus_1 형식
                const exerciseId = rowId.split('tr_')[1]; // ex_1 또는 cus_1 형식
                
                const exercise = {
                    exerciseId: exerciseId,
                    sets: row.querySelector('input[name="sets"]').value || 0,
                    repsPerSet: row.querySelector('input[name="reps"]').value || 0,
                    exerciseTime: row.querySelector('input[name="time"]').value || 0,
                    weight: row.querySelector('input[name="weight"]').value || 0
                };
                exercises.push(exercise);
            });

            // 서버로 전송할 데이터
            const data = {
                routineNo: routineNo,
                routineName: routineName,
                routineCategory: routineCategory,
                publicCheck: publicCheck,
                exercises: exercises
            };

            console.log('Sending data to server:', data);

            // AJAX로 서버에 전송
            fetch('${pageContext.request.contextPath}/exercise/updateRoutine.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert('루틴이 성공적으로 수정되었습니다.');
                    window.opener.location.reload(); // 부모 창 새로고침
                    window.close();
                } else {
                    alert('루틴 수정에 실패했습니다: ' + result.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('루틴 수정 중 오류가 발생했습니다.');
            });
        }
    </script>
</body>
</html>