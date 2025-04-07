document.addEventListener("DOMContentLoaded", function() {
	const header = document.getElementById("header");
	const fullMenu = document.getElementById("full-menu");
	const fullOpenBtn = document.querySelector(".btn_open");
	const authButton = document.getElementById("authButton");

	// 서브메뉴 hover 시 부드럽게 나타남
	document.querySelectorAll(".menu_col").forEach((col) => {
		col.addEventListener("mouseenter", () => {
			const submenu = col.querySelector(".sub_menu");
			if (submenu) submenu.classList.add("active");
		});
		col.addEventListener("mouseleave", () => {
			const submenu = col.querySelector(".sub_menu");
			if (submenu) submenu.classList.remove("active");
		});
	});

	// 햄버거 풀메뉴 toggle
	if (fullOpenBtn) {
		fullOpenBtn.addEventListener("click", () => {
			fullOpenBtn.classList.toggle("active");
			header.classList.toggle("active");
			fullMenu.style.display = fullOpenBtn.classList.contains("active") ? "block" : "none";
		});
	}

	if (
		authButton &&
		window.opener == null &&
		window.name !== 'LoginPopup' &&
		window.location.pathname === contextPath + "/index.do"
	) {
		authButton.addEventListener("click", () => {
			const overlay = document.getElementById("overlay");
			if (overlay) overlay.style.display = "block";

			window.open(
				contextPath + "/login.do",
				"LoginPopup",
				"width=800,height=850,resizable=no,scrollbars=no"
			);
		});
	}

	// 알림 토글 (드롭다운)
	const alarmButton = document.getElementById("alarmButton");
	const alarmDropdown = document.getElementById("alarmDropdown");
	const alarmToggle = document.getElementById("alarmToggle");
	const alarmIcon = document.getElementById("alarmIcon");

	if (alarmButton && alarmDropdown) {
		alarmButton.addEventListener("click", (e) => {
			e.stopPropagation();
			alarmDropdown.classList.toggle("show");
		});
		document.addEventListener("click", (e) => {
			if (!alarmDropdown.contains(e.target)) {
				alarmDropdown.classList.remove("show");
			}
		});
	}


	if (alarmToggle && alarmIcon) {
		alarmToggle.addEventListener("change", () => {
			alarmIcon.src = contextPath + "/assets/images/icon/" + (alarmToggle.checked ? "bellon.png" : "belloff.png");
			

			// ⚠️ 추가 기능: 서버에 상태 저장할 경우 아래 코드 추가 가능
			/*
			fetch(contextPath + "/toggleAlarmSetting.do", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({ alarmOn: isOn })
			});
			*/
			
		});
	}
});

window.addEventListener("scroll", function () {
	const header = document.getElementById("header");
	if (!header) return;

	if (window.scrollY > 10) {
		header.classList.add("scrolled");
	} else {
		header.classList.remove("scrolled");
	}
});