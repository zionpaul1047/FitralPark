<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>FITRALPARK</title>
	<%@ include file="/WEB-INF/views/common/asset.jsp" %>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
	
</head>
<body>


<div class="layout-wrapper">

  <!-- 헤더 영역 -->
  <header class="layout-header">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
  </header>

  <!-- 콘텐츠 영역 -->
<main class="layout-main">
  <div class="main-content-area">
    
    <!-- 실제 콘텐츠 -->
    <div class="layout-content">
      <%@ include file="/WEB-INF/views/common/main_content_page.jsp" %>
    </div>

    <!-- 우측 사이드바 -->
    <aside class="layout-sidebar-right">
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
    </aside>

  </div>
</main>

  <!-- 푸터 영역 -->
  <footer class="layout-footer">
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </footer>

</div>


    <script>
/* 	 	// 모든 메뉴 항목을 선택
	    const menuItems = document.querySelectorAll('.sf_submenu_1 div');
	
	    // 클릭 이벤트 추가
	    menuItems.forEach(item => {
	      item.addEventListener('click', () => {
	        // 모든 항목의 스타일 초기화
	        menuItems.forEach(menu => {
	          menu.classList.remove('active'); // active 클래스 제거
	          menu.style.backgroundColor = 'lightgray'; // 기본 배경색 설정
	          menu.style.fontWeight = 'normal'; // 기본 글씨 굵기 설정
	        });
	
	        // 클릭된 항목에 스타일 적용
	        item.classList.add('active'); // active 클래스 추가
	        item.style.backgroundColor = 'oldlace'; // 클릭된 항목 배경색 설정
	        item.style.fontWeight = 'bold'; // 클릭된 항목 글씨 굵게 설정
	      });
	    }); */

    </script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d60ef8deb86dfe497046e0750fa9f23&libraries=services"></script>
<script src="${pageContext.request.contextPath}/assets/js/main_content_page.js"></script>


</body>


</html>