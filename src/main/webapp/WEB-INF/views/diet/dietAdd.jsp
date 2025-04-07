<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>식단 생성</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
        }
        .popup-container {
            max-width: 600px;
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
            flex: 1;
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
        
        /* 음식 테이블 스타일 */
        .food-table-container {
            margin: 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        .food-table {
            width: 100%;
            border-collapse: collapse;
        }
        .food-table th, 
        .food-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .food-table th {
            background-color: #f5f5f5;
            font-weight: 500;
        }
        .food-table tr:nth-child(even) {
            background-color: #fafafa;
        }
        .food-table tr:hover {
            background-color: #f0f0f0;
        }
        .food-table input[type="text"] {
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
    background-image: url('<%= request.getContextPath() %>/assets/images/icon/search.png');
}

.delete-button {
    background-image: url('<%= request.getContextPath() %>/assets/images/icon/clear.png');
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
        
        /* 영양소 정보 그리드 */
        .nutrition-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin: 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            background-color: #f9f9f9;
        }
        .nutrition-item {
            text-align: center;
            padding: 8px;
        }
        .nutrition-item .label {
            font-size: 12px;
            color: #666;
        }
        .nutrition-item .value {
            font-size: 16px;
            font-weight: 500;
            color: #333;
        }
        
        .food-table {
     table-layout: fixed;
        width: 100%;
}

.food-table th:nth-child(1) { width: 10%; }  /* 체크박스 열 */
.food-table th:nth-child(2) { width: 20%; } /* 음식식 명 */
.food-table th:nth-child(3) { width: 19%; } 
.food-table th:nth-child(4) { width: 10%; } 
.food-table th:nth-child(5) { width: 8%; } 
.food-table th:nth-child(6) { width: 8%; } 


.food-table td {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
    </style>
</head>
<body>
    <div class="popup-container">
        <h2>식단 생성</h2>
        
        <div class="form-group">
            <label for="diet-name">식단 명칭:</label>
            <input type="text" id="diet-name" class="form-control" placeholder="식단 이름 입력">
        </div>
        
        <div class="form-group">
            <label for="diet-category">식단 카테고리:</label>
            <select id="diet-category" class="form-control">
                <option value="">카테고리 선택</option>
                <option value="체중 감량">체중 감량</option>
                <option value="근육 증가">근육 증가</option>
                <option value="체중 관리 및 유지">체중 관리 및 유지</option>
                <option value="건강 관리">건강 관리</option>
                <option value="특정 목표를 위한 식단">특정 목표를 위한 식단</option>
                <option value="연령 및 성별 맞춤">연령 및 성별 맞춤</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="time-slot">시간대:</label>
            <select id="time-slot" class="form-control">
                <option value="">시간대 선택</option>
                <option value="morning">아침</option>
                <option value="lunch">점심</option>
                <option value="dinner">저녁</option>
                <option value="snack">간식</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>식단 공개 여부:</label>
            <div class="radio-group">
                <label><input type="radio" name="visibility" value="public" checked> 공개</label>
                <label><input type="radio" name="visibility" value="private"> 비공개</label>
            </div>
        </div>
        
        <!-- 음식 테이블 -->
        <div class="food-table-container">
            <table class="food-table" id="food-table">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>음식명</th>
                        <th>열량(kcal)</th>
                        <th>용량(g)</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>삶은 계란</td>
                        <td><input type="text" value="165" size="5"></td>
                        <td><input type="text" value="100" size="3"></td>
                        <td><button class="icon-button search-button"></button></td>
                        <td><button class="icon-button delete-button"></button></td>
                        
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>치킨샐러드</td>
                        <td><input type="text" value="214" size="5"></td>
                        <td><input type="text" value="100" size="3"></td>
                        <td><button class="icon-button search-button"></button></td>
                        <td><button class="icon-button delete-button"></button></td>
                        
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>통밀빵</td>
                        <td><input type="text" value="120" size="5"></td>
                        <td><input type="text" value="50" size="3"></td>
                        <td><button class="icon-button search-button"></button></td>
                        <td><button class="icon-button delete-button"></button></td>
                        
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class="buttons-row">
            <button class="btn" onclick="resetForm()">초기화</button>
            <button class="btn" onclick="deleteSelectedItems()" style="
            position: relative;
            right: 85px;">
            선택 항목 삭제</button>
            <div>
                <button class="btn btn-primary">✓ 등록하기</button>
                <button class="btn btn-primary">↪ 불러오기</button>
            </div>
        </div>

        <button class="btn-add" onclick="addFoodItem()">
            <span>+</span> 음식 추가하기
        </button>
        
        
        
        <div class="action-buttons">
            <button>+ 식단 등록하기</button>
            <button>+ 식단 추가 후 즐겨찾기 등록</button>
        </div>
    </div>

    <script>
        function addFoodItem() {
            const table = document.getElementById('food-table').getElementsByTagName('tbody')[0];
            const newRow = table.insertRow();
            newRow.innerHTML = `
                <td><input type="checkbox"></td>
                <td><input type="text" placeholder="음식명 입력"></td>
                <td><input type="text" size="5" placeholder="열량"></td>
                <td><input type="text" size="3" placeholder="용량"></td>
                <td></td>
                <td><button class="icon-button delete-button" onclick="removeRow(this)"></button></td>
            `;
        }

        function deleteSelectedItems() {
            const table = document.getElementById('food-table').getElementsByTagName('tbody')[0];
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
            document.getElementById('diet-name').value = '';
            document.getElementById('diet-category').selectedIndex = 0;
            document.getElementById('time-slot').selectedIndex = 0;
            document.querySelector('input[name="visibility"][value="public"]').checked = true;
            
            const tbody = document.getElementById('food-table').getElementsByTagName('tbody')[0];
            tbody.innerHTML = '';
        }
    </script>
</body>
</html>
