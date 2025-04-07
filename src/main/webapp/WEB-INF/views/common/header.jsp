<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 공통 CSS/JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
<!-- contextPath 전역 변수 -->
<script>
	const contextPath = '${pageContext.request.contextPath}';
	let loginPopupWindow = null;
</script>
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/header.js"></script>


<header id="header">
	<div class="wrapper">
		<!-- 로고 -->
		<h1 class="h_logo">
			<a href="${pageContext.request.contextPath}/index.do">
				<img src="${pageContext.request.contextPath}/assets/images/logo/widthlogo.png" alt="FitralPark">
			</a>
		</h1>
		<!-- 메인 메뉴 -->
		<!-- 메인 메뉴 -->
		<nav class="nav">
			<ul class="main_menu">
				<li class="menu_col">
					<a href="#">식단 관리</a>
					<ul class="sub_menu">
						<li><a href="#" class="unembodiment_menu">식단 계획캘린더</a></li>
						<li><a href="${pageContext.request.contextPath}/dietRecommend.do">식단 라이브러리</a></li>
						<li><a href="#" class="unembodiment_menu">식단 분석</a></li>
					</ul>
				</li>
				<li class="menu_col">
					<a href="#">운동 관리</a>
					<ul class="sub_menu">
						<li><a href="${pageContext.request.contextPath}/exerciseList.do">운동 계획캘린더</a></li>
						<li><a href="${pageContext.request.contextPath}/exerciseRecommend.do">운동 라이브러리</a></li>
						<li><a href="${pageContext.request.contextPath}/exercise/fitnessmap.do">피트럴맵</a></li>
					</ul>
				</li>
				<li class="menu_col">
					<a href="#">영양정보 관리</a>
					<ul class="sub_menu">
						<li><a href="${pageContext.request.contextPath}/nutrition/foodsearch.do">식품 검색</a></li>
						<li><a href="#" class="unembodiment_menu">영양 성분비교</a></li>
						<li><a href="#" class="unembodiment_menu">비타민 정보</a></li>
					</ul>
				</li>
				<li class="menu_col">
					<a href="${pageContext.request.contextPath}/bulletinList.do">커뮤니티</a>
					<ul class="sub_menu">
						<li><a href="${pageContext.request.contextPath}/announcementList.do">공지사항</a></li>
						<li><a href="${pageContext.request.contextPath}/bulletinPost.do">자유게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/qnaList.do">Q&A게시판</a></li>
					</ul>
				</li>
			</ul>
		</nav>
		
		<nav class="nav2">
			<c:choose>
				<c:when test="${empty sessionScope.loginUser}">
					<!-- 비로그인 상태 -->
					<ul class="login_btn">
						<li class="icon_menu">
							<button id="authButton" class="btn-login">로그인</button>
						</li>
					</ul>
				</c:when>
				<c:otherwise>
					<!-- 로그인 상태 -->
					<div class="welcome_msg">
						<strong>${sessionScope.loginUser.memberName}</strong> 님 반갑습니다. 어서오세요.
					</div>
					<ul class="icon_menu_grup">
					
					<!-- 알람 버튼 -->
					<li class="icon_menu" id="alarmButton">
						<img id="alarmIcon" src="${pageContext.request.contextPath}/assets/images/icon/belloff.png" alt="알림" style="width: 24px; height: 24px;">
					</li>
					<div id="alarmDropdown" class="alarm-dropdown">
					    <!-- 알림 목록 출력 예정 -->
					    <div class="alarm-toggle">
					        <label for="alarmToggle">알림 수신</label>
					        <label class="switch">
					            <input type="checkbox" id="alarmToggle">
					            <span class="slider"></span>
					        </label>
					    </div>
					    <div class="alarm-list">
					        <p>알림 내용이 여기에 표시됩니다.</p>
					    </div>
					</div>
						
						
						
						<li class="icon_menu">
							<a href="${pageContext.request.contextPath}/dashboard.do"><img src="${pageContext.request.contextPath}/assets/images/icon/dashboard (2).png" alt="대시보드" style="width: 24px; height: 24px;"></a>
						</li>
						<li class="icon_menu">
							<a href="${pageContext.request.contextPath}/dashboard.do"><img src="${pageContext.request.contextPath}/assets/images/icon/people.png" alt="마이페이지" style="width: 24px; height: 24px;"></a>
						</li>
					</ul>
					<ul class="login_btn">
						<li class="icon_menu">
							<form action="${pageContext.request.contextPath}/logout.do" method="post">
								<button type="submit" class="btn-logout">로그아웃</button>
							</form>
						</li>
					</ul>
				</c:otherwise>
			</c:choose>
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


<!-- 로그인 여부에 따라 회원전용페이지 접근 시 로그인 시키기 -->
<div id="overlay" style="display:none; position:fixed; z-index:9999;
  top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5);">
</div>

<c:if test="${not empty loginRequired or not empty sessionScope.loginRequired}">
	<script>
		window.addEventListener("DOMContentLoaded", function () {
			const overlay = document.getElementById("overlay");
			if (overlay) overlay.style.display = "block";

			if (loginPopupWindow == null || loginPopupWindow.closed) {
				loginPopupWindow = window.open(
					contextPath + "/login.do",
					"loginPopup",
					"width=800,height=850,resizable=no,scrollbars=no"
				);
			} else {
				loginPopupWindow.focus(); // 이미 열린 팝업이 있을 경우 다시 띄우지 않고 포커스만 주기
			}
		});
	</script>
</c:if>


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
					<li><a href="#" class="unembodiment_menu">식단 계획캘린더</a></li>
					<li><a href="${pageContext.request.contextPath}/dietRecommend.do"">식단 라이브러리</a></li>
					<li><a href="#" class="unembodiment_menu">식단 분석</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="">운동 관리</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="${pageContext.request.contextPath}/exerciseList.do">운동 계획캘린더</a></li>
					<li><a href="">운동 루틴만들기</a></li>
					<li><a href="">운동 라이브러리</a></li>
					<li><a href="">피트럴맵</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="">식품 영양정보</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="${pageContext.request.contextPath}/nutrition/foodsearch.do">식품 검색</a></li>
					<li><a href="#" class="unembodiment_menu">영양 성분비교</a></li>
					<li><a href="#" class="unembodiment_menu">비타민 정보</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="${pageContext.request.contextPath}/announcementList.do">커뮤니티</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="${pageContext.request.contextPath}/announcementList.do">공지사항</a></li>
					<li><a href="${pageContext.request.contextPath}/bulletinList.do">자유게시판</a></li>
					<li><a href="${pageContext.request.contextPath}/qnaList.do">Q&A게시판</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->

			<!-- depth01 -->
			<li><a href="${pageContext.request.contextPath}/dashboard.do">마이페이지</a> <!-- depth02 -->
				<ul class="depth02">
					<li><a href="${pageContext.request.contextPath}/dashboard.do">대시보드</a></li>
					<li><a href="${pageContext.request.contextPath}/mdfyuserinfo.do">회원정보수정</a></li>
				</ul> <!--  //depth02--></li>
			<!-- //depth01 -->
		</ul>
	</div>
</div>
