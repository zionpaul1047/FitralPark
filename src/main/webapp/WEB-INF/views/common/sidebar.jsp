<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.min.js"></script>
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
                    
                    식단 <br>라이브러리
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    운동 <br>라이브러리
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    운동계획 <br>캘린더
                </a>
            </li>
            <li class="open">
                <a href="">
                    
                    식품검색
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