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
	
	
	<div class="button-group">
		<button type="button" onclick="deletePost('${post.post_no}')">삭제</button>
		<button type="button" onclick="window.close()">취소</button>
	</div>

	
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://bit.ly/4cMuheh"></script>
	<script>
	
		function deletePost(post_no) {
			$.ajax({
	            type: "POST",
	            url: "bulletinPostDelOK.do",
	            data: { post_no: post_no },
	            success: function(response) {
	                alert("삭제되었습니다.");
	                window.opener.location.reload(); // 부모 창 새로고침
	                window.close(); // 팝업 닫기
	            },
	            error: function() {
	                alert("삭제 실패!");
	            }
			} 
		}
			
	</script>
</body>
</html>