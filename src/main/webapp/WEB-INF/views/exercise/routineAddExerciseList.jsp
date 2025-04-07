<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>운동 목록 불러오기</title>
	<script src="https://kit.fontawesome.com/11104cc7aa.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<style>
	
        body {
			background-color: rgb(218, 243, 211);
		}
	
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
        
        a {
        	font-size: 14px;
        	font-style: Arial;
        	color: black;
        	text-decoration: none;
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

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }

        .pagination a {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-decoration: none;
            color: #333;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
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
    <c:set var="totalPages" value="${(fn:length(exerciseList) + 9) / 10}" />
    <c:set var="currentPage" value="${empty param.page ? 1 : param.page}" />
    <c:set var="startIndex" value="${(currentPage - 1) * 10}" />
    <c:set var="endIndex" value="${startIndex + 9}" />

    <table id="exercise-table">
            <thead>
                <tr>
                <th><input type="checkbox" id="exercise_check_all"></th>
                <th>운동명</th>
                <th>운동 카테고리</th>
                <th>운동 부위</th>
                <th>소모 열량(kcal)</th>
                    <th>즐겨찾기</th>
                </tr>
            </thead>
        <tbody>
            <c:forEach items="${exerciseList}" var="ex" begin="${startIndex}" end="${endIndex}">
                <tr id="tr_ex_${ex.exerciseNo}">
                    <input type="hidden" name="e_idx" value="${ex.exerciseNo}" />
                    <input type="hidden" name="exerciseName" value="${ex.exerciseName}" />
                    <input type="hidden" name="exerciseCategoryName" value="${ex.exerciseCategoryName}" />
                    <input type="hidden" name="exercisePartName" value="${ex.exercisePartName}" />
                    <input type="hidden" name="caloriesPerUnit" value="${ex.caloriesPerUnit}" />

                    <td><input type="checkbox" name="chk_exercise" value="${ex.exerciseNo}"></td>
                    <td name="exerciseName"><c:out value="${ex.exerciseName}"/></td>
                    <td name="exerciseCategoryName"><c:out value="${ex.exerciseCategoryName}"/></td>
                    <td name="exercisePartName"><c:out value="${ex.exercisePartName}"/></td>
                    <td name="caloriesPerUnit"><c:out value="${ex.caloriesPerUnit}"/></td>
                    <td>⭐</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:forEach begin="1" end="${totalPages}" var="page">
            <a href="?page=${page}&keyword=${param.keyword}&category=${param.category}" 
               class="${page == currentPage ? 'active' : ''}">${page}</a>
        </c:forEach>
    </div>

    <hr>
    <h3>사용자 정의 운동 목록</h3>
    <c:set var="customTotalPages" value="${(fn:length(customExerciseList) + 9) / 10}" />
    <c:set var="customCurrentPage" value="${empty param.customPage ? 1 : param.customPage}" />
    <c:set var="customStartIndex" value="${(customCurrentPage - 1) * 10}" />
    <c:set var="customEndIndex" value="${customStartIndex + 9}" />

    <table id="customExercise-table">
        <thead>
            <tr>
                <th><input type="checkbox" id="customExercise_check_all"></th>
                <th>운동명</th>
                <th>운동 카테고리</th>
                <th>운동 부위</th>
                <th>소모 열량(kcal)</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${customExerciseList}" var="customex" begin="${customStartIndex}" end="${customEndIndex}">
                <tr id="tr_cus_${customex.customExerciseNo}">
                    <input type="hidden" name="c_idx" value="${customex.customExerciseNo}" />
                    <input type="hidden" name="customExerciseName" value="${customex.customExerciseName}" />
                    <input type="hidden" name="customExerciseCategoryName" value="${customex.customExerciseCategoryName}" />
                    <input type="hidden" name="customExercisePartName" value="${customex.customExercisePartName}" />
                    <input type="hidden" name="customCaloriesPerUnit" value="${customex.customCaloriesPerUnit}" />

                    <td><input type="checkbox" name="chk_customExercise" value="${customex.customExerciseNo}"></td>
                    <td name="customExerciseName"><c:out value="${customex.customExerciseName}"/></td>
                    <td name="customExerciseCategoryName"><c:out value="${customex.customExerciseCategoryName}"/></td>
                    <td name="customExercisePartName"><c:out value="${customex.customExercisePartName}"/></td>
                    <td name="customCaloriesPerUnit"><c:out value="${customex.customCaloriesPerUnit}"/></td>
                    <td>
                        <button type="button" class="rudBtn" onclick="editCustomExercise('${customex.customExerciseNo}', '${customex.customExerciseName}', '${customex.customExerciseCategoryNo}', '${customex.customExercisePartNo}', '${customex.customCaloriesPerUnit}')"><i class="fa-solid fa-pen-to-square"></i></button>
                        <button type="button" class="rudBtn" onclick="deleteCustomExercise('${customex.customExerciseNo}')"><i class="fa-solid fa-x"></i></button>
                    </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    <div class="pagination">
        <c:forEach begin="1" end="${customTotalPages}" var="page">
            <a href="?customPage=${page}&keyword=${param.keyword}&category=${param.category}" 
               class="${page == customCurrentPage ? 'active' : ''}">${page}</a>
        </c:forEach>
    </div>

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
        <form method="post" action="/fitralpark/exercise/addCustomExercise.do" id="bulkExerciseForm" onsubmit="return submitCustomExercise()">
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
            	<a href="#" class="btn btn-primary" onclick="selectExercise();return false;">불러오기</a>
           		<button type="button" class="btn" onclick="window.close()">취소</button>
            </div>
        </div>
	</div>

    <script>
    
    
    
        function addExerciseItem() {
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
                return false;
            }

            let isValid = true;
            rows.forEach(row => {
                const inputs = row.querySelectorAll('input[type="text"], select');
                inputs.forEach(input => {
                    if (!input.value) {
                        isValid = false;
                        alert("모든 필드를 입력해주세요.");
                        return false;
                    }
                });
            });

            if (isValid) {
                return true;
            }
            return false;
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

        $(function(){
            $("#exercise_check_all").click(function(){
                var chk = $(this).is(":checked");
                if(chk) $("#exercise-table input[name='chk_exercise']").prop('checked', true);
                else  $("#exercise-table input[name='chk_exercise']").prop('checked', false); 
            });
        });

        $(function(){
            $("#customExercise_check_all").click(function(){
                var chk = $(this).is(":checked");
                if(chk) $("#customExercise-table input[name='chk_customExercise']").prop('checked', true);
                else  $("#customExercise-table input[name='chk_customExercise']").prop('checked', false); 
            });
        });

        function selectExercise(){
            
            var exArr = new Array();

            $("#exercise-table input[name='chk_exercise']:checked").each(function() {
                var exerciseNo = $(this).val();
                $tr = $("#tr_ex_"+exerciseNo);
                console.log($tr.html());
                var exObj = {
                    exerciseNo: 'ex_' + $tr.find("input[name='e_idx']").val(),
                    exerciseName: $tr.find("input[name='exerciseName']").val(),
                    exerciseCategoryName: $tr.find("input[name='exerciseCategoryName']").val(),
                    exercisePartName: $tr.find("input[name='exercisePartName']").val(),
                    caloriesPerUnit: $tr.find("input[name='caloriesPerUnit']").val()
                };
                exArr.push(exObj);
            });

            $("#customExercise-table input[name='chk_customExercise']:checked").each(function() {
                var exerciseNo = $(this).val();
                $tr = $("#tr_cus_"+exerciseNo);
                console.log($tr.html());
                var exObj = {
                    exerciseNo: 'cus_' + $tr.find("input[name='c_idx']").val(), // 동일한 키로 넘겨야 부모창에서 setResList가 잘 동작함
                    exerciseName: $tr.find("input[name='customExerciseName']").val(),
                    exerciseCategoryName: $tr.find("input[name='customExerciseCategoryName']").val(),
                    exercisePartName: $tr.find("input[name='customExercisePartName']").val(),
                    caloriesPerUnit: $tr.find("input[name='customCaloriesPerUnit']").val()
                };
                exArr.push(exObj);
                console.log("생성된 사용자 정의 운동 객체: ", exObj);
            });
            console.log("최종 전달할 exArr: ", exArr);

            window.opener.setResList(exArr);
            window.close();
        }
    
    </script>
</body>
</html>