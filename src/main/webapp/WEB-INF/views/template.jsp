<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
<%@ include file="/WEB-INF/views/common/asset.jsp" %>
    <style>
        body {
        background-color: rgb(218, 243, 211);
        
        }  
        .grid{
            display: grid;
		    grid-template-rows: 125px auto 1fr;
		    grid-template-columns: 1fr;
		    min-height: 100%;
        }
        .grid_top{
        	/* border: 1px solid black; */
            grid-row: 1;
        }
        .grid_center{
        	/* border: 1px solid black; */
            grid-row: 2;
		    display: grid;
		    grid-template-columns: calc(50% - 424px) auto;
        }
        .grid_center_L{
        /* border: 1px solid black; */
        }
        .grid_center_R{
        /* border: 1px solid black; */
        }
        .grid_bottom{
        /* border: 1px solid black; */
            grid-row: 3;
        }
        
    </style>
</head>
<body>
	<div class="grid">
		<div class="grid_top">
			<!-- 메인메뉴 -->
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
		    <!-- 오른쪽메뉴 -->
		    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
		    <!-- 왼쪽메뉴 -->
		    <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>
		</div>
		<div class="grid_center">
			<div class="grid_center_L"></div>
			<div class="grid_center_R">
				<!-- 컨텐츠페이지 -->
    			<%@ include file="/WEB-INF/views/common/content_page.jsp" %>
    			
			</div>
		</div>
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</div>
</body>

</html>