let isIdChecked = false;
let lastCheckedId = "";

window.moveToRegister = function () {
	switchForm("signup");
};

window.moveToLogin = function () {
	switchForm("login");
};

window.switchForm = function (formIdToShow) {
	const forms = document.querySelectorAll(".accounts_forms");
	forms.forEach((form) => {
		form.style.display = "none";
	});
	document.getElementById(formIdToShow).style.display = "block";
};


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
				idMessage.innerText = "아이디 중복확인을 해주세요.";
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
	const jumin2Msg = document.getElementById("jumin2Message");

	jumin1?.addEventListener("input", function() {
		if (this.value.length === 6) jumin2_first?.focus();
	});

	jumin2_first?.addEventListener("input", function() {
		if (this.value.length === 1) {
			if (!["1", "2", "3", "4"].includes(this.value)) {
				jumin2Msg.innerText = "주민등록번호 형식이 맞지 않습니다.";
				jumin2Msg.style.color = "red";
			} else {
				jumin2Msg.innerText = "";
				document.getElementById("jumin2_rest")?.focus();
			}
		}
	});


	// 닉네임 유효성 검사
	/*	document.getElementById("nickname")?.addEventListener("blur", function() {
			this.value = this.value.replace(/[^가-힣a-zA-Z0-9]/g, '');
		});*/
	const nicknameInput = document.getElementById("nickname");
	const nicknameMessage = document.getElementById("nicknameMessage");

	nicknameInput?.addEventListener("blur", function() {
		const value = this.value.trim();
		const isValid = /^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{2,15}$/.test(value); // 2~15자, 허용 문자만

		if (!isValid) {
			nicknameMessage.textContent = "닉네임은 한글(완성형, 자모음 단독사용 불가), 영문, 숫자만 가능하며 2~15자 이내여야 합니다.";
		} else {
			nicknameMessage.textContent = "";
		}
	});

	document.querySelector("form[action$='register.do']")?.addEventListener("submit", function(e) {
		const value = nicknameInput.value.trim();
		const isValid = /^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{2,15}$/.test(value);

		if (!isValid) {
			e.preventDefault();
			nicknameMessage.textContent = "닉네임은 한글, 영문, 숫자만 가능하며 2~15자 이내여야 합니다.";
			nicknameInput.focus();
		}
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


	// 이메일 인증 기능
	window.isEmailVerified = false;
	const emailAuthBtn = document.getElementById("emailAuthBtn");
	const authCodeInput = document.getElementById("authCode");
	const authCodeWrap = document.getElementById("authCodeWrap");
	const authCodeMsg = document.getElementById("authCodeMessage");
	const bulletView = document.getElementById("authCodeBullets");
	const authTimer = document.getElementById("authTimer");
	const authCodeCheckBtn = document.getElementById("authCodeCheckBtn");

	let resendCooldown = 10;  // 재요청 제한 시간 10초
	let authValidTime = 300;  // 인증번호 유효 시간 5분

	let resendInterval = null;
	let authTimerInterval = null;

	// 인증번호 확인 함수
	function validateAuthCode() {
		const inputCode = authCodeInput.value.trim();

		// 서버에 POST 요청
		fetch(`${contextPath}/checkAuthCode.do`, {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded"
			},
			body: `code=${encodeURIComponent(inputCode)}`
		})
			.then(res => res.json())
			.then(data => {
				if (data.match) {
					authCodeMsg.innerText = "인증에 성공했습니다.";
					authCodeMsg.style.color = "green";
					window.isEmailVerified = true;

					// UI 잠금 처리
					document.getElementById("email_prefix").readOnly = true;
					document.getElementById("email_domain").disabled = true;
					document.getElementById("email_domain_custom").readOnly = true;
					emailAuthBtn.innerText = "인증완료";
					emailAuthBtn.disabled = true;
					authCodeCheckBtn.disabled = true;
					clearInterval(authTimerInterval);
					authTimer.innerText = "";
				} else {
					authCodeMsg.innerText = "인증번호가 일치하지 않거나 만료되었습니다.";
					authCodeMsg.style.color = "red";
				}
			})
			.catch(err => {
				console.error("인증번호 검증 오류:", err);
				authCodeMsg.innerText = "서버 오류가 발생했습니다.";
				authCodeMsg.style.color = "red";
			});
	}


	// 인증 버튼 클릭 (서버로 인증요청하여 처리)
	emailAuthBtn?.addEventListener("click", () => {
		const prefix = document.getElementById("email_prefix").value.trim();
		const domainSel = document.getElementById("email_domain").value;
		const custom = document.getElementById("email_domain_custom").value.trim();
		const domain = domainSel === "etc" ? custom : domainSel;
		const email = `${prefix}@${domain}`;
		const emailMessage = document.getElementById("emailMessage");
		const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

		const hiddenInput = document.getElementById("email_hidden");
		if (hiddenInput) hiddenInput.value = email;

		if (!prefix || !domain) {
			emailMessage.innerText = "이메일을 모두 입력해주세요.";
			emailMessage.style.color = "red";
			return;
		}
		if (!regex.test(email)) {
			emailMessage.innerText = "올바른 이메일 형식이 아닙니다.";
			emailMessage.style.color = "red";
			return;
		}

		// 서버에 인증 메일 요청
		fetch(`${contextPath}/sendAuthEmail.do?email=${encodeURIComponent(email)}`)
			.then(res => res.json())
			.then(data => {
				if (data.success) {
					authCodeWrap.style.display = "block";
					authCodeInput.value = "";
					authCodeMsg.innerText = "";
					authCodeInput.focus();
					emailMessage.innerText = "인증번호가 이메일로 전송되었습니다.";
					emailMessage.style.color = "green";

					// 타이머 설정
					let timeLeft = authValidTime;
					clearInterval(authTimerInterval);
					authTimerInterval = setInterval(() => {
						const min = Math.floor(timeLeft / 60);
						const sec = timeLeft % 60;
						authTimer.innerText = `남은 시간: ${min}분 ${sec < 10 ? '0' + sec : sec}초`;
						timeLeft--;
						if (timeLeft < 0) {
							clearInterval(authTimerInterval);
							authTimer.inneraText = "인증 시간이 만료되었습니다.";
						}
					}, 1000);

					// 재요청 버튼 타이머
					emailAuthBtn.disabled = true;
					let cooldown = resendCooldown;
					emailAuthBtn.innerText = `${cooldown--}초 후 재요청`;
					clearInterval(resendInterval);
					resendInterval = setInterval(() => {
						emailAuthBtn.innerText = `${cooldown--}초 후 재요청`;
						if (cooldown < 0) {
							clearInterval(resendInterval);
							emailAuthBtn.disabled = false;
							emailAuthBtn.innerText = "인증번호 재발송";
						}
					}, 1000);
				} else {
					emailMessage.innerText = "이메일 전송에 실패했습니다.";
					emailMessage.style.color = "red";
				}
			})
			.catch(err => {
				console.error("인증 요청 실패:", err);
				emailMessage.innerText = "서버 오류가 발생했습니다.";
				emailMessage.style.color = "red";
			});
	});


	// 인증번호 Enter 지원
	authCodeInput?.addEventListener("keyup", (e) => {
		if (e.key === "Enter") validateAuthCode();
	});

	// "확인" 버튼 클릭
	authCodeCheckBtn?.addEventListener("click", validateAuthCode);


	// 회원가입 버튼 제출 시 이메일 인증 여부 체크
	window.addEventListener("DOMContentLoaded", function() {
		const signupForm = document.querySelector("form[action$='/register.do']");
		if (signupForm) {
			signupForm.addEventListener("submit", function(e) {
				if (!isIdChecked) {
					e.preventDefault();
					document.getElementById("idCheckMessage").innerText = "아이디 중복확인을 먼저 해주세요.";
					document.getElementById("idCheckMessage").style.color = "red";
					document.getElementById("signup_id").focus();
					return;
				}

				if (!window.isEmailVerified) {
					e.preventDefault();
					document.getElementById("authCodeMessage").innerText = "이메일 인증을 먼저 완료해주세요.";
					document.getElementById("authCode").focus();
					return;
				}

				// 이메일 hidden 필드 세팅
				const prefix = document.getElementById("email_prefix").value.trim();
				const domainSel = document.getElementById("email_domain").value;
				const custom = document.getElementById("email_domain_custom").value.trim();
				const domain = domainSel === "etc" ? custom : domainSel;
				const email = `${prefix}@${domain}`;
				const hiddenInput = document.getElementById("email_hidden");
				if (hiddenInput) hiddenInput.value = email;
			});


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


/*아이디 찾기 비밀번호 찾기*/

document.addEventListener("DOMContentLoaded", function () {
  // 아이디 찾기 버튼 클릭
  document.getElementById("findID").addEventListener("click", function () {
    switchForm("find-id");
  });

  // 비밀번호 찾기 버튼 클릭
  document.getElementById("findPw").addEventListener("click", function () {
    switchForm("find-pw");
  });
});

function switchForm(formIdToShow) {
  const forms = document.querySelectorAll(".accounts_forms");
  forms.forEach((form) => {
    form.style.display = "none";
  });
  document.getElementById(formIdToShow).style.display = "block";
}

//비밀번호 재설정 인증번호 클릭 이벤트
// ?비밀번호 찾기 - 인증번호 전송
document.getElementById("sendPwAuthBtn")?.addEventListener("click", function () {
	const id = document.getElementById("find_pw_id").value.trim();
	const name = document.getElementById("find_pw_name").value.trim();
	const email = document.getElementById("find_pw_email").value.trim();

	if (!id || !name || !email) {
		alert("아이디, 이름, 이메일을 모두 입력해주세요.");
		return;
	}

	fetch(`${contextPath}/find-pw.do`, {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: `id=${encodeURIComponent(id)}&name=${encodeURIComponent(name)}&email=${encodeURIComponent(email)}`
	})
	.then(res => res.json())
	.then(data => {
		if (data.success) {
			alert("인증번호가 이메일로 전송되었습니다.");
			document.getElementById("pwAuthCodeWrap").style.display = "block";
			document.getElementById("pwAuthCodeInput").focus();
		} else {
			alert("입력하신 정보와 일치하는 계정이 없습니다.");
		}
	})
	.catch(err => {
		alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	});
});




// ?비밀번호 찾기 - 인증번호 확인
document.getElementById("pwAuthCodeCheckBtn")?.addEventListener("click", function () {
	const inputCode = document.getElementById("pwAuthCodeInput").value.trim();
	const messageEl = document.getElementById("pwAuthCodeMessage");

	if (!inputCode) {
		messageEl.textContent = "인증번호를 입력해주세요.";
		messageEl.style.color = "red";
		return;
	}

	// 서버에 인증번호 검증 요청
	fetch(`${contextPath}/verify-auth-code.do`, {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: `authCode=${encodeURIComponent(inputCode)}`
	})
	.then(res => res.json())
	.then(data => {
		if (data.result === "OK") {
			messageEl.style.color = "green";
			messageEl.textContent = "인증이 완료되었습니다.";

			setTimeout(() => {
				document.querySelector(".find_pw_form").style.display = "none";
				document.querySelector(".reset_pw_form").style.display = "block";
			}, 1000);
		} else {
			messageEl.style.color = "red";
			messageEl.textContent = "인증번호가 일치하지 않거나 만료되었습니다.";
		}
	})
	.catch(error => {
		console.error("비밀번호 인증번호 확인 오류:", error);
		messageEl.textContent = "인증 중 문제가 발생했습니다.";
		messageEl.style.color = "red";
	});
});

document.getElementById("resetPwForm")?.addEventListener("submit", function (e) {
	e.preventDefault();

	const newPw = document.getElementById("newPw").value.trim();
	const confirmPw = document.getElementById("confirmPw").value.trim();

	if (newPw !== confirmPw) {
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	if (newPw.length < 8 || newPw.length > 16) {
		alert("비밀번호는 8~16자여야 합니다.");
		return;
	}

	fetch(`${contextPath}/reset-pw.do`, {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: `newPassword=${encodeURIComponent(newPw)}`
	})
	.then(res => res.json())
	.then(data => {
		if (data.success) {
			alert("비밀번호가 성공적으로 변경되었습니다.");
			switchForm("login"); // 로그인 화면으로 전환
		} else {
			alert(data.message || "비밀번호 변경에 실패했습니다.");
		}
	})
	.catch(err => {
		alert("서버 오류가 발생했습니다.");
		console.error("비밀번호 변경 오류:", err);
	});
});

