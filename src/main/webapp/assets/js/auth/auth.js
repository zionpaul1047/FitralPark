// contextPath 선언 필요: <script>const contextPath = "${pageContext.request.contextPath}";</script>

let isIdChecked = false;
let lastCheckedId = "";

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
	const prefix = document.getElementById("email_prefix")?.value || '';
	const domainSelect = document.getElementById("email_domain")?.value || '';
	const domainCustom = document.getElementById("email_domain_custom")?.value || '';
	const domain = domainSelect === 'etc' ? domainCustom : domainSelect;
	const email = domain ? `${prefix}@${domain}` : '';
	window.opener.location.href = contextPath + '/register.do?name=' + encodeURIComponent(name) + '&email=' + encodeURIComponent(email);
	window.close();
}

function checkDuplicateId() {
	const id = document.getElementById("signup_id").value.trim();
	const message = document.getElementById("idCheckMessage");
	const idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{4,16}$/;

	if (!idRegex.test(id)) {
		message.innerText = "아이디는 영문 소문자와 숫자를 모두 포함한 4~16자여야 합니다.";
		message.style.color = "red";
		isIdChecked = false;
		return;
	}

	// 서버에 AJAX로 중복 확인 요청
	fetch(`${contextPath}/checkId.do?id=${encodeURIComponent(id)}`)
		.then(res => res.json())
		.then(data => {
			if (data.exists) {
				message.innerText = "이미 사용 중인 아이디입니다.";
				message.style.color = "red";
				isIdChecked = false;
			} else {
				message.innerText = "사용 가능한 아이디입니다.";
				message.style.color = "green";
				isIdChecked = true;
				lastCheckedId = id;
			}
		})
		.catch(err => {
			console.error("아이디 중복 확인 오류:", err);
			message.innerText = "서버 오류가 발생했습니다.";
			message.style.color = "red";
			isIdChecked = false;
		});
}


window.addEventListener("DOMContentLoaded", function() {
	const pwInput = document.getElementById("signup_password");
	const pwConfirm = document.getElementById("cpass");
	const pwMessage = document.getElementById("pwValidationMessage");
	const pwMatchMessage = document.getElementById("pwMatchMessage");

	const signupForm = document.querySelector("form[action$='/register.do']");
	if (signupForm) {
		signupForm.addEventListener("submit", function(e) {
			if (!isIdChecked) {
				e.preventDefault();
				const msg = document.getElementById("idCheckMessage");
				msg.innerText = "아이디 중복확인을 먼저 해주세요.";
				msg.style.color = "red";
				document.getElementById("signup_id").focus();
				setTimeout(() => {
					document.querySelector("button[onclick='checkDuplicateId()']")?.focus();
				}, 300);
			}
		});
	}

	const idInput = document.getElementById("signup_id");
	const idMessage = document.getElementById("idCheckMessage");
	if (idInput && idMessage) {
		idInput.addEventListener("input", () => {
			const currentId = idInput.value.trim();
			if (currentId !== lastCheckedId) {
				isIdChecked = false;
				idMessage.innerText = "아이디 중복확인을 다시 해주세요.";
				idMessage.style.color = "orange";
			} else if (isIdChecked) {
				idMessage.innerText = "사용 가능한 아이디입니다.";
				idMessage.style.color = "green";
			}
		});
	}

	if (pwInput && pwConfirm) {
		function validatePasswordFormat(password) {
			const lengthValid = password.length >= 8 && password.length <= 16;
			const patterns = [/[A-Z]/, /[a-z]/, /[0-9]/, /[!@#$%^&*(),.?":{}|<>]/];
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
			if (pwConfirm.value !== "") {
				pwMatchMessage.innerText = pwInput.value === pwConfirm.value ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다.";
				pwMatchMessage.style.color = pwInput.value === pwConfirm.value ? "green" : "red";
			}
		});

		pwConfirm.addEventListener("input", () => {
			pwMatchMessage.innerText = pwInput.value === pwConfirm.value ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다.";
			pwMatchMessage.style.color = pwInput.value === pwConfirm.value ? "green" : "red";
		});
	}

	// 👁️ 비밀번호 보기 토글
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

	// 주민등록번호 처리
	["jumin1", "jumin2_first", "jumin2_rest"].forEach(id => {
		const input = document.getElementById(id);
		if (input) {
			input.addEventListener("input", function() {
				this.value = this.value.replace(/[^0-9]/g, '');
			});
		}
	});
	const jumin1 = document.getElementById("jumin1");
	const jumin2_first = document.getElementById("jumin2_first");
	jumin1?.addEventListener("input", function() {
		if (this.value.length === 6) jumin2_first?.focus();
	});
	jumin2_first?.addEventListener("input", function() {
		if (this.value.length === 1) document.getElementById("jumin2_rest")?.focus();
	});

	// 닉네임 유효성 검사
	document.getElementById("nickname")?.addEventListener("input", function() {
		this.value = this.value.replace(/[^가-힣a-zA-Z0-9]/g, '');
	});

	// 이메일 도메인 처리
	document.getElementById("email_domain")?.addEventListener("change", function() {
		const customDomain = document.getElementById("email_domain_custom");
		if (this.value === "etc") {
			customDomain.style.display = "block";
			customDomain.value = "";
			customDomain.focus();
		} else {
			customDomain.style.display = "none";
		}
	});

	// 이메일 인증 검사 (단순 포맷 확인)
	document.getElementById("emailCheckBtn")?.addEventListener("click", function() {
		const prefix = document.getElementById("email_prefix").value.trim();
		const domain = document.getElementById("email_domain").value;
		const custom = document.getElementById("email_domain_custom").value.trim();
		const fullDomain = domain === "etc" ? custom : domain;
		const email = `${prefix}@${fullDomain}`;
		const emailMsg = document.getElementById("emailMessage");
		const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

		if (!prefix || !fullDomain) {
			emailMsg.innerText = "이메일을 모두 입력해주세요.";
			emailMsg.style.color = "red";
		} else if (!regex.test(email)) {
			emailMsg.innerText = "올바른 이메일 형식이 아닙니다.";
			emailMsg.style.color = "red";
		} else {
			emailMsg.innerText = "이메일 형식이 올바릅니다. 인증 메일을 전송했습니다.";
			emailMsg.style.color = "green";
			// TODO: 이메일 인증번호 요청 추가
		}
	});

	// 연락처 처리
	["phone2", "phone3"].forEach(id => {
		document.getElementById(id)?.addEventListener("input", function() {
			this.value = this.value.replace(/[^0-9]/g, '');
		});
	});

	document.getElementById("phone2")?.addEventListener("input", function() {
		if (this.value.length === 4) document.getElementById("phone3")?.focus();
	});

	document.getElementById("phone1")?.addEventListener("change", function() {
		const isCustom = this.value === "custom";
		document.getElementById("phone2").disabled = isCustom;
		document.getElementById("phone3").disabled = isCustom;
		document.getElementById("custom_phone_wrap").style.display = isCustom ? "block" : "none";
		if (isCustom) document.getElementById("custom_phone").focus();
	});
	document.getElementById("custom_phone")?.addEventListener("input", function() {
		let val = this.value.replace(/[^0-9+]/g, '');
		if (val.indexOf('+') > 0) val = val.replace(/\+/g, '');
		this.value = val;
	});
});
