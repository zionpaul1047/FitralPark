<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>FITRALPARK_SIGN</title>
	<%@ include file="/WEB-INF/views/common/asset.jsp" %>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth/auth.css">

  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Poppins', sans-serif;
    }

    .login_section {
      height: 100vh;
      background: linear-gradient(rgba(255,255,255,0.2), rgba(255,255,255,0.2)),
        url('${pageContext.request.contextPath}/assets/images/auth_bg.png') no-repeat center center;
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
    }

    .accounts_image img {
      width: 150px;
      height: auto;
      margin-bottom: 1.5rem;
      display: block;
      margin-left: auto;
      margin-right: auto;
    }

    .form-scroll-box {
      max-height: 500px;
      overflow-y: auto;
      padding-right: 10px;
    }

    .form-scroll-box::-webkit-scrollbar {
      width: 6px;
    }

    .form-scroll-box::-webkit-scrollbar-thumb {
      background-color: rgba(0,0,0,0.2);
      border-radius: 4px;
    }

    .already_member_box {
      margin-top: 10px;
    }
    /* 한 줄 줄맞춤 보완용 */
	.form-group .form-control,
	.form-group .btn {
	  height: 38px;
	  font-size: 14px;
	}
	#zipcode,
	#address,
	#address_detail {
	  font-size: 14px;
	}
	
	/* 텍스트 박스 사이즈 */
	.input-small {
	  width: 140px;
	}
	.input-medium {
	  width: 200px;
	}
	.input-large {
	  width: 500px;
	}

    
  </style>
</head>
<body>
  <div class="login_section">
    <div class="login_popup_box">
      
      <!-- 로그인 폼 -->
      <div class="accounts_forms login_form w-100" id="login" style="display: block;">
        <div class="accounts_image">
          <img src="${pageContext.request.contextPath}/assets/images/logo/squarelogo.png" alt="로고">
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
            <button type="submit" class="btn btn-primary w-100">로그인</button>
            <button type="button" class="btn btn-secondary w-100 mt-2" onclick="window.close();">취소</button>
          </div>
        </form>
        <div class="already_member_box d-flex justify-content-between px-2">
          <span onclick="moveToRegister()">회원가입하기</span>
          <div>
            <span id="findID">아이디 찾기</span>
            <span id="findPw">비밀번호 찾기</span>
          </div>
        </div>
      </div>

      <!-- 회원가입 폼 -->
      <div class="accounts_forms signup_form w-100" id="signup" style="display: none;">
        <div class="title text-center">
          <h1>회원가입</h1>
          <p class="mt-2">서비스 이용을 위해 정보를 입력해주세요.</p>
        </div>
        <form method="get" onsubmit="redirectToRegister(event)" class="form">
          <div class="form-scroll-box">
          
			<!-- 아이디 -->
			<div class="form-group">
			  <label for="signup_id">아이디<span class="text-danger"> *</span></label>
			  <div class="input-group input-large">
			    <input type="text" name="id" class="form-control" id="signup_id"
			           placeholder="영문 소문자+숫자 조합, 4~16자" required/>
			    <div class="input-group-append">
			      <button type="button" class="btn btn-outline-secondary" onclick="checkDuplicateId()">중복확인</button>
			    </div>
			  </div>
			  <small id="idCheckMessage" class="form-text"></small>
			</div>
			
			<!-- 비밀번호 -->
			<div class="form-group">
			  <label for="signup_password">비밀번호<span class="text-danger"> *</span></label>
			  <i class="fa fa-eye-slash" id="eye_icon_signup"></i>
			  <input type="password" name="password" class="form-control input-large" id="signup_password"
			         placeholder="영문 대소문자+숫자+특수문자 중 2가지 이상, 8~16자" required />
			  <small id="pwValidationMessage" style="display: block; margin-top: 4px;"></small>
			</div>
			
			<!-- 비밀번호 확인 -->
			<div class="form-group">
			  <label for="cpass">비밀번호 확인<span class="text-danger"> *</span></label>
			  <input type="password" name="cpass" class="form-control input-large" id="cpass"
			         placeholder="비밀번호를 다시 입력하세요" required />
			  <small id="pwMatchMessage" style="display: block; margin-top: 4px;"></small>
			</div>

			<!-- 이름 -->
			<div class="form-group">
			  <label for="name">이름<span class="text-danger"> *</span></label>
			  <input type="text" name="name" class="form-control input-medium" id="name"
			         placeholder="한글 또는 영문, 2~20자" required />
			</div>

			<!-- 주민등록번호 -->
			<div class="form-group">
			  <label for="jumin1">주민등록번호<span class="text-danger"> *</span></label>
			  <div class="d-flex align-items-center">
			    <!-- 앞자리 6자리 (생년월일) -->
			    <input type="text" name="jumin1" id="jumin1" class="form-control text-center input-small"
			           maxlength="6" pattern="\d{6}" required
			           placeholder="예: 990101" />
			
			    <span class="mx-2">-</span>
			
			    <!-- 뒷자리 첫 1자리 (성별) -->
			    <input type="text" name="jumin2_first" id="jumin2_first" class="form-control text-center"
			           maxlength="1" pattern="[1-4]" required
			           placeholder="1~4" style="width: 40px;" />
			
			    <!-- 뒷자리 나머지 6자리 (비밀번호 형식 처리) -->
			    <input type="password" name="jumin2_rest" id="jumin2_rest" class="form-control text-center input-small"
			           maxlength="6" pattern="\d{6}" required
			           placeholder="******" />
			  </div>
			  <small class="form-text text-muted mt-1">
			    숫자만 입력. 예: 990101-1****** 형식
			  </small>
			</div>
			
			<!-- 닉네임 -->
			<div class="form-group">
			  <label for="nickname">닉네임<span class="text-danger"> *</span></label>
			  <input type="text" name="nickname" id="nickname"
			         class="form-control input-large"
			         maxlength="15"
			         placeholder="한글/영문/숫자 조합, 최대 15자"
			         required />
			  <small class="form-text text-muted">
			    한글, 영문, 숫자만 입력 가능하며 최대 15자까지 입력할 수 있습니다.
			  </small>
			</div>
			
            <!-- 연락처 -->
			<div class="form-group">
			  <label for="phone1">연락처<span class="text-danger"> *</span></label>
			  <div class="d-flex align-items-center flex-wrap">
			    <!-- 지역번호 / 통신사 드롭박스 -->
				<select id="phone1" name="phone1" class="form-control mr-2 text-center" style="width: 15%;" required>
				  <!-- 휴대폰 번호 -->
				  <option value="010">010</option>
				  <option value="011">011</option>
				  <option value="016">016</option>
				  <option value="017">017</option>
				  <option value="018">018</option>
				  <option value="019">019</option>
				
				  <!-- 지역번호 -->
				  <option value="02">02 (서울)</option>
				  <option value="031">031 (경기)</option>
				  <option value="032">032 (인천)</option>
				  <option value="033">033 (강원)</option>
				  <option value="041">041 (충남)</option>
				  <option value="042">042 (대전)</option>
				  <option value="043">043 (충북)</option>
				  <option value="044">044 (세종)</option>
				  <option value="051">051 (부산)</option>
				  <option value="052">052 (울산)</option>
				  <option value="053">053 (대구)</option>
				  <option value="054">054 (경북)</option>
				  <option value="055">055 (경남)</option>
				  <option value="061">061 (전남)</option>
				  <option value="062">062 (광주)</option>
				  <option value="063">063 (전북)</option>
				  <option value="064">064 (제주)</option>
				
				  <!-- 인터넷전화 -->
				  <option value="070">070 (인터넷전화)</option>
				
				  <!-- 직접입력 -->
				  <option value="custom">직접입력</option>
				</select>

			    <span>-</span>
			    <input type="text" id="phone2" name="phone2" class="form-control mx-2 text-center" maxlength="4" style="width: 20%;" required />
			    <span>-</span>
			    <input type="text" id="phone3" name="phone3" class="form-control ml-2 text-center" maxlength="4" style="width: 20%;" required />
			  </div>
			
			  <!-- 직접입력용 -->
			  <div id="custom_phone_wrap" class="mt-2" style="display: none;">
			    <input type="text" id="custom_phone" name="custom_phone" class="form-control" placeholder="+82-10-1234-5678 형식 가능 (하이픈은 무시됩니다)">
			  </div>
			
			  <small class="form-text text-muted">※ 숫자만 입력하세요. "-"는 자동으로 제외됩니다.</small>
			</div>
			
			<!-- 이메일 -->
			<div class="form-group">
			  <label for="email_prefix">이메일<span class="text-danger"> *</span></label>
			  <div class="d-flex align-items-center">
			    <!-- 이메일 앞부분 -->
			    <input type="text" id="email_prefix" class="form-control mr-1" placeholder="아이디" style="width: 30%;" required>
			    
			    <span class="mx-1">@</span>
			
			    <!-- 도메인 선택 -->
			    <select id="email_domain" class="form-control mr-1" style="width: 30%;" onchange="handleDomainChange()" required>
			      <option value="">선택</option>
			      <option value="gmail.com">gmail.com</option>
			      <option value="naver.com">naver.com</option>
			      <option value="daum.net">daum.net</option>
			      <option value="hanmail.net">hanmail.net</option>
			      <option value="nate.com">nate.com</option>
			      <option value="kakao.com">kakao.com</option>
			      <option value="etc">직접입력</option>
			    </select>
			
			    <!-- 이메일 인증 버튼 -->
			    <button type="button" class="btn btn-outline-secondary" onclick="checkEmail()" style="white-space: nowrap;">이메일 인증</button>
			  </div>
			
			  <!-- 직접입력 도메인 -->
			  <input type="text" id="email_domain_custom" class="form-control mt-2" placeholder="직접 도메인 입력" style="display: none; width: 50%;" />
			
			  <!-- 메시지 -->
			  <small id="emailMessage" class="form-text"></small>
			</div>

			<!-- 주소입력 -->
			<div class="form-group">
			  <label for="address">주소</label>
			  
			  <!-- 우편번호 + 주소검색 버튼 -->
			  <div class="d-flex mb-2">
			    <input type="text" id="zipcode" name="zipcode" class="form-control mr-2" placeholder="우편번호" readonly style="width: 50%;">
			    <button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">주소검색</button>
			  </div>
			  
			  <!-- 기본주소 -->
			  <input type="text" id="address" name="address" class="form-control mb-2" placeholder="기본주소" readonly>
			  
			  <!-- 상세주소 -->
			  <label for="address_detail">상세주소<span class="text-muted"> (선택)</span></label>
			  <input type="text" id="address_detail" name="address_detail" class="form-control" placeholder="나머지 주소 (선택 입력 가능)">
			</div>


          </div>
          <div class="form-group mt-3">
            <button type="submit" class="btn btn-primary w-100">회원가입</button>
            <button type="button" class="btn btn-secondary w-100 mt-2" onclick="window.close();">취소</button>
          </div>
        </form>
        <div class="already_member_box text-center">
          <p onclick="moveToLogin()">이미 회원이신가요? 로그인하기</p>
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

  function moveToLogin() {
    document.getElementById("signup").style.display = "none";
    document.getElementById("login").style.display = "block";
  }

  function redirectToRegister(e) {
    e.preventDefault();
    const name = document.getElementById("name")?.value || '';
    const email = document.getElementById("signup_email")?.value || '';
    window.opener.location.href = '/fitralpark/register.do?name=' + encodeURIComponent(name) + '&email=' + encodeURIComponent(email);
    window.close();
  }
  
  // 아이디 중복검사 알림
	function checkDuplicateId() {
	  const id = document.getElementById("signup_id").value.trim();
	  const message = document.getElementById("idCheckMessage");
	
	  const idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{4,16}$/;
	
	  if (!idRegex.test(id)) {
	    message.innerText = "아이디는 영문 소문자와 숫자를 모두 포함한 4~16자여야 합니다.";
	    message.style.color = "red";
	    return;
	  }
	
	  // 중복 체크 로직 (예시)
	  const isDuplicate = false;
	
	  if (isDuplicate) {
	    message.innerText = "이미 사용 중인 아이디입니다.";
	    message.style.color = "red";
	  } else {
	    message.innerText = "사용 가능한 아이디입니다.";
	    message.style.color = "green";
	  }
	}

	document.addEventListener("DOMContentLoaded", function () {
		  const pwInput = document.getElementById("signup_password");
		  const pwConfirm = document.getElementById("cpass");
		  const pwMessage = document.getElementById("pwValidationMessage");
		  const pwMatchMessage = document.getElementById("pwMatchMessage");

		  function validatePasswordFormat(password) {
		    const lengthValid = password.length >= 8 && password.length <= 16;
		    const patterns = [
		      /[A-Z]/,  // 대문자
		      /[a-z]/,  // 소문자
		      /[0-9]/,  // 숫자
		      /[!@#$%^&*(),.?":{}|<>]/  // 특수문자
		    ];
		    const matched = patterns.filter(p => p.test(password)).length;
		    return lengthValid && matched >= 2;
		  }

		  pwInput.addEventListener("input", () => {
		    if (validatePasswordFormat(pwInput.value)) {
		      pwMessage.innerText = "사용 가능한 비밀번호입니다.";
		      pwMessage.style.color = "green";
		    } else {
		      pwMessage.innerText = "8~16자, 영문 대소문자/숫자/특수문자 중 2종 이상 조합 필요";
		      pwMessage.style.color = "red";
		    }

		    // 비밀번호 확인과 일치 여부도 동시에 확인
		    if (pwConfirm.value !== "") {
		      if (pwInput.value === pwConfirm.value) {
		        pwMatchMessage.innerText = "비밀번호가 일치합니다.";
		        pwMatchMessage.style.color = "green";
		      } else {
		        pwMatchMessage.innerText = "비밀번호가 일치하지 않습니다.";
		        pwMatchMessage.style.color = "red";
		      }
		    }
		  });

		  pwConfirm.addEventListener("input", () => {
		    if (pwInput.value === pwConfirm.value) {
		      pwMatchMessage.innerText = "비밀번호가 일치합니다.";
		      pwMatchMessage.style.color = "green";
		    } else {
		      pwMatchMessage.innerText = "비밀번호가 일치하지 않습니다.";
		      pwMatchMessage.style.color = "red";
		    }
		  });
		});


  // 👁️ 비밀번호 보기 토글
  document.addEventListener("DOMContentLoaded", function () {
    const eyeLogin = document.getElementById("eye_icon_login");
    const pwLogin = document.getElementById("login_password");

    const eyeSignup = document.getElementById("eye_icon_signup");
    const pwSignup = document.getElementById("signup_password");

    if (eyeLogin && pwLogin) {
      eyeLogin.addEventListener("click", function () {
        const isVisible = pwLogin.type === "text";
        pwLogin.type = isVisible ? "password" : "text";
        this.classList.toggle("fa-eye");
        this.classList.toggle("fa-eye-slash");
      });
    }

    if (eyeSignup && pwSignup) {
      eyeSignup.addEventListener("click", function () {
        const isVisible = pwSignup.type === "text";
        pwSignup.type = isVisible ? "password" : "text";
        this.classList.toggle("fa-eye");
        this.classList.toggle("fa-eye-slash");
      });
    }
  });
  
  //주민등록번호
  document.addEventListener("DOMContentLoaded", function () {
	  const jumin1 = document.getElementById("jumin1");
	  const jumin2_first = document.getElementById("jumin2_first");
	  const jumin2_rest = document.getElementById("jumin2_rest");

	  // 숫자만 입력되도록 처리
	  [jumin1, jumin2_first, jumin2_rest].forEach(input => {
	    input.addEventListener("input", function () {
	      this.value = this.value.replace(/[^0-9]/g, '');
	    });
	  });

	  // 자동 포커스 이동
	  jumin1.addEventListener("input", function () {
	    if (this.value.length === 6) {
	      jumin2_first.focus();
	    }
	  });

	  jumin2_first.addEventListener("input", function () {
	    if (this.value.length === 1) {
	      jumin2_rest.focus();
	    }
	  });
	});
  
  // 닉네임 유효성 검사
  document.addEventListener("DOMContentLoaded", function () {
    const nicknameInput = document.getElementById("nickname");
    nicknameInput.addEventListener("input", function () {
      // 한글, 영문, 숫자만 허용
      this.value = this.value.replace(/[^가-힣a-zA-Z0-9]/g, '');
    });
  });
  
  //이메일
  function handleDomainChange() {
	  const domainSelect = document.getElementById("email_domain");
	  const customDomain = document.getElementById("email_domain_custom");

	  if (domainSelect.value === "etc") {
	    customDomain.style.display = "block";
	    customDomain.value = "";
	    customDomain.focus();
	  } else {
	    customDomain.style.display = "none";
	  }
	}

	function checkEmail() {
	  const prefix = document.getElementById("email_prefix").value.trim();
	  const domainSelect = document.getElementById("email_domain").value;
	  const customDomain = document.getElementById("email_domain_custom").value.trim();
	  const emailMessage = document.getElementById("emailMessage");

	  const domain = domainSelect === "etc" ? customDomain : domainSelect;
	  const fullEmail = `${prefix}@${domain}`;
	  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

	  if (!prefix || !domain) {
	    emailMessage.innerText = "이메일을 모두 입력해주세요.";
	    emailMessage.style.color = "red";
	    return;
	  }

	  if (!emailRegex.test(fullEmail)) {
	    emailMessage.innerText = "올바른 이메일 형식이 아닙니다.";
	    emailMessage.style.color = "red";
	    return;
	  }

	  // 인증 성공 메시지
	  emailMessage.innerText = "이메일 형식이 올바릅니다. 인증 메일을 전송했습니다.";
	  emailMessage.style.color = "green";

	  // 나중에 AJAX 요청으로 인증코드 전송 추가 가능
	}
	
	document.addEventListener("DOMContentLoaded", function () {
	  const phoneInputs = [document.getElementById("phone2"), document.getElementById("phone3")];

	  phoneInputs.forEach(input => {
	    input.addEventListener("input", function () {
	      this.value = this.value.replace(/[^0-9]/g, '');
	    });
	  });
	});
	
	// 연락처
	document.addEventListener("DOMContentLoaded", function () {
	  const phone1 = document.getElementById("phone1");
	  const phone2 = document.getElementById("phone2");
	  const phone3 = document.getElementById("phone3");
	  const customPhoneWrap = document.getElementById("custom_phone_wrap");
	  const customPhone = document.getElementById("custom_phone");
	
	  // 드롭박스 값 변경 시 처리
	  phone1.addEventListener("change", function () {
	    if (this.value === "custom") {
	      phone2.disabled = true;
	      phone3.disabled = true;
	      phone2.value = "";
	      phone3.value = "";
	      customPhoneWrap.style.display = "block";
	      customPhone.focus();
	    } else {
	      phone2.disabled = false;
	      phone3.disabled = false;
	      customPhoneWrap.style.display = "none";
	      customPhone.value = "";
	    }
	  });
	
	  // 숫자만 입력되도록 (phone2, phone3)
	  [phone2, phone3].forEach(input => {
	    input.addEventListener("input", function () {
	      this.value = this.value.replace(/[^0-9]/g, '');
	    });
	  });
	
	  // phone2 입력 시 자동 포커스 이동
	  phone2.addEventListener("input", function () {
	    if (this.value.length === 4) {
	      phone3.focus();
	    }
	  });
	
	  // customPhone에서 하이픈(-) 자동 제거
	  customPhone.addEventListener("input", function () {
	    this.value = this.value.replace(/-/g, '');
	  });
	});
	


</script>
<!-- DAUM주소 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      document.getElementById('zipcode').value = data.zonecode;
      document.getElementById('address').value = data.roadAddress || data.jibunAddress;
      document.getElementById('address_detail').focus();
    }
  }).open();
}
</script>


</body>
</html>
