<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>운동 목록 불러오기</title>
	<script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            width: 900px;
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
			align-items: center;
		}
		
		.action-buttons {
			display: flex;
			justify-content: flex-end;
			margin: 10px auto;
		}

        .rudBtn {
            width: 20px;
            height: 18px;
            border: 0;
            background: none;
            padding: 0px;
        }
        
        .rudBtn:hover {

        }
        
        .buttons-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            align-items: center;
        }

        .form-control {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
        }

        #exercise-table th:nth-child(1) { width: 5%; }  /* 체크박스 열 */
		#exercise-table th:nth-child(2) { width: 21.5%; } /* 루틴명 */
		#exercise-table th:nth-child(3) { width: 21.5%; } /* 루틴 카테고리 */
		#exercise-table th:nth-child(4) { width: 21.5%; } /* 작성일 */
		#exercise-table th:nth-child(5) { width: 21.5%; } /* 작성자 */
		#exercise-table th:nth-child(6) { width: 9%; } /* 즐겨찾기 */
		
		#customExercise-table th:nth-child(1) { width: 5%; }  /* 체크박스 열 */
		#customExercise-table th:nth-child(2) { width: 21.25%; } /* 루틴명 */
		#customExercise-table th:nth-child(3) { width: 21.25%; } /* 루틴 카테고리 */
		#customExercise-table th:nth-child(4) { width: 21.25%; } /* 작성일 */
		#customExercise-table th:nth-child(5) { width: 21.25%; } /* 작성자 */
		#customExercise-table th:nth-child(6) { width: 10%; } /* 즐겨찾기 */
		
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
        
    </style>
	</head>
<body>
	
	<div class="popup-container">

	<h3>운동 검색</h3>
    <form method="get" action="/fitralpark/exercise/routineAddExerciseList.do">
    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" class="form-control">
    <select name="category" class="form-control">
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
        <table id="exercise-table">
            <thead>
                <tr>
                    <th>✅</th>
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
                        <td name="exerciseName">${ex.exerciseName}</td>
                        <td name="exerciseCategoryName">${ex.exerciseCategoryName}</td>
                        <td name="exercisePartName">${ex.exercisePartName}</td>
                        <td name="caloriesPerUnit">${ex.caloriesPerUnit}</td>
                        <td>⭐</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <hr>
        <h3>사용자 정의 운동 목록</h3>
		<table id="customExercise-table">
		    <thead>
		        <tr>
		            <th>✅</th>
		            <th>운동명</th>
		            <th>운동 카테고리</th>
		            <th>운동 부위</th>
		            <th>소모 열량(kcal)</th>
		            <th></th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach items="${customExerciseList}" var="customex">
		            <tr data-exercise-no="${customex.customExerciseNo}">
		                <td><input type="checkbox" name="customSelectExercise" value="${customex.customExerciseNo}"></td>
		                <td name="exerciseName">${customex.customExerciseName}</td>
		                <td name="exerciseCategoryName">${customex.customExerciseCategoryName}</td>
		                <td name="exercisePartName">${customex.customExercisePartName}</td>
		                <td name="caloriesPerUnit">${customex.customCaloriesPerUnit}</td>
		                <td>
		                    <button type="button" class="rudBtn" onclick="editCustomExercise('${customex.customExerciseNo}', '${customex.customExerciseName}', '${customex.customExerciseCategoryNo}', '${customex.customExercisePartNo}', '${customex.customCaloriesPerUnit}')"><i class="fa-solid fa-pen-to-square"></i></button>
		                    <button type="button" class="rudBtn" onclick="deleteCustomExercise('${customex.customExerciseNo}')"><i class="fa-solid fa-x"></i></button>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>

		<!-- 수정 폼 -->
		<div id="editForm" style="display: none;">
			<h3>사용자 정의 운동 수정</h3>
			<form method="post" action="/fitralpark/exercise/updateCustomExercise.do">
				<input type="hidden" name="customExerciseNo" id="editCustomExerciseNo">
				<table id="custom-exercise-edit-table">
					<thead>
						<tr>
							<th>운동명</th>
							<th>운동 카테고리</th>
							<th>운동 부위</th>
							<th>소모 열량(kcal)</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" id="editExerciseName" name="exerciseName" class="form-control" required></td>
							<td>
								<select id="editExerciseCategory" name="exerciseCategory" class="form-control" required>
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
								<select id="editExercisePart" name="exercisePart" class="form-control" required>
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
							<td><input type="text" id="editCaloriesPerUnit" name="caloriesPerUnit" class="form-control" required></td>
							<td>
								<button type="button" class="rudBtn" onclick="hideEditForm()"><i class="fa-solid fa-xmark"></i></button>
								<button type="submit" class="rudBtn"><i class="fa-solid fa-check"></i></button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<!-- 운동 추가하기 폼 -->
		<div id="addForm">
			<h3>사용자 정의 운동 추가</h3>
			<form method="post" action="/fitralpark/exercise/addCustomExercise.do" id="bulkExerciseForm">
				<table id="custom-exercise-add-table">
					<thead>
						<tr>
							<th>운동명</th>
							<th>운동 카테고리</th>
							<th>운동 부위</th>
							<th>소모 열량(kcal)</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<!-- 여기에 JS로 행이 추가됨 -->
					</tbody>
				</table>
				<div class="action-buttons">
					<button type="button" onclick="addExerciseItem()">
						<span><i class="fa-solid fa-dumbbell"></i></span> 운동 추가하기
					</button>
					<button type="submit" id="exerciseAddBtn">
						<span><i class="fa-solid fa-plus"></i></span> 등록하기
					</button>
				</div>
    </form>
		</div>

        <div class="buttons-row">
	        	<div>
		            <button class="btn" onclick="resetForm()">초기화</button>
		        </div>
		        <div>
		        	<button type="button" class="btn btn-primary" onclick="sendToParent()">불러오기</button>
            		<button type="button" class="btn" onclick="window.close()">취소</button>
		        </div>
	        </div>
	</div>

    <script>
    
    
    
    function addExerciseItem() {
        const editForm = document.getElementById('editForm');
        const addForm = document.getElementById('addForm');
        
        // 수정 폼 숨기기
        editForm.style.display = 'none';
        
        // 운동 추가하기 폼 표시
        addForm.style.display = 'block';
        
        // h3 태그 표시
        const addFormH3 = addForm.querySelector('h3');
        if (addFormH3) {
            addFormH3.style.display = 'block';
        }
        
        // 테이블 헤더가 없으면 추가
        const addTable = document.querySelector('#custom-exercise-add-table');
        if (!addTable.querySelector('thead')) {
            const thead = document.createElement('thead');
            thead.innerHTML = `
                <tr>
                    <th>운동명</th>
                    <th>운동 카테고리</th>
                    <th>운동 부위</th>
                    <th>소모 열량(kcal)</th>
                    <th></th>
                </tr>
            `;
            addTable.insertBefore(thead, addTable.firstChild);
        }
        
        const tbody = document.querySelector('#custom-exercise-add-table tbody');
        const newRow = document.createElement('tr');

        newRow.innerHTML = `
            <td><input type="text" name="exerciseName" placeholder="운동명 입력" class="form-control" required></td>
            <td>
                <select name="exerciseCategory" class="form-control" required>
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
                <select name="exercisePart" class="form-control" required>
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
            <td><input type="text" name="caloriesPerUnit" placeholder="소모 열량" class="form-control" required></td>
            <td>
                <button type="button" class="rudBtn" onclick="removeExerciseItem(this)">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </td>
        `;
        
        tbody.appendChild(newRow);
    }
    
    function removeExerciseItem(button) {
        const row = button.closest('tr');
        const tbody = row.parentElement;
        tbody.removeChild(row);
        
        // 마지막 행이 제거되었을 때 테이블 헤더와 h3 태그도 제거
        if (tbody.children.length === 0) {
            const addTable = document.querySelector('#custom-exercise-add-table');
            const thead = addTable.querySelector('thead');
            if (thead) {
                thead.remove();
            }
            
            // h3 태그 숨기기
            const addForm = document.getElementById('addForm');
            const addFormH3 = addForm.querySelector('h3');
            if (addFormH3) {
                addFormH3.style.display = 'none';
            }
        }
    }
    
    function submitCustomExercise() {
        const form = document.getElementById("bulkExerciseForm");
        const rows = form.querySelectorAll("#custom-exercise-add-table tbody tr");

        if (rows.length === 0) {
            alert("추가할 운동을 입력해주세요.");
            return;
        }

        let isValid = true;
        rows.forEach(row => {
            const inputs = row.querySelectorAll('input, select');
            inputs.forEach(input => {
                if (!input.value) {
                    isValid = false;
                    alert("모든 필드를 입력해주세요.");
                    return;
                }
            });
        });

        if (isValid) {
            form.submit();
        }
    }
    
    function editCustomExercise(customExerciseNo, exerciseName, categoryNo, partNo, caloriesPerUnit) {
        document.getElementById('editCustomExerciseNo').value = customExerciseNo;
        document.getElementById('editExerciseName').value = exerciseName;
        document.getElementById('editExerciseCategory').value = categoryNo;
        document.getElementById('editExercisePart').value = partNo;
        document.getElementById('editCaloriesPerUnit').value = caloriesPerUnit;
        
        document.getElementById('editForm').style.display = 'block';
        document.getElementById('addForm').style.display = 'none';
        document.getElementById('editForm').scrollIntoView({ behavior: 'smooth' });
    }
    
    function hideEditForm() {
        const editForm = document.getElementById('editForm');
        const addForm = document.getElementById('addForm');
        
        // 수정 폼 제거
        editForm.style.display = 'none';
        
        // 운동 추가하기 폼 표시
        addForm.style.display = 'block';
        
        // 테이블 초기화
        const addTableBody = document.querySelector('#custom-exercise-add-table tbody');
        addTableBody.innerHTML = '';
        
        // 테이블 헤더 제거
        const addTable = document.querySelector('#custom-exercise-add-table');
        const thead = addTable.querySelector('thead');
        if (thead) {
            thead.remove();
        }
        
        // h3 태그 숨기기
        const addFormH3 = addForm.querySelector('h3');
        if (addFormH3) {
            addFormH3.style.display = 'none';
        }
    }
    
    function deleteCustomExercise(customExerciseNo) {
        if(!customExerciseNo) {
            alert('삭제할 운동을 찾을 수 없습니다.');
            return;
        }
        
        if(confirm('정말 삭제하시겠습니까?')) {
            const params = new URLSearchParams();
            params.append('customExerciseNo', customExerciseNo);

            fetch('/fitralpark/exercise/deleteCustomExercise.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if(data.success) {
                    alert('삭제되었습니다.');
                    const row = document.querySelector(`tr[data-exercise-no="${customExerciseNo}"]`);
                    if(row) {
                        row.remove();
                    } else {
                        location.reload();
                    }
                } else {
                    alert(data.message || '삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('삭제 중 오류가 발생했습니다.');
            });
        }
    }
    
    </script>

    <script>
        function openExercisePopup() {
            window.name = 'mainWindow'; // 부모 창의 이름 설정
            window.open(
                '${pageContext.request.contextPath}/exercise/routineAddExerciseList.do',
                'exercisePopup',
                'width=1000,height=1000,scrollbars=yes'
            );
    }
    </script>

    <script>
    function sendToParent() {
        const checked = document.querySelectorAll('input[name="selectExercise"]:checked, input[name="customSelectExercise"]:checked');
        
        if (checked.length === 0) {
            alert("운동을 하나 이상 선택해주세요.");
            return;
        }

        // 부모창의 tbody 요소 찾기
        const parentTbody = opener.document.querySelector('#routine-table tbody');
        
        // 선택된 운동들을 부모창의 테이블에 추가
        checked.forEach(checkbox => {
            const row = checkbox.closest('tr');
            const isCustom = checkbox.name === 'customSelectExercise';
            const exerciseNo = isCustom ? 'C' + checkbox.value : checkbox.value;
            
            // 이미 존재하는 운동인지 확인
            const existingRow = parentTbody.querySelector(`tr[data-exercise-no="${exerciseNo}"]`);
            if (existingRow) {
                return; // 이미 존재하면 건너뛰기
            }

            // 데이터 가져오기
            const exerciseName = row.querySelector('td[name="exerciseName"]').textContent;
            const categoryName = row.querySelector('td[name="exerciseCategoryName"]').textContent;
            const partName = row.querySelector('td[name="exercisePartName"]').textContent;
            const calories = row.querySelector('td[name="caloriesPerUnit"]').textContent;

            // 새로운 행 생성
            const newRow = document.createElement('tr');
            newRow.setAttribute('data-exercise-no', exerciseNo);
            
            newRow.innerHTML = `
                <td><input type="checkbox" name="exercise-select"></td>
                <td>${exerciseName}</td>
                <td>${categoryName}</td>
                <td>${partName}</td>
                <td>${calories}</td>
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
            
            parentTbody.appendChild(newRow);
        });

        // 초기 메시지 제거
        const noResRow = parentTbody.querySelector('#noRes');
        if (noResRow) {
            noResRow.remove();
        }

        window.close();
    }
    </script>
</body>
</html>