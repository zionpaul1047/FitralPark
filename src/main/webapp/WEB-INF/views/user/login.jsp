<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 / 회원가입</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
<link rel="stylesheet" href="\${pageContext.request.contextPath}/assets/css/auth/auth.css">
<style>
.login_section {
	height: 100vh;
	background: linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.2)),
		url('\${pageContext.request.contextPath}/assets/images/auth_bg.png') no-repeat center center;
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
}
.login_popup_box {
  width: 800px;
  min-height: 650px;
  background: #fcfcfc;
  border-radius: 10px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  text-align: left;
  overflow: hidden;
  caret-color: transparent;
  user-select: none;
}
.accounts_image img {
	width: 150px;
	height: auto;
	margin-bottom: 1.5rem;
}
#findID {
	margin-right: 10px;
}
.already_member_box {
	margin-top: 10px;
}
.signup_scroll_area {
  max-height: 320px;
  overflow-y: auto;
  padding-right: 8px;
}
</style>
</head>
<body>
<div class="login_section">
	<div class="login_popup_box">
		<div class="accounts_forms login_form w-100" id="login">
			<div class="accounts_image">
				<img src="\${pageContext.request.contextPath}/assets/images/logo/squarelogo.png" alt="로고">
			</div>
			<div class="title text-center">
				<h1>로그인</h1>
				<p class="mt-2">환영합니다! 로그인하여 서비스를 이용하세요.</p>
			</div>
			<form method="post" action="/login.do" class="form">
				<div class="form-group">
					<label for="username">아이디</label>
					<input type="text" name="username" class="form-control" id="username" required />
				</div>
				<div class="form-group">
					<label for="login_password">비밀번호</label>
					<i class="fa fa-eye-slash" id="eye_icon_login"></i>
					<input type="password" name="password" class="form-control" id="login_password" required />
				</div>
				<div class="form-group mb-0">
					<button type="submit" class="btn btn-primary register_btn w-100">로그인</button>
					<button type="button" class="btn btn-secondary register_btn w-100 mt-2" onclick="window.close();">취소</button>
				</div>
			</form>
			<div class="already_member_box d-flex justify-content-between px-2">
				<span id="to_signup" onclick="moveToRegister()">회원가입하기</span>
				<div>
					<span name=findId id=findID>아이디 찾기</span>
					<span name=findPw id=findPw>비밀번호 찾기</span>
				</div>
			</div>
		</div>
		<div class="accounts_forms signup_form w-100" id="signup" style="display: none;">
			<div class="title text-center">
				<h1>회원가입</h1>
				<p class="mt-2">서비스 이용을 위해 정보를 입력해주세요.</p>
			</div>
			<form method="get" onsubmit="redirectToRegister(event)" class="form">
				<div class="signup_scroll_area">
					<div class="form-group">
						<label for="id">아이디</label>
						<input type="text" name="id" class="form-control" id="signup_id" required />
					</div>
					<div class="form-group">
						<label for="signup_password">비밀번호</label>
						<i class="fa fa-eye-slash" id="eye_icon_signup"></i>
						<input type="password" name="password" class="form-control" id="signup_password" required />
					</div>
					<div class="form-group">
						<label for="cpass">비밀번호 확인</label>
						<input type="password" name="cpass" class="form-control" id="cpass" required />
					</div>
					<div class="form-group">
						<label for="signup_email">이메일</label>
						<input type="email" name="email" class="form-control" id="signup_email" required />
					</div>
					<div class="form-group">
						<label for="name">이름</label>
						<input type="text" name="name" class="form-control" id="name" required />
					</div>
					<div class="form-group">
						<label for="jumin1">주민등록번호</label><br />
						<input type="text" name="jumin1" id="jumin1" class="form-control d-inline-block text-center" maxlength="6" style="width: 100px;" required />
						<span class="mx-1">-</span>
						<input type="text" name="jumin2" id="jumin2" class="form-control d-inline-block text-center" maxlength="7" style="width: 120px;" required />
					</div>
					<div class="form-group">
						<label for="address">주소</label>
						<input type="text" name="address" id="address" class="form-control" required />
					</div>
					<div class="form-group">
						<label for="phone">연락처</label>
						<input type="text" name="phone" id="phone" class="form-control" required />
					</div>
				</div>
				<div class="form-group mt-3">
					<button type="submit" class="btn btn-primary register_btn w-100">회원가입</button>
					<button type="button" class="btn btn-secondary register_btn w-100 mt-2" onclick="window.close();">취소</button>
				</div>
			</form>
			<div class="already_member_box text-center mt-2">
				<p id="to_login">이미 회원이신가요? 로그인하기</p>
			</div>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
function moveToRegister() {
	document.getElementById("login").style.display = "none";
	document.getElementById("signup").style.display = "block";
}
function redirectToRegister(e) {
	e.preventDefault();
	const name = document.getElementById("name")?.value || '';
	const email = document.getElementById("signup_email")?.value || '';
	window.opener.location.href = '/fitralpark/register.do?name=' + encodeURIComponent(name) + '&email=' + encodeURIComponent(email);
	window.close();
}

// 비밀번호 보기/숨기기 토글
document.addEventListener("DOMContentLoaded", function () {
	function togglePasswordView(toggleId, inputId) {
		const toggleIcon = document.getElementById(toggleId);
		const inputField = document.getElementById(inputId);

		if (toggleIcon && inputField) {
			toggleIcon.style.cursor = "pointer";
			toggleIcon.addEventListener("click", function () {
				const type = inputField.getAttribute("type") === "password" ? "text" : "password";
				inputField.setAttribute("type", type);
				this.classList.toggle("fa-eye");
				this.classList.toggle("fa-eye-slash");
			});
		}
	}

	togglePasswordView("eye_icon_login", "login_password");
	togglePasswordView("eye_icon_signup", "signup_password");
});
</script>
</body>
</html>