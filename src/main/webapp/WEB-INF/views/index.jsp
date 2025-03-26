<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FITRALPACK</title>

    <link rel="stylesheet" href="assets/mainMenu/default.css">
    <link rel="stylesheet" href="assets/mainMenu/font-awesome.min.css">
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

</head>
<body data-aos-easing="ease" data-aos-duration="400" data-aos-delay="0" style ="background-color: beige;">
    <header id="header" class="">	
        <div class="wrapper">	
            <!-- logo -->
            <h1 class="h_logo">
                <a href="">
                	<img alt="핏트럴파크" src="assets/logo/widthlogo.png">
                </a>
            </h1>
            <!-- //logo -->
            <!-- nav -->
            <nav class="nav">			
                <ul class="main_menu">
                
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">식단관리</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">식단계획캘린더</a></li>
                            <li><a href="">식단만들기</a></li>
                            <li><a href="">식단추천</a></li>
                            <li><a href="">식단분석</a></li>			
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
  
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">운동관리</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">운동계획캘린더</a></li>
                            <li><a href="">운동루틴만들기</a></li>
                            <li><a href="">사용자정의운동</a></li>
                            <li><a href="">핏트럴맵</a></li>
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
                    
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">음식성분찾기</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">음식검색</a></li>
                            <li><a href="">영양성분비교</a></li>
                            <li><a href="">비타민검색추천</a></li>
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
                    
                    <!-- menu_col -->
                    <li class="menu_col">
                        <a href="">마이페이지</a>
                        <!-- sub_menu -->
                        <ul class="sub_menu" style="display: none;">
                            <li><a href="">대시보드</a></li>
                            <li><a href="">나의활동</a></li>
                            <li><a href="">회원정보</a></li>
                        </ul>
                        <!--  //sub_menu -->
                    </li>
                    <!-- //menu_col -->
                    
                </ul>
                <!-- //main_menu -->
            </nav>
            <!-- //nav -->
            
            <nav class="nav2">
            	<ul class="icon_menu_grup">
                    <!-- 우측아이콘버튼 -->
                    <li class="icon_menu">
	                    <a href="#">
	                        <img src="assets/mainMenu/bell (2).png" alt="알림" style="width: 24px; height: 24px;">
	                    </a>
	                </li>
	                <li class="icon_menu">
	                    <a href="#">
	                        <img src="assets/mainMenu/dashboard (1).png" alt="대시보드" style="width: 24px; height: 24px;">
	                    </a>
	                </li>
	                <!-- //우측아이콘버튼 -->
	                <!-- 로그인/로그아웃 버튼 -->
	                <li class="icon_menu">
	                    <button id="authButton">로그인</button>
	                </li>
	                <!-- //로그인/로그아웃 버튼 -->
            	</ul>
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
                    <a href="">식단관리</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">식단계획캘린더</a></li>
                        <li><a href="">식단만들기</a></li>
                        <li><a href="">식단추천</a></li>
                        <li><a href="">식단분석</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
    
                <!-- depth01 -->
                <li>
                    <a href="">운동관리</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                        <li><a href="">운동계획캘린더</a></li>
                        <li><a href="">운동루틴만들기</a></li>
                        <li><a href="">사용자정의운동</a></li>
                        <li><a href="">핏트럴맵</a></li>
                    </ul>
                    <!--  //depth02-->
                </li>
                <!-- //depth01 -->
    
                <!-- depth01 -->
                <li>
                    <a href="">음식성분찾기</a>
                    <!-- depth02 -->
                    <ul class="depth02">
                    	<li><a href="">음식검색</a></li>
                        <li><a href="">영양성분비교</a></li>
                        <li><a href="">비타민검색추천</a></li>
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
    
    
    
        //fullOpenBtn.click(function(){		
            //클래스 붙이기
            //$(this).toggleClass('active');
            //만약 해당 클래스가 붙어있다면 풀메뉴를 연다
            //if($(this).hasClass('active') == true){
                //$('#full-menu').fadeIn();
                //아닐시엔 닫는다
            //} else{
                //$('#full-menu').fadeOut();
                //}
        //});
    
    
        //1차 메뉴 색상변경
    
        //$("#full-menu .depth02 > li").hover(function(){
            //상위 부모를 찾아 클래스를 붙인다 
          //$(this).parents('.depth01').addClass('add');
          //마우스가 떠났을때는 클래스를 지운다.
          //}, function(){
         // $("#full-menu .depth01").removeClass('add');
        //});
    
    
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
        
    
    </script>
    
</body>
</html>