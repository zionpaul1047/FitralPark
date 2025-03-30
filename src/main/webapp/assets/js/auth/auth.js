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

document.addEventListener("DOMContentLoaded", function() {
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
document.addEventListener("DOMContentLoaded", function() {
	const eyeLogin = document.getElementById("eye_icon_login");
	const pwLogin = document.getElementById("login_password");

	const eyeSignup = document.getElementById("eye_icon_signup");
	const pwSignup = document.getElementById("signup_password");

	if (eyeLogin && pwLogin) {
		eyeLogin.addEventListener("click", function() {
			const isVisible = pwLogin.type === "text";
			pwLogin.type = isVisible ? "password" : "text";
			this.classList.toggle("fa-eye");
			this.classList.toggle("fa-eye-slash");
		});
	}

	if (eyeSignup && pwSignup) {
		eyeSignup.addEventListener("click", function() {
			const isVisible = pwSignup.type === "text";
			pwSignup.type = isVisible ? "password" : "text";
			this.classList.toggle("fa-eye");
			this.classList.toggle("fa-eye-slash");
		});
	}
});

//주민등록번호
document.addEventListener("DOMContentLoaded", function() {
	const jumin1 = document.getElementById("jumin1");
	const jumin2_first = document.getElementById("jumin2_first");
	const jumin2_rest = document.getElementById("jumin2_rest");

	// 숫자만 입력되도록 처리
	[jumin1, jumin2_first, jumin2_rest].forEach(input => {
		input.addEventListener("input", function() {
			this.value = this.value.replace(/[^0-9]/g, '');
		});
	});

	// 자동 포커스 이동
	jumin1.addEventListener("input", function() {
		if (this.value.length === 6) {
			jumin2_first.focus();
		}
	});

	jumin2_first.addEventListener("input", function() {
		if (this.value.length === 1) {
			jumin2_rest.focus();
		}
	});
});

// 닉네임 유효성 검사
document.addEventListener("DOMContentLoaded", function() {
	const nicknameInput = document.getElementById("nickname");
	nicknameInput.addEventListener("input", function() {
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

document.addEventListener("DOMContentLoaded", function() {
	const phoneInputs = [document.getElementById("phone2"), document.getElementById("phone3")];

	phoneInputs.forEach(input => {
		input.addEventListener("input", function() {
			this.value = this.value.replace(/[^0-9]/g, '');
		});
	});
});

// 연락처
document.addEventListener("DOMContentLoaded", function() {
	const phone1 = document.getElementById("phone1");
	const phone2 = document.getElementById("phone2");
	const phone3 = document.getElementById("phone3");
	const customPhoneWrap = document.getElementById("custom_phone_wrap");
	const customPhone = document.getElementById("custom_phone");

	// 드롭박스 값 변경 시 처리
	phone1.addEventListener("change", function() {
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
		input.addEventListener("input", function() {
			this.value = this.value.replace(/[^0-9]/g, '');
		});
	});

	// phone2 입력 시 자동 포커스 이동
	phone2.addEventListener("input", function() {
		if (this.value.length === 4) {
			phone3.focus();
		}
	});

	// customPhone에서 하이픈(-) 자동 제거
	customPhone.addEventListener("input", function() {
		this.value = this.value.replace(/-/g, '');
	});
});


