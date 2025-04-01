<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.min(1).js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-migrate-1.4.1.min.js"></script>


<style>
#div .xi-home, .open {
	font-family: 'Paperlogy-8ExtraBold'
}


</style>

<!-- 우측 사이드 메뉴바 -->
   <div class="fix-menu">
        <ul>
            <li class="open go_home">
                <a href="">
                    <i class="xi-home"></i>
                    HOME
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    공지사항
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    의료진 <br>소개
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    전화번호 <br>안내
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    진료시간
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    오시는길
                </a>
            </li>
            <li class="setup">
               <a href="#">
                            <img src="${pageContext.request.contextPath}/assets/images/icon/settings.png" alt="설정" style="width: 24px; height: 24px;">
                        </a>
            </li>
            <li class="button">
                <a href="javascript:void(0)">
                    <i><img src="" alt="메뉴 더보기"></i>
                </a>
            </li>
        </ul>
    
        <div id="scrollToTopBtn" class="top">
            <i><img src="${pageContext.request.contextPath}/assets/images/icon/main-arr.png" alt="홈페이지 상단으로 올라가기"></i>
        </div>
    
    </div>
    <!-- //우측 사이드 메뉴바 -->
    
     <script>
        document.getElementById("scrollToTopBtn").addEventListener("click", () => {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });
    </script>