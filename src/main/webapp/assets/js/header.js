

var header = $('#header'),
	MainMenu = $('nav .main_menu .menu_col'),
	SubMenu = $('nav .sub_menu'),
	fullOpenBtn = $('.btn_open'),
	fullNav = $('#full-menu');


SubMenu.hide();

MainMenu.hover(function() {

	header.addClass('hover');

	var targetMenu = $(this).index();

	SubMenu.hide(); // 기존 서브메뉴 모두 숨김
	SubMenu.eq(targetMenu).show(); // 해당 메뉴만 바로 표시

}, function() {

	header.removeClass('hover');

	SubMenu.hide(); // 모든 서브메뉴 즉시 숨김

});

// 기존과 동일하게 서브메뉴에 hover 시 상위 메뉴 활성화
SubMenu.hover(function() {
	$(this).siblings('a').addClass('active');
}, function() {
	MainMenu.children('a').removeClass('active');
});


$('#full-menu').hide();


//풀메뉴 열림 닫힘

fullOpenBtn.click(function() {
	//클래스 붙이기
	$(this).toggleClass('active');
	header.addClass('active');
	//만약 해당 클래스가 붙어있다면 풀메뉴를 연다
	if ($(this).hasClass('active') == true) {
		$('#full-menu').fadeIn();
		$('#header nav').fadeOut();
		//아닐시엔 닫는다
	} else {
		$('#full-menu').fadeOut();
		$('#header nav').fadeIn();
		header.removeClass('active');
	}
});



//스크롤시 헤더 변경
$(window).scroll(function() {


	var wScroll = $(this).scrollTop();

	//console.log(wScroll);
	if (wScroll > 30) {
		$('#header').addClass('on');
	} else {
		$('#header').removeClass('on');
	}

});



if ($(window).width() < 640) { //모바일화면 사이즈

	$('#full-menu .depth02').hide(); //pc에서 보여지던 하위메뉴숨김

	$('#full-menu .depth01 > li > a').on('click', function() { //대메뉴 클릭 시
		$('#full-menu .depth02').stop().slideUp(); //열려있는 하위메뉴 닫기
		$(this).siblings('.depth02').stop().slideToggle(); //클릭한 메뉴의 하위메뉴 토글
	});

}

const alarmButton = document.getElementById('alarmButton');
const alarmIcon = document.getElementById('alarmIcon');
const alarmDropdown = document.getElementById('alarmDropdown');
const alarmToggle = document.getElementById('alarmToggle');
const alarmList = document.querySelector('.alarm-list');

alarmButton.addEventListener('click', () => {
	alarmDropdown.style.display = alarmDropdown.style.display === 'block' ? 'none' : 'block';
});

alarmToggle.addEventListener('change', () => {
	if (alarmToggle.checked) {
		alarmIcon.src = '${pageContext.request.contextPath}/assets/images/icon/bellon.png';
		// 알람 활성화 로직
	} else {
		alarmIcon.src = '${pageContext.request.contextPath}/assets/images/icon/belloff.png';
		// 알람 비활성화 로직
	}
});

// 알람 내용 추가 예시
function addAlarmItem(content) {
	const alarmItem = document.createElement('div');
	alarmItem.textContent = content;
	alarmList.appendChild(alarmItem);
}

// 예시 알람 추가
addAlarmItem('새로운 메시지가 도착했습니다.');
addAlarmItem('시스템 업데이트가 필요합니다.');

// 클릭 이벤트 외부 영역 처리
window.addEventListener('click', (event) => {
	if (!alarmButton.contains(event.target) && !alarmDropdown.contains(event.target)) {
		alarmDropdown.style.display = 'none';
	}
});

//로그인 팝업 열기
document.addEventListener("DOMContentLoaded", function() {
	const authButton = document.getElementById("authButton");

	authButton.addEventListener("click", function() {
		window.open(
			"${pageContext.request.contextPath}/login.do",
			"LoginPopup",
			"width=800,height=850,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no"
		);
	});
});
