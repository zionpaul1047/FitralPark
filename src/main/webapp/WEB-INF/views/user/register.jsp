<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<%@ include file="/WEB-INF/views/common/asset.jsp" %>
	<style>
		body {background-color: rgb(218, 243, 211);}  
		
		main {
			margin-bottom: 205px;
		}
	    .register-wrapper {
		max-width: 800px;
		margin: 2rem auto;
		background: #fff;
		padding: 2rem;
		border-radius: 10px;
		box-shadow: 0 4px 20px rgba(0,0,0,0.1);
		margin-top: 125px; !important;
		}
		.register-wrapper h2 {
		  text-align: center;
		  margin-bottom: 2rem;
		}
		.form-group label { font-weight: bold; }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
<%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>

	<main>
		<div class="register-wrapper">
			<h2>회원가입</h2>
			<form method="post" action="/fitralpark/register.do">
				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="id">아이디</label> <input type="text"
							class="form-control" id="id" name="id" required>
					</div>
					<div class="form-group col-md-6">
						<label for="nickname">닉네임</label> <input type="text"
							class="form-control" id="nickname" name="nickname">
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="password">비밀번호</label> <input type="password"
							class="form-control" id="password" name="password" required>
					</div>
					<div class="form-group col-md-6">
						<label for="confirmPassword">비밀번호 확인</label> <input
							type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" required>
					</div>
				</div>
				0
				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="name">이름</label> <input type="text"
							class="form-control" id="name" name="name" value="${param.name}">
					</div>
					<div class="form-group col-md-6">
						<label for="jumin">주민등록번호</label> <input type="text"
							class="form-control" id="jumin" name="jumin">
					</div>
				</div>
				<div class="form-group">
					<label for="address">주소</label> <input type="text"
						class="form-control" id="address" name="address"
						placeholder="주소를 입력하거나 검색 버튼을 눌러주세요">
				</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="phone">연락처</label> <input type="text"
							class="form-control" id="phone" name="phone">
					</div>
					<div class="form-group col-md-6">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email"
							value="${param.email}">
					</div>
				</div>
				<button type="submit" class="btn btn-primary btn-block">회원가입</button>
			</form>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
