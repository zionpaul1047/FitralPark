<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }
    
    .report-container {
        background-color: #fff;
        border-radius: 10px;
        padding: 20px;
        max-width: 500px;
        margin: 0 auto;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    h2 {
        color: #333;
        margin-bottom: 20px;
        text-align: center;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    label {
        display: block;
        margin-bottom: 5px;
        color: #555;
        font-weight: bold;
    }
    
    select, textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    
    textarea {
        height: 100px;
        resize: vertical;
    }
    
    .btn-group {
        text-align: center;
        margin-top: 20px;
    }
    
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        margin: 0 5px;
    }
    
    .btn-submit {
        background-color: #4CAF50;
        color: white;
    }
    
    .btn-cancel {
        background-color: #f44336;
        color: white;
    }
    
    .btn:hover {
        opacity: 0.9;
    }
</style>
</head>
<body>
    <div class="report-container">
        <h2>신고하기</h2>
        <form id="reportForm" action="reportOK.do" method="post">
            <input type="hidden" name="target_type" value="${target_type}">
            <input type="hidden" name="target_id" value="${target_id}">
            <input type="hidden" name="creator_id" value="${creator_id}">
            
            <div class="form-group">
                <label for="report_reason">신고 사유</label>
                <select id="report_reason" name="report_reason" required>
                    <option value="">선택하세요</option>
                    <option value="1">부적절한 콘텐츠</option>
                    <option value="2">스팸 또는 광고</option>
                    <option value="3">욕설/비방</option>
                    <option value="4">개인정보 노출</option>
                    <option value="5">저작권 침해</option>
                    <option value="6">기타</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="report_content">상세 내용</label>
                <textarea id="report_content" name="report_content" placeholder="구체적인 신고 사유를 입력해주세요." required></textarea>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-submit">신고하기</button>
                <button type="button" class="btn btn-cancel" onclick="window.close()">취소</button>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('reportForm').onsubmit = function(e) {
            e.preventDefault();
            
            if (confirm('신고하시겠습니까?')) {
                this.submit();
            }
        };
    </script>
</body>
</html> 