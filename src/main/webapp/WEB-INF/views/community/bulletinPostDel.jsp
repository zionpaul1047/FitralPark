<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="http://bit.ly/3WJ5ilK">
    <style>
        
    </style>
</head>
<body>
    
    <h2>삭제하시겠습니까?</h2>
    
    <input type="hidden" id="post_no" value="${post.post_no}">
    <input type="hidden" id="creator_id" value="${post.creator_id}">

    <div class="button-group">
        <button type="button" onclick="deletePost()">삭제</button>
        <button type="button" onclick="window.close()">취소</button>
    </div>

    
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://bit.ly/4cMuheh"></script>
    <script>
    
        function deletePost() {
            var post_no = $("#post_no").val();
            var creator_id = $("#creator_id").val();
            
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/bulletinPostDelOK.do",
                data: { 
                    post_no: post_no, 
                    creator_id: creator_id 
                },
                success: function(response) {
                    if (response === "success") {
                        alert("삭제되었습니다.");
                        window.opener.location.reload();
                        window.close();
                    } else {
                        alert("삭제 실패!");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert("삭제 실패!");
                }
            });
        }
            
    </script>
</body>
</html>