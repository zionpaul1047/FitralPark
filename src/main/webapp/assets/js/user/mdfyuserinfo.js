/**
 * 
 */
//다음 주소검색 api
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                                
            } 

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('input_postcode').value = data.zonecode;
            document.getElementById('input_address').value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("input_detailAddress").focus();
            
            
        }
    }).open();
}

//기타 이벤트 설정
//각 엘리먼트 접근 변수
const user_email_prefix = document.getElementById('user_email_prefix');
const select_email_domain = document.getElementById('user_email_domain');
const email_domain_custom = document.getElementById('email_domain_custom');
const eamil_domain_select = document.getElementById('eamil_domain_select');
const pwMessage = document.getElementById("pwValidationMessage");
const pwMatchMessage = document.getElementById("pwMatchMessage");
const pwInput = document.getElementById("user_pw");
const pwConfirm = document.getElementById("user_pw_vrfy");

const user_nickname = document.getElementById('user_nickname');
const user_tel1 = document.getElementById('user_tel1');
const user_tel2 = document.getElementById('user_tel2');
const user_tel3 = document.getElementById('user_tel3');
const custom_phone = document.getElementById('custom_phone');
const tel_select = document.getElementById('tel_select');
const input_postcode = document.getElementById('input_postcode');
const input_address = document.getElementById('input_address');
const input_detailAddress = document.getElementById('input_detailAddress');
const nickMessage = document.getElementById('nickMessage');

let nick_invalid = false;
let tel_invalid = false;
let pw_invalid = false;
let email_invalid = false;

$(document).ready(function() {
	const org_nickname = user_nickname.value;
	const org_tel1 = user_tel1.value;
	const org_tel2 = user_tel2.value;
	const org_tel3 = user_tel3.value;
	const org_custom_phone = custom_phone.value;
	const org_user_email_prefix = user_email_prefix.value;
	const org_user_email_domain = select_email_domain.value;
	const org_email_domain_custom = email_domain_custom.value;
	const org_addr1 = input_postcode.value;
	const org_addr2 = input_address.value;
	const org_addr3 = input_detailAddress.value;
	
	if (select_email_domain.value == 'custom') {
		$('email_domain_custom').css('display', 'block');
	}
	if (user_tel1.value == 'custom') {
			$('#custom_phone').css('display', 'block');
		}
	if (custom_phone.value == 'custom') {
			$('email_domain_custom').css('display', 'block');
		}
		
	//회원정보 수정 버튼
	$('#mdfy_submit_btn').click(function() {
		console.log('submit click');
		
		if(user_nickname.value == org_nickname) nick_invalid = true;
		if(user_tel1.value == org_tel1
			&& user_tel2.value == org_tel2
			&& user_tel3.value == org_tel3) {
			tel_invalid = true;
		}
		if(custom_phone.value = org_custom_phone) tel_invalid = true;
		if((user_email_prefix.value == org_user_email_prefix && select_email_domain.value == org_user_email_domain)
			|| (user_email_prefix.value == org_user_email_prefix && email_domain_custom.value == org_email_domain_custom)) {
			email_invalid = true;
		}
		
		
		
		if(nick_invalid && tel_invalid && pw_invalid && email_invalid) {
			document.getElementById('member_info_form').submit();
			
		} else if(user_nickname.value == org_nickname
				&& user_tel1.value == org_tel1
				&& user_tel2.value == org_tel2
				&& user_tel3.value == org_tel3
				&& user_email_prefix.value == org_user_email_prefix
				&& select_email_domain.value == org_user_email_domain
				&& email_domain_custom.value == org_email_domain_custom
				&& input_postcode.value == org_addr1
				&& input_address.value == org_addr2
				&& input_detailAddress.value == org_addr3) {
			document.getElementById('member_info_form').submit();
			
		} else {
			//alert('첫번째 else 내부');
			if(!pw_invalid) {
				alert('비밀번호를 확인해주세요.');
				return false;
			} else if (!tel_invalid) {
				alert('연락처를 확인해주세요.');
				return false;
			} else if (!nick_invalid) {
				alert('닉네임을 확인해주세요.');
				return false;
			} else if (!email_invalid) {
				alert('이메일을 확인해주세요.');
				return false;
			}
			
			//alert('return 전');
			return false;
		}

	});

});


//이벤트 설정

//기타 이메일 도메인 창 열기 
select_email_domain.addEventListener('change', function() {
	open_domain_input(select_email_domain.value);
});

function open_domain_input(selItem) {
	if(selItem == 'custom') {
		$('#email_domain_custom').css('display', 'block');
		$('#email_domain_custom').focus();
		eamil_domain_select.value = 'custom';
	} else {
		$('#email_domain_custom').css('display', 'none');
		eamil_domain_select.value = 'default';
	}
	console.log(selItem);
}


//연락처 직접 입력 열기
user_tel1.addEventListener('change', function() {
	open_tel_input(user_tel1.value);
});

function open_tel_input(selItem) {
	if(selItem == 'custom') {
		$('#user_tel2').attr('disabled','true');
		$('#user_tel3').attr('disabled','true');
		$('#user_tel2').removeAttr('required');
		$('#user_tel3').removeAttr('required');
		
		
		$('#custom_phone').css('display', 'block');
		$('#custom_phone').attr('required', 'true');
		$('#custom_phone').focus();
		tel_select.value = 'custom';
	} else {
		
		$('#user_tel2').removeAttr('disabled');
		$('#user_tel3').removeAttr('disabled');
		$('#user_tel2').attr('required','true');
		$('#user_tel3').attr('required','true');
		
		$('#custom_phone').css('display', 'none');
		$('#custom_phone').removeAttr('required');
		tel_select.value = 'default';
	}
	console.log(selItem);
}


//비밀번호 검증
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
			pw_invalid = true;
		} else {
			pwMessage.innerText = "8~16자, 영문 대소문자/숫자/특수문자 중 2종 이상 조합 필요";
			pwMessage.style.color = "red";
			pw_invalid = false;
		}
		if (pwConfirm.value !== "") {
			pwMatchMessage.innerText = pwInput.value === pwConfirm.value ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다.";
			pwMatchMessage.style.color = pwInput.value === pwConfirm.value ? "green" : "red";
			
			if (pwInput.value === pwConfirm.value) {
				pwMatchMessage.innerText = '비밀번호가 일치합니다.';
				pwMatchMessage.style.color = 'green';
				pw_invalid = true;
			} else {
				pwMatchMessage.innerText = '비밀번호가 일치하지 않습니다.';
				pwMatchMessage.style.color = 'red';
				pw_invalid = false;
			}
			
		}
	});

	pwConfirm.addEventListener("input", () => {
		pwMatchMessage.innerText = pwInput.value === pwConfirm.value ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다.";
		pwMatchMessage.style.color = pwInput.value === pwConfirm.value ? "green" : "red";
	});
}

//닉네임 검증
let isNickComposing = false;
document.getElementById('user_nickname').addEventListener('compositionstart', function() {
	isNickComposing = true;
});
document.getElementById('user_nickname').addEventListener('compositionstart', function() {
	isNickComposing = false;
});

document.getElementById('user_nickname').addEventListener('input', function() {
	if(!isNickComposing) {
		const nick_regex = /^[가-힣a-zA-Z0-9]{1,15}$/;
		
		if(nick_regex.test(user_nickname.value)) {
			nickMessage.innerText = '닉네임 규칙이 유효합니다.';
			nickMessage.style.color = 'green';
			nick_invalid = true;
		} else {
			nick_invalid = false;
			nickMessage.innerText = '한글/영문/숫자 조합, 최대 15자';
			nickMessage.style.color = 'red';
		}
	}
	
	
});

//연락처 검증
document.getElementById('user_tel2').addEventListener('input', function() {
	const tel2_regex = /^[0-9]{3,4}$/;
	const tel3_regex = /^[0-9]{4}$/;
	this.value = this.value.replace(/[^0-9]/g, '');
	
	if(tel2_regex.test(user_tel2.value)) {
		tel_invalid = true;
		
		if(tel3_regex.test(user_tel3.value)) {
				tel_invalid = true;
		} else {
			tel_invalid = false;
		}
	} else {
		tel_invalid = false;
	}
	
	console.log('user_tel2', user_tel2.value);
	console.log('user_tel3',user_tel3.value);
	console.log('tel_invalid', tel_invalid);
	
});

document.getElementById('user_tel3').addEventListener('input', function() {
	const tel2_regex = /[0-9]{3,4}/;
	const tel3_regex = /[0-9]{4}/;
	this.value = this.value.replace(/[^0-9]/g, '');
	
	
	if(tel3_regex.test(user_tel3.value)) {
		tel_invalid = true;
		if(tel2_regex.test(user_tel2.value)) {
			tel_invalid = true;
		} else {
			tel_invalid = false;
		}
			
	} else {
		tel_invalid = false;
	}
	console.log('user_tel2', user_tel2.value);
	console.log('user_tel3',user_tel3.value);
	console.log('tel_invalid', tel_invalid);
	
});


//연락처 직접입력 유효성검사
custom_phone.addEventListener('input', function() {
	const custom_tel_regex = /^\+?[0-9]{10,20}$/;
	
	if(custom_tel_regex.test(custom_phone.value)) {
		tel_invalid = true;
		$('#custom_phone_message').text('닉네임 규칙이 유효합니다.');
		$('#custom_phone_message').css('color','blue');
			
	} else {
		$('#custom_phone_message').text('+821012345678과 같이 입력해주세요.');
		$('#custom_phone_message').css('color','red');
		tel_invalid = false;
	}
	
});




//이메일 전송 이벤트
const emailAuthBtn = document.getElementById("emailAuthBtn");
const authCodeInput = document.getElementById("authCode");
const authCodeWrap = document.getElementById("authCodeWrap");
const authCodeMsg = document.getElementById("authCodeMessage");
const authTimer = document.getElementById("authTimer");
const authCodeCheckBtn = document.getElementById("authCodeCheckBtn");

let resendCooldown = 10;  // 재요청 제한 시간 10초
let authValidTime = 300;  // 인증번호 유효 시간 5분

let resendInterval = null;
let authTimerInterval = null;

// 인증 버튼 클릭 (서버로 인증요청하여 처리)
emailAuthBtn.addEventListener("click", () => {
	const prefix = document.getElementById("user_email_prefix").value.trim();
	const domainSel = document.getElementById("user_email_domain").value;
	const custom = document.getElementById("email_domain_custom").value.trim();
	const domain = domainSel === "custom" ? custom : domainSel;
	const email = `${prefix}@${domain}`;
	const emailMessage = document.getElementById("emailMessage");
	const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;


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



// 인증번호 확인 함수
authCodeCheckBtn.addEventListener("click", validateAuthCode);
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
				document.getElementById("user_email_prefix").readOnly = true;
				document.getElementById("user_email_domain").disabled = true;
				document.getElementById("email_domain_custom").readOnly = true;
				emailAuthBtn.innerText = "인증완료";
				emailAuthBtn.disabled = true;
				authCodeCheckBtn.disabled = true;
				clearInterval(authTimerInterval);
				authTimer.innerText = "";
				
				email_invalid = true;
			} else {
				authCodeMsg.innerText = "인증번호가 일치하지 않거나 만료되었습니다.";
				authCodeMsg.style.color = "red";
				
				email_invalid = false;
			}
		})
		.catch(err => {
			console.error("인증번호 검증 오류:", err);
			authCodeMsg.innerText = "서버 오류가 발생했습니다.";
			authCodeMsg.style.color = "red";
			
			email_invalid = false;
		});
}




