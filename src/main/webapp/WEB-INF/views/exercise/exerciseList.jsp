<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPACK</title>
	<link rel="stylesheet" href="assets/css/exercise.css">
    <style>
        body {background-color: rgb(218, 243, 211);}  
    </style>
</head>
<body>
	<!-- 메인메뉴 -->
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <!-- 오른쪽메뉴 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
    
    <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>

	<main>
		<div class="calendar">
    <div class="calendar-header">2025.03</div>
    <div class="calendar-nav">
      <button>&lt;</button>
      <button>오늘</button>
      <button>&gt;</button>
    </div>
    <div class="calendar-grid">
      <div class="calendar-day sunday">일</div>
      <div class="calendar-day">월</div>
      <div class="calendar-day">화</div>
      <div class="calendar-day">수</div>
      <div class="calendar-day">목</div>
      <div class="calendar-day">금</div>
      <div class="calendar-day saturday">토</div>

      <div class="calendar-date"></div>
      <div class="calendar-date"></div>
      <div class="calendar-date"></div>
      <div class="calendar-date"></div>
      <div class="calendar-date"></div>
      <div class="calendar-date"></div>
      <div class="calendar-date saturday">1</div>

      <div class="calendar-date sunday">2</div>
      <div class="calendar-date">3</div>
      <div class="calendar-date">4</div>
      <div class="calendar-date">5</div>
      <div class="calendar-date">6</div>
      <div class="calendar-date">7</div>
      <div class="calendar-date saturday">8</div>

      <div class="calendar-date sunday">9</div>
      <div class="calendar-date highlight">10</div>
      <div class="calendar-date">11</div>
      <div class="calendar-date">12</div>
      <div class="calendar-date">13</div>
      <div class="calendar-date">14</div>
      <div class="calendar-date saturday">15</div>

      <div class="calendar-date sunday">16</div>
      <div class="calendar-date">17</div>
      <div class="calendar-date">18</div>
      <div class="calendar-date">19</div>
      <div class="calendar-date">20</div>
      <div class="calendar-date">21</div>
      <div class="calendar-date saturday">22</div>

      <div class="calendar-date sunday">23</div>
      <div class="calendar-date">24</div>
      <div class="calendar-date">25</div>
      <div class="calendar-date">26</div>
      <div class="calendar-date">27</div>
      <div class="calendar-date">28</div>
      <div class="calendar-date saturday">29</div>

      <div class="calendar-date sunday">30</div>
      <div class="calendar-date">31</div>
    </div>
  </div>
	</main>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
</body>
</html>