<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>로그인 / 회원가입</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth/auth.css">
</head>

<body>
  <div class="login_section">
    <div class="container accounts_container d-flex">
      <!-- 이미지 영역 -->
      <div class="accounts_col image_col d-flex align-items-center justify-content-center">
        <div class="accounts_image text-center">
          <img src="${pageContext.request.contextPath}/assets/images/logo/squarelogo.png" alt="로고" style="max-width: 200px; height: auto;">
        </div>
      </div>
      <!-- 로그인/회원가입 영역 -->
      <div class="accounts_col form_col">

        <!-- 로그인 Form -->
        <div class="accounts_forms login_form w-100 h-100" id="login">
          <div class="title p-4 w-100 text-center">
            <h1>로그인</h1>
            <p class="mt-3">환영합니다! 로그인하여 서비스를 이용하세요.</p>
          </div>
          <form method="post" action="/login.do" class="form w-100 p-4">
            <div class="form-group">
              <label for="email">이메일</label>
              <input type="email" name="email" class="form-control" id="email" onfocus="labelUp(this)" onblur="labelDown(this)" required />
            </div>
            <div class="form-group">
              <label for="login_password">비밀번호</label>
              <i class="fa fa-eye-slash" id="eye_icon_login"></i>
              <input type="password" name="pass" class="form-control" id="login_password" onfocus="labelUp(this)" onblur="labelDown(this)" required />
            </div>
            <div class="form-group mb-0">
              <button type="submit" class="btn btn-primary register_btn w-100">로그인</button>
              <button type="button" class="btn btn-secondary register_btn w-100 mt-2" onclick="window.close();">취소</button>
            </div>
          </form>
          <div class="already_member_box d-flex justify-content-between px-4">
            <span id="to_signup">회원가입하기</span>
            <span>비밀번호 찾기</span>
          </div>
        </div>

        <!-- 회원가입 Form (처음엔 숨김) -->
        <div class="accounts_forms signup_form w-100 h-100 d-none" id="signup">
          <div class="title p-4 w-100 text-center">
            <h1>회원가입</h1>
            <p class="mt-3">서비스 이용을 위해 정보를 입력해주세요.</p>
          </div>
          <form method="post" action="/register.do" class="form w-100 p-4">
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
              <input type="password" name="pass" class="form-control" id="signup_password" onfocus="labelUp(this)" onblur="labelDown(this)" required />
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
  </div>

  <!-- JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/js/auth/auth.js"></script>
</body>

</html>
