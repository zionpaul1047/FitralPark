<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <link rel="stylesheet" href="assets/mainMenu/default.css">
    <link rel="stylesheet" href="assets/css/font.css">
    <link rel="stylesheet" href="assets/mainMenu/style.css">
    <link rel="stylesheet" href="assets/mainMenu/common.css"><!-- 공통 -->
    <link rel="stylesheet" href="assets/mainMenu/layout.css"><!-- 레이아웃 -->
    <link rel="stylesheet" href="assets/mainMenu/modal.css"><!-- 모달 -->
    <link rel="stylesheet" href="assets/mainMenu/style(1).css"><!-- 메인페이지 -->
    <script src="assets/mainMenu/jquery-1.12.4.min(1).js"></script>
    <script src="assets/mainMenu/jquery-migrate-1.4.1.min.js"></script>
    <script src="assets/mainMenu/jquery.menu.js"></script>
    <script src="assets/mainMenu/common.js"></script>
    <script src="assets/mainMenu/wrest.js"></script>
    <script src="assets/mainMenu/placeholders.min.js"></script>
    
    <style>
.login_btn {
    position: relative;
    left: 15px;
}

.icon_menu_grup {
    position: relative;
    left: 15px;
}

button::before {
	content: '' !important;
}

.nav2 {
	display: flex;
}

#header .menu_col, .icon_menu, .depth01 {
	font-family: 'Paperlogy-8ExtraBold'
}

/* Global CSS */
body {
	display: grid;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

fieldset {
	border: none;
	display: flex;
	flex-direction: column;
	gap: 0.5rem;
}

*, *::before, *::after {
	box-sizing: border-box;
}

button::before {
	content: '' !important;
}

/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
}

.nav2 {
	display: flex;
	justify-content: flex-end;
	padding: 10px;
}

.icon_menu {
	margin-right: 10px;
}

.alarm-container {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 200px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.alarm-toggle {
	padding: 12px 16px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: .4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	transition: .4s;
}

input:checked+.slider {
	background-color: #2196F3;
}

input:checked+.slider:before {
	transform: translateX(26px);
}

.slider.round {
	border-radius: 34px;
}

.slider.round:before {
	border-radius: 50%;
}

#alarmButton {
    border: 0;
}
</style>

    <header id="header" class="">	
        <div class="wrapper">	
            <!-- logo -->
            <h1 class="h_logo">
                <a href="">
                	<img alt="핏트럴파크" src="./assets/images/logo/widthlogo.png">
                </a>
            </h1>
            <!-- //logo -->
            <!-- nav -->
            <nav class="nav">			
                <ul class="main_menu">
                
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">식단 관리</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">식단 계획캘린더</a></li>
                            <li><a href="">식단 라이브러리</a></li>
                            <li><a href="">식단 분석</a></li>			
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
  
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">운동 관리</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">운동 계획캘린더</a></li>
                            <li><a href="">운동 라이브러리</a></li>
                            <li><a href="">피트럴맵</a></li>
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
                    
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">식품 영양정보</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">식품 검색</a></li>
                            <li><a href="">영양 성분비교</a></li>
                            <li><a href="">비타민 정보</a></li>
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
                    
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">커뮤니티</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">공지사항</a></li>
                            <li><a href="">자유게시판</a></li>
                            <li><a href="">Q&A게시판</a></li>
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
                    
					<!-- <li class="menu_col">
						<a href="">마이페이지</a>
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">대시보드</a></li>
                            <li><a href="">나의활동</a></li>
                            <li><a href="">회원정보</a></li>
                        </ul>
                    </li> -->
                    
                </ul>
                <!-- //main_menu -->
            </nav>
            <!-- //nav -->
            
            
            
            <nav class="nav2">
            	<!-- ■■■■■■■■■■로그인 후 보이는 코드■■■■■■■■■■ -->
				<!-- 우측아이콘버튼 -->
				<div class="welcome_msg">홍길동 님 반갑습니다. 어서오세요.</div>
            	<ul class="icon_menu_grup">
				<li class="icon_menu">
					<!-- 알림 아이콘 버튼 -->
      <div class="alarm-container">
  <button id="alarmButton">
    <img id="alarmIcon" src="assets/mainMenu/bellon.png" alt="알람" style="width: 24px; height: 24px;">
  </button>
  <div id="alarmDropdown" class="dropdown-content">
    <div class="alarm-toggle">
      <span>알람 설정</span>
      <label class="switch">
        <input type="checkbox" id="alarmToggle" checked>
        <span class="slider round"></span>
      </label>
    </div>
    <div class="alarm-list">
      <!-- 알람 내용이 여기에 동적으로 추가됩니다 -->
    </div>
  </div>
</div>
    </li><li class="icon_menu">
	                    <a href="#">
	                        <img src="assets/mainMenu/dashboard (2).png" alt="대시보드" style="width: 24px; height: 24px;">
	                    </a>
	                </li>
	                <li class="icon_menu">
	                    <a href="#">
	                        <img src="assets/mainMenu/people.png" alt="마이페이지" style="width: 24px; height: 24px;">
	                    </a>
	                </li>
	            </ul>
	            <!-- //우측아이콘버튼 -->
	            <!-- ■■■■■■■■■■//로그인 후 보이는 코드■■■■■■■■■■ -->
	            
	            <!-- 로그인/로그아웃 버튼 -->
	        	<ul class="login_btn">
	                <li class="icon_menu">
	                    <button id="authButton">로그인</button>
	                </li>
            	</ul>
            	<!-- //로그인/로그아웃 버튼 -->
            	
            </nav>
            


            <!-- btn_open -->
            <div class="btn_open">		
                <span class="top"></span>
                <span class="middle"></span>
                <span class="bottom"></span>
            </div>
            <!-- //btn_open -->
        </div>
        <!-- //wrapper -->
    </header>
    <!-- //header -->
    
    <!-- full-menu -->
    <div id="full-menu" style="display: none;">
        <div class="wrapper">
    
            <!-- depth01 -->
            <ul class="depth01">
                <li>
                    <a href="">HOME</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">HOME</a></li>
                    </ul>
                </li>
    
                <li>
                    <a href="">식단 관리</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">식단 계획캘린더</a></li>
                        <li><a href="">식단 라이브러리</a></li>
                        <li><a href="">식단 분석</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
    
                <!-- depth01 -->
                <li>
                    <a href="">운동 관리</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">운동 계획캘린더</a></li>
                        <li><a href="">운동 루틴만들기</a></li>
                        <li><a href="">운동 라이브러리</a></li>
                        <li><a href="">피트럴맵</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
    
                <!-- depth01 -->
                <li>
                    <a href="">식품 영양정보</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                    	<li><a href="">음식 검색</a></li>
                        <li><a href="">영양 성분비교</a></li>
                        <li><a href="">비타민 정보</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
    
                <!-- depth01 -->
                <li>
                    <a href="">커뮤니티</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">공지사항</a></li>
                        <li><a href="">자유게시판</a></li>
                        <li><a href="">Q&A게시판</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
    
                <!-- depth01 -->
                <li>
                    <a href="">마이페이지</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">대시보드</a></li>
                        <li><a href="">나의활동</a></li>
                        <li><a href="">회원정보</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
            </ul>
        </div>
    </div>
    <!-- //full-menu -->
    
    
    <script>
    
    //로그인 로그아웃 버튼
    document.addEventListener("DOMContentLoaded", function() {
    var authButton = document.getElementById('authButton');
    var isLoggedIn = false; // 초기 상태는 로그아웃

    authButton.addEventListener('click', function() {
        isLoggedIn = !isLoggedIn; // 상태 전환
        
	        if (isLoggedIn) {
	            authButton.textContent = '로그아웃';
	            authButton.style.background = '#dc3545'; // 빨간색 (로그아웃 상태)
	            console.log("로그인 성공");
	        } else {
	            authButton.textContent = '로그인';
	            authButton.style.background = '#28a745'; // 녹색 (로그인 상태)
	            console.log("로그아웃 성공");
	        }
        });
    });
  	//!!로그인 로그아웃 버튼
    
    
    var header = $('#header'),
        MainMenu = $('nav .main_menu .menu_col'),
        SubMenu = $('nav .sub_menu'),
        fullOpenBtn = $('.btn_open'),
        fullNav = $('#full-menu');
        
    
        SubMenu.hide();
    
        MainMenu.hover(function(){
    
            header.addClass('hover');
            
            var targetMenu = $(this).index();
    
            SubMenu.eq(targetMenu).stop().fadeIn();
    
        }, function(){
            
            header.removeClass('hover');
    
            SubMenu.fadeOut(200);
    
        });
    
        SubMenu.hover(function(){
            
            $(this).siblings('a').addClass('active');
    
        }, function(){
            
            MainMenu.children('a').removeClass('active');
    
        });
    
    
        $('#full-menu').hide();
    
    
        //풀메뉴 열림 닫힘
    
        fullOpenBtn.click(function(){		
            //클래스 붙이기
            $(this).toggleClass('active');
            header.addClass('active');
            //만약 해당 클래스가 붙어있다면 풀메뉴를 연다
            if($(this).hasClass('active') == true){
                $('#full-menu').fadeIn();
                $('#header nav').fadeOut();
                //아닐시엔 닫는다
            } else{
                $('#full-menu').fadeOut();
                $('#header nav').fadeIn();
                header.removeClass('active');
                }
        });
    
    
    
        //스크롤시 헤더 변경
         $(window).scroll(function () {
        
            
            var wScroll = $(this).scrollTop();
    
            //console.log(wScroll);
            if (wScroll > 30) {
                $('#header').addClass('on');
            } else {
                $('#header').removeClass('on');
            }
    
      });
    
    
    
    if($(window).width() < 640){ //모바일화면 사이즈
                    
         $('#full-menu .depth02').hide(); //pc에서 보여지던 하위메뉴숨김
    
            $('#full-menu .depth01 > li > a').on('click', function(){ //대메뉴 클릭 시
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
        alarmIcon.src = 'assets/mainMenu/bellon.png';
        // 알람 활성화 로직
      } else {
        alarmIcon.src = 'assets/mainMenu/belloff.png';
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


    </script>

    