<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.min(1).js"></script>
<script src="${pageContext.request.contextPath}/assets/js/header.js"></script>


<header id="header" class="">
	<div class="wrapper">
		<!-- logo -->
		<h1 class="h_logo">
			<a href="${pageContext.request.contextPath}/index.do"> <img alt="핏트럴파크"
				src="${pageContext.request.contextPath}/assets/images/logo/widthlogo.png">
			</a>
		</h1>
		<!-- //logo -->
		<!-- nav -->
		<nav class="nav">
			<ul class="main_menu">

				<!-- menu_col -->
				<li class="menu_col"><a href="">식단 관리</a> <!-- sub_menu -->
					<ul class="sub_menu" style="display: none;">
						<li><a href="">식단 계획캘린더</a></li>
						<li><a href="">식단 라이브러리</a></li>
						<li><a href="">식단 분석</a></li>
					</ul> <!--  //sub_menu --></li>
				<!-- //menu_col -->

				<!-- menu_col -->
				<li class="menu_col"><a href="">운동 관리</a> <!-- sub_menu -->
					<ul class="sub_menu" style="display: none;">
						<li><a href="">운동 계획캘린더</a></li>
						<li><a href="">운동 라이브러리</a></li>
						<li><a href="">피트럴맵</a></li>
					</ul> <!--  //sub_menu --></li>
				<!-- //menu_col -->

				<!-- menu_col -->
				<li class="menu_col"><a href="">식품 영양정보</a> <!-- sub_menu -->
					<ul class="sub_menu" style="display: none;">
						<li><a href="${pageContext.request.contextPath}/nutrition/foodsearch.do">식품 검색</a></li>
						<li><a href="">영양 성분비교</a></li>
						<li><a href="">비타민 정보</a></li>
					</ul> <!--  //sub_menu --></li>
				<!-- //menu_col -->

				<!-- menu_col -->
				<li class="menu_col"><a href="">커뮤니티</a> <!-- sub_menu -->
					<ul class="sub_menu" style="display: none;">
						<li><a href="">공지사항</a></li>
						<li><a href="">자유게시판</a></li>
						<li><a href="">Q&A게시판</a></li>
					</ul> <!--  //sub_menu --></li>
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
			<!-- 로그인상태 -->
			<c:if test="${not empty sessionScope.loginUser}">
				<!-- 환영 메시지 -->
				<div class="welcome_msg">${loginUser.memberName} 님 반갑습니다. 어서오세요.</div>
				<!-- 상단 우측 아이콘 메뉴 그룹 -->
				<ul class="icon_menu_grup">
					<!-- 알림 아이콘 -->
					<li class="icon_menu">
						<div class="alarm-container">
							<button id="alarmButton">
								<img id="alarmIcon" src="${pageContext.request.contextPath}/assets/images/icon/bellon.png" alt="알람"
									style="width: 24px; height: 24px;">
							</button>
							<!-- 알림 드롭다운 영역 -->
							<div id="alarmDropdown" class="dropdown-content">
								<!-- 알람 설정 토글 -->
								<div class="alarm-toggle">
									<span>알람 설정</span>
									<label class="switch">
										<input type="checkbox" id="alarmToggle" checked>
										<span class="slider round"></span>
									</label>
								</div>
								<!-- 알람 리스트 -->
								<div class="alarm-list">
									<!-- 동적으로 알람 리스트가 표시/추가 될 영역 -->
								</div>
							</div>
						</div>
					</li>
		
					<!-- 대시보드 아이콘 -->
					<li class="icon_menu">
						<a href="#">
							<img src="${pageContext.request.contextPath}/assets/images/icon/dashboard (2).png" alt="대시보드"
								style="width: 24px; height: 24px;">
						</a>
					</li>
		
					<!-- 마이페이지 아이콘 -->
					<li class="icon_menu">
						<a href="#">
							<img src="${pageContext.request.contextPath}/assets/images/icon/people.png" alt="마이페이지"
								style="width: 24px; height: 24px;">
						</a>
					</li>
				</ul>
				<!-- 로그아웃 버튼 -->
				<ul class="login_btn">
					<li class="icon_menu">
						<form action="${pageContext.request.contextPath}/logout.do" method="post">
							<button type="submit" id="authButton" class="btn-logout">로그아웃</button>
						</form>
					</li>
				</ul>
			</c:if>
			
			<!-- 로그아웃 상태 -->
			<c:if test="${empty sessionScope.loginUser}">
				<!-- 로그인 버튼 -->
				<ul class="login_btn">
					<li class="icon_menu">
						<button id="authButton" class="btn-login">로그인</button>
					</li>
				</ul>
			</c:if>
		</nav>




		<!-- btn_open -->
		<div class="btn_open">
			<span class="top"></span> <span class="middle"></span> <span
				class="bottom"></span>
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
			<li><a href="${pageContext.request.contextPath}/index.do">HOME</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="${pageContext.request.contextPath}/index.do">HOME</a></li>
				</ul></li>

			<li><a href="">식단 관리</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="">식단 계획캘린더</a></li>
					<li><a href="">식단 라이브러리</a></li>
					<li><a href="">식단 분석</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="">운동 관리</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="">운동 계획캘린더</a></li>
					<li><a href="">운동 루틴만들기</a></li>
					<li><a href="">운동 라이브러리</a></li>
					<li><a href="">피트럴맵</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="">식품 영양정보</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="${pageContext.request.contextPath}/nutrition/foodsearch.do">식품 검색</a></li>
					<li><a href="">영양 성분비교</a></li>
					<li><a href="">비타민 정보</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="">커뮤니티</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="">공지사항</a></li>
					<li><a href="">자유게시판</a></li>
					<li><a href="">Q&A게시판</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="">마이페이지</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="">대시보드</a></li>
					<li><a href="">나의활동</a></li>
					<li><a href="">회원정보</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->
		</ul>
	</div>
</div>
<!-- //full-menu -->
