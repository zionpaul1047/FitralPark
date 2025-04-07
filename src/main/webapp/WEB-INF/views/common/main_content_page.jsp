<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="grid-3col-custom">

<style>
.place-item {
	display: flex;
	gap: 10px;
	align-items: flex-start;
}

.place-thumb {
	width: 80px;
	height: 80px;
	border-radius: 6px;
	object-fit: cover;
	flex-shrink: 0;
}

.place-info {
	flex: 1;
	font-size: 0.9rem;
	line-height: 1.4;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/mini_dash.css">

	<!-- 1행 1열: 식품영양정보 검색 -->
	<div class="box row-1-col-1">
		<!-- 제목 -->
		<h3 class="section-title">영양정보 검색</h3>
		<form
			action="${pageContext.request.contextPath}/nutrition/foodsearch.do"
			method="POST" class="search-bar-wrapper">
			<input type="text" name="query" placeholder="식품영양정보 검색" required
				class="search-input" />
			<button type="submit" class="search-btn">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</div>

	<!-- 2행 1열: 운동센터 검색 -->
	<div class="box row-2-col-1">
		<!-- 제목 -->
		<h3 class="section-title">운동센터 찾기</h3>

		<div class="map-search-bar-wrapper">
			<!-- 내 위치 + 반경 -->
			<button id="setLocationBtn" class="search-btn" type="button">
				<i class="fa fa-crosshairs"></i>&nbsp;내 위치
			</button>
			<select id="radiusSelect" class="search-input radius-select">
				<option value="500">500m</option>
				<option value="1000" selected>1km</option>
				<option value="2000">2km</option>
				<option value="3000">3km</option>
			</select>

			<!-- 키워드 검색 -->
			<input type="text" id="keyword" placeholder="주변 운동 센터 키워드 검색"
				class="search-input keyword-input" />
			<button id="searchBtn" class="search-btn">
				<i class="fa fa-search"></i>
			</button>
		</div>


		<!-- 지도 -->
		<div id="map" class="map-area"></div>


		<!-- 검색 결과 리스트 -->
		<div id="placesListWrapper" class="places-list-wrapper">
			<ul id="placesList"></ul>
		</div>
	</div>
	<!-- 검색결과 리스트 상세보기 모달창 -->
	<div id="placeModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span id="modalCloseBtn" class="close">&times;</span>
			<div id="modalContentArea"></div>
		</div>
	</div>




	<!-- 1~2행 2열: 랭킹 -->
	<div class="box row-1-2-col-2">
		<div class="ranking-box">이달의 랭킹</div>
		<ul class="ranking-list">
			<li><span class="rank">1위</span> <span class="user">김계란</span> <span
				class="score">150점</span></li>
			<li><span class="rank">2위</span> <span class="user">압도적1위</span>
				<span class="score">120점</span></li>
			<li><span class="rank">3위</span> <span class="user">Abcd</span>
				<span class="score">110점</span></li>
			<li><span class="rank">4위</span> <span class="user">깐계란</span> <span
				class="score">110점</span></li>
			<li><span class="rank">5위</span> <span class="user">zionpaul</span> <span
				class="score">10점</span></li>
			<!-- 추가 항목 -->
		</ul>

		<div class="ranking-box">금주의 랭킹</div>
		<ul class="ranking-list">
			<li><span class="rank">1위</span> <span class="user">김계란</span> <span
				class="score">150점</span></li>
			<li><span class="rank">2위</span> <span class="user">압도적1위</span>
				<span class="score">120점</span></li>
			<li><span class="rank">3위</span> <span class="user">Abcd</span>
				<span class="score">110점</span></li>
			<li><span class="rank">4위</span> <span class="user">깐계란</span> <span
				class="score">110점</span></li>
			<li><span class="rank">5위</span> <span class="user">zionpaul</span> <span
				class="score">10점</span></li>
			<!-- 추가 항목 -->
		</ul>
	</div>

	<!-- 1~2행 3열: 로그인 / 공지 / 광고 -->
	<div class="box row-1-2-col-3">

		<!-- 🔄 로그인 상태에 따라 분기 -->
		<c:choose>
			<c:when test="${empty sessionScope.loginUser}">
				<!-- 🔒 비회원일 때: 간단 로그인 폼 -->
				<div class="login-mini">
					<form action="${pageContext.request.contextPath}/login.do"
						method="POST">
						<input type="text" name="username" placeholder="아이디"
							class="login-input" /> <input type="password" name="password"
							placeholder="비밀번호" class="login-input" />
						<button type="submit" class="login-btn">
							<i class="fa fa-sign-in-alt"></i>로그인
						</button>
					</form>
					<div class="login-links">
						<a href="javascript:void(0);" onclick="openJoinPopup()">회원가입</a>
						| <a href="${pageContext.request.contextPath}/auth.jsp#find-id">아이디
							찾기</a> | <a
							href="${pageContext.request.contextPath}/auth.jsp#find-pw">비밀번호
							찾기</a>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<!-- ✅ 로그인 후: 미니 대시보드 include -->
				<div id="profile">
			            <div id="prf_head">
			                <div id="prf_head_info">${loginUser.memberName}님의 신체 정보</div>
			                <div id="rnk">
			                    <img id="rnk_img" src="/fitralpark/assets/images/icon/${loginUser.rank}.png">
			                    <div id="rnk_name">${loginUser.rank}</div>
			                </div>
			            </div>
			            <div class="prf_box">
			                <div>키(cm)</div>
			                <div>${loginUser.height}</div>
			            </div>
			            <div class="prf_box">
			                <div>성별</div>
			                <div>${loginUser.gender eq "m" ? "남성" : "여성"}</div>
			            </div>
			            <div class="prf_box">
			                <div>체중(kg)</div>
			                <div>${loginUser.weight}</div>
			            </div>
			            <div class="prf_box">
			                <div>나이</div>
			                <div>만 ${loginUser.age}세</div>
			            </div>
			        </div>
			</c:otherwise>
		</c:choose>

		<!-- 공지사항 배너 -->
		<div class="notice-box">
			<a href="/notice/view.do?id=1"> <img
				src="/images/notice_banner.png" alt="공지사항 배너" class="banner-img">
			</a>
		</div>

		<!-- 광고 배너 -->
		<div class="ad-banner">
			<a href="https://example.com" target="_blank"> <img
				src="/images/ad_banner.jpg" alt="광고 배너" class="banner-img">
			</a>
		</div>

	</div>


</div>

