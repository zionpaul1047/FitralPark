// 입력 필드 포커스 시 라벨 이동
function labelUp(input) {
	input.parentElement.children[0].classList.add("change_label");
}
function labelDown(input) {
	if (input.value.length === 0) {
		input.parentElement.children[0].classList.remove("change_label");
	}
}

// 비밀번호 보기/숨기기
const togglePassword = (iconId, inputId) => {
	const icon = document.getElementById(iconId);
	const input = document.getElementById(inputId);
	if (!icon || !input) return;
	icon.addEventListener("click", () => {
		if (icon.classList.contains("fa-eye-slash")) {
			icon.classList.remove("fa-eye-slash");
			icon.classList.add("fa-eye");
			input.type = "text";
		} else {
			icon.classList.remove("fa-eye");
			icon.classList.add("fa-eye-slash");
			input.type = "password";
		}
	});
};
togglePassword("eye_icon_login", "login_password");
togglePassword("eye_icon_signup", "signup_password");

// 페이지 로드시 기본 로그인 폼 표시
document.addEventListener("DOMContentLoaded", function () {
  document.getElementById("login").style.display = "block";
  document.getElementById("signup").style.display = "none";
});

// 로그인/회원가입 폼 전환
document.getElementById("to_signup")?.addEventListener("click", () => {
	document.getElementById("login").style.display = "none";
	document.getElementById("signup").style.display = "block";
});
document.getElementById("to_login")?.addEventListener("click", () => {
	document.getElementById("signup").style.display = "none";
	document.getElementById("login").style.display = "block";
});
