<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="grid-3col">

  <!-- 1. 식품 검색 상단 배너 -->
  <div class="box wide-box">
    <input type="text" placeholder="식품영양정보 검색" class="search-input" />
    <button class="search-btn">🔍</button>
  </div>

  <!-- 2. 운동센터 검색 + 지도 -->
  <div class="box">
    <input type="text" placeholder="주변 운동 센터 키워드 검색" class="search-input" />
    <button class="search-btn">🔍</button>
    <div class="map-area">[지도 영역]</div>
    <div class="map-link-box">센터 정보 및 링크</div>
  </div>

  <!-- 3. 랭킹 영역 -->
  <div class="box">
    <div class="ranking-box">이달의 랭킹</div>
    <div class="ranking-box">금주의 랭킹</div>
  </div>

  <!-- 4. 우측 영역: 로그인, 공지, 광고 -->
  <div class="box">
    <div class="login-mini">[ID/PW 입력]</div>
    <div class="notice-box">이벤트 및 공지</div>
    <div class="ad-banner">광고 배너</div>
  </div>

</div>
