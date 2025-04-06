<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="grid-3col-custom">


<!-- 1행 1열: 식품영양정보 검색 -->
<div class="box row-1-col-1">
  <form action="${pageContext.request.contextPath}/nutrition/foodsearch.do" method="POST" class="search-bar-wrapper">
    <input type="text" name="query" placeholder="식품영양정보 검색" required class="search-input" />
    <button type="submit" class="search-btn"><i class="fa fa-search"></i></button>
  </form>
</div>

<!-- 2행 1열: 운동센터 검색 -->
<div class="box row-2-col-1">

  <!-- 위치 및 반경 설정 영역 -->
  <div class="map-controls" style="display: flex; gap: 10px; margin-bottom: 10px;">
    <button id="setLocationBtn" class="search-btn" type="button">
      <i class="fa fa-crosshairs"></i>&nbsp;내 위치
    </button>
    <select id="radiusSelect" class="search-input" style="max-width: 120px;">
      <option value="500">500m</option>
      <option value="1000" selected>1km</option>
      <option value="2000">2km</option>
      <option value="3000">3km</option>
    </select>
  </div>

  <!-- 검색창 -->
  <div class="search-bar-wrapper">
    <input type="text" id="keyword" placeholder="주변 운동 센터 키워드 검색" class="search-input" />
    <button id="searchBtn" class="search-btn"><i class="fa fa-search"></i></button>
  </div>

  <!-- 지도 및 결과 리스트 -->
  <div id="map" style="width:100%; height:250px; margin-top: 10px;"></div>
  <ul id="placesList"></ul>
</div>



  <!-- 1~2행 2열: 랭킹 -->
  <div class="box row-1-2-col-2">
    <div class="ranking-box">이달의 랭킹</div>
    <div class="ranking-box">금주의 랭킹</div>
  </div>

  <!-- 1~2행 3열: 로그인 / 공지 / 광고 -->
  <div class="box row-1-2-col-3">
    <div class="login-mini">[ID/PW 입력]</div>
    <div class="notice-box">이벤트 및 공지</div>
    <div class="ad-banner">광고 배너</div>
  </div>

</div>
