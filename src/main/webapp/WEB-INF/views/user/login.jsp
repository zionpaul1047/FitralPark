<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth/auth.css">
  <style>
    .login_section {
      height: 100vh;
      background: linear-gradient(rgba(255,255,255,0.2), rgba(255,255,255,0.2)), url('${pageContext.request.contextPath}/assets/images/auth_bg.png') no-repeat center center;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .login_popup_box {
      width: 420px;
      min-height: 600px;
      background: #fcfcfc;
      border-radius: 10px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      padding: 2rem;
      text-align: left;
      overflow: hidden;
      caret-color: transparent;
    }
    .accounts_image img {
      width: 150px;
      height: auto;
      margin-bottom: 1.5rem;
    }
    #findID {
      margin-right: 10px;
    }
    .already_member_box { margin-top: 10px; }
  </style>
</head>
<body>
  <div class="login_section">
    <div class="login_popup_box">
      <div class="accounts_image">
        <img src="${pageContext.request.contextPath}/assets/images/logo/squarelogo.png" alt="로고">
      </div>

      <div class="accounts_forms login_form w-100" id="login">
        <div class="title text-center">
          <h1>로그인</h1>
          <p class="mt-2">환영합니다! 로그인하여 서비스를 이용하세요.</p>
        </div>
        <form method="post" action="/login.do" class="form">
          <div class="form-group">
            <label for="username">아이디</label>
            <input type="text" name="username" class="form-control" id="username" onfocus="labelUp(this)" onblur="labelDown(this)" required />
          </div>
          <div class="form-group">
            <label for="login_password">비밀번호</label>
            <i class="fa fa-eye-slash" id="eye_icon_login"></i>
            <input type="password" name="password" class="form-control" id="login_password" onfocus="labelUp(this)" onblur="labelDown(this)" required />
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
          <div class="form-group">
            <label for="name">이름</label>
            <input type="text" name="name" class="form-control" id="name" onfocus="labelUp(this)" onblur="labelDown(this)" required />
          </div>
          <div class="form-group">
            <label for="signup_email">이메일</label>
            <input type="email" name="email" class="form-control" id="signup_email" onfocus="labelUp(this)" onblur="labelDown(this)" required />
          </div>
          <div class="form-group">
            <label for="signup_password">비밀번호</label>
            <i class="fa fa-eye-slash" id="eye_icon_signup"></i>
            <input type="password" name="password" class="form-control" id="signup_password" onfocus="labelUp(this)" onblur="labelDown(this)" required />
          </div>
          <div class="form-group">
            <label for="cpass">비밀번호 확인</label>
            <input type="password" name="cpass" class="form-control" id="cpass" onfocus="labelUp(this)" onblur="labelDown(this)" required />
          </div>
          <div class="form-group">
            <button type="submit" class="btn btn-primary register_btn w-100">회원가입</button>
            <button type="button" class="btn btn-secondary register_btn w-100 mt-2" onclick="window.close();">취소</button>
          </div>
        </form>
        <div class="already_member_box text-center">
          <p id="to_login">이미 회원이신가요? 로그인하기</p>
        </div>
      </div>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/auth/auth.js"></script>
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
  </script>
</body>
</html>
