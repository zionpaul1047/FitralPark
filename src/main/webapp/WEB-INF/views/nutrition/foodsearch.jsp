<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
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
        
        
        
        
        /* ■■■■■■■■■■ 컨텐츠 CSS ■■■■■■■■■■ */
        
        .content_bg {
			/* margin-left: 228px;
		    margin-top: 276px; */
		    margin-bottom: 30px;
		    /* border: 1px solid black; */
		    width: 1065px;
		    border-radius: 20px;
		    background: var(--white);
		    box-sizing: border-box;
		}

		.content_box{
		   	/* border: 1px solid black; */
			padding: 30px;
			word-wrap: break-word;
		}
        
        
        .sf_body {
	        /* border: 1px solid black;  */   
	        width: 1000px;
	        margin: auto;
	        display: flex;
	        flex-direction: column;/* 세로 방향 정렬 추가 */
	        justify-content: center;/* 세로 축 중앙 정렬 */
	        align-items: center; /* 가로 축 중앙 정렬 */
	    }
	
	    .sf_food_search_bar{
	        width: 850px;
	        height: 80px;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	    }
	
	    .sf_food_search_input {
	        border: 1px solid gray;
    		border-radius: 5px;
    		padding: 10px;
	        /* text-align: center; */
	        width: 800px;
	        height: 40px;
	        /* margin: 20px; */
	    }
	
	    .sf_food_search_button{

	        height: 46px;
	        width: 50px;
	    }
	
	    .sf_filter_section {
	        /* border: 1px solid black;  */
	        width: 850px;
	        margin-bottom: 20px;
	    }
	
	    .sf_filter_form label {
	        
	        display: inline-block;
	        margin-right: 10px;
	    }
	
	    .sf_submenu_1{
	        display: flex;
	        width: 850px;
	    }
	    
	    .sf_submenu_1 a div {
		  	background-color: lightgray; /* 기본 배경색 */
		  	border-right: 2px solid var(--white);
		  	width: 80px;
		  	height: 40px;
		  	text-align: center; /* 가로 중앙 정렬 */
		  	line-height: 40px; /* 세로 중앙 정렬 */
		}
		
		.sf_submenu_1 a {
		  display: block; /* 링크를 블록 요소로 만들어 div 전체를 클릭 가능하게 설정 */
		  text-decoration: none; /* 링크의 기본 밑줄 제거 */
		}
		
		.sf_submenu_1 a:hover div {
		  background-color: oldlace; /* 마우스 오버 시 배경색 변경 */
		  font-weight: bold; /* 마우스 오버 시 글씨 굵게 */
		}
		
		.sf_submenu_1 a.active div {
		  background-color: oldlace; /* 클릭된 메뉴 배경색 */
		  font-weight: bold; /* 클릭된 메뉴 글씨 굵게 */
		}
		
	    .sf_submenu_1:nth-last-child(2){
	    	border-right:none;
	    }
	
	    .sf_submenu_1_1{
	
	    }
	
	    .sf_submenu_1_2{
	
	    }
	
	    .sf_submenu_1_3{
	
	    }
	    
	    .sf_submenu_1_4{
	
	    }
	
	    .sf_list_search_bar {
	    	
	        margin-left: auto;
	        margin-bottom: 10px;
	        display: flex;
	        justify-content: flex-end;
	    }
	
	    .sf_list_search_input {
	   		border: 1px solid gray;
    		border-radius: 5px;
	        padding: 5px;
	    }
	
	    .sf_list_search_button {
	        width: 40px;
	    }
	
	    /* 검색 결과 스타일 */
	    .sf_result_section {
	        /* border: 1px solid black;  */
	        background-color: oldlace;
	        width: 850px;
	    }
	    
	    .sf_result_section_1 {
	        margin-bottom: 10px;
	        border-bottom: solid var(--white);
	        /* border: 1px solid red;  */
	    }
	    
	    .sf_result_item_1 {
	        display: flex;
	    }
	
	    .sf_result_img_1 {
	        border: 1px solid black;
	        display: flex;
	        margin-left: 10px;
	        margin-top: 10px;
	        height: 100px;
	        width: 100px;
	    }
	
	    .sf_result_info_1 {
	        /* border: 1px solid blue; */
	        width: 720px;
	        margin: 10px;
	    }
	
	    .sf_result_info_food_name_1{
	        font-weight: bold;
	    }
	
	    .sf_result_info_food_detail_1{
	    	margin-top:10px;
	        font-size: 12px;
	    }
	    
	
	    .sf_result_section_1_2{
	        display: flex;
	        justify-content: flex-end;
	        margin-bottom: 10px;
	    }
	        
	    .sf_result_favorite_button_1{
	        font-size: 14px;
		    border: 1px solid gray;
		    background-color: lightgray;
		    margin-right: 12px;
		    padding: 4px;
		    border-radius: 5px;
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
			    <%@ include file="/WEB-INF/views/common/left_menu3.jsp" %>
		</div>
		
		<div class="grid_center">
		
			<div class="grid_center_L"></div>
			
			<div class="grid_center_R">
				<!-- 컨텐츠페이지 -->
				<div class="content_bg">
					<div class="content_box">
		    			<div class="sf_body">
					        <div class="sf_food_search_bar">
					            <input type="text" placeholder="검색어를 입력해 주세요" class="sf_food_search_input">
					            <button class="sf_food_search_button">🔍</button>
					        </div>
					
					        <section class="sf_filter_section">
					            
					            <form class="sf_filter_form">
					                <label><input type="checkbox" class="sf_prot" id="sf_prot"> 단백질</label>
					                <label><input type="checkbox" class="sf_chocdf" id="sf_chocdf"> 탄수화물</label>
					                <label><input type="checkbox" class="sf_fatce" id="sf_fatce"> 지방</label>
					                <label><input type="checkbox" class="sf_sugar" id="sf_sugar"> 당류</label>
					                <label><input type="checkbox" class="sf_nat" id="sf_nat"> 나트륨</label>
					                <label><input type="checkbox" class="sf_fibtg" id="sf_fibtg"> 식이섬유</label>
					                <br><br> 
					                <label><input type="checkbox" class="sf_ca" id="sf_ca"> 칼슘</label>
					                <label><input type="checkbox" class="sf_fe" id="sf_fe"> 철</label>
					                <label><input type="checkbox" class="sf_p" id="sf_p"> 인</label>
					                <label><input type="checkbox" class="sf_k" id="sf_k"> 칼륨</label>
					                <label><input type="checkbox" class="sf_chole" id="sf_chole"> 콜레스테롤</label>
					                <label><input type="checkbox" class="sf_fasat" id="sf_fasat"> 포화지방</label>
					                <label><input type="checkbox" class="sf_fatrn" id="sf_fatrn"> 트랜스지방</label>
					                <br><br> 
					                <label><input type="checkbox" class="sf_vita" id="sf_vita"> 비타민A</label> <!-- vitaRae, retol, cartb -->
					                <label><input type="checkbox" class="sf_vitb" id="sf_vitb"> 비타민B</label> <!-- thia, ribf, nia -->
					                <label><input type="checkbox" class="sf_vitc" id="sf_vitc"> 비타민C</label>
					                <label><input type="checkbox" class="sf_vitd" id="sf_vitd"> 비타민D</label>
					            </form>
					        </section>
					        
					        <div class="sf_submenu_1">
					            <a href=""><div class="sf_submenu_1_1">메뉴1</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴2</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴3</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴4</div></a>
					            <span class="sf_list_search_bar">
					                <input type="text" placeholder="리스트 내 검색" class="sf_list_search_input">
					                <button class="sf_list_search_button">🔍</button>
					            </span>
					        </div>
					        
					        <section class="sf_result_section">
					            <!-- 첫 번째 검색 결과 -->
					            <div class="sf_result_section_1">
					                <div class="sf_reult_section_1_1">
					                    <div class="sf_result_item_1">
					                        <img src="#" alt="사진 크롤링" class="sf_result_img_1" id="sf_result_img_1">
					                        <div class="sf_result_info_1">
					                            <div class="sf_result_info_food_name_1">미트볼 조림 100g</div>
					                            <div class="sf_result_info_food_detail_1"><p>
					                                칼로리(kcal): 221 | 단백질(g): 18.15 | 탄수화물(g): 12.95 | 지방(g): 10.73 | 당류(g): 10.52 | 나트륨(mg): 315<br>
					                            <br>칼슘(mg): 24 | 철(mg): 0.91 | 인(mg): 191 | 칼륨(mg): 405 | 콜레스테롤(mg): 29.48 | 포화지방(g): 2.12<br>
					                            <br>트랜스지방(g): 0.08 | 비타민A(μg RAE): 11 | 베타카로틴(μg): 21 | 티아민(mg): 0.927<br>
					                            <br>리보플라빈(mg): 0.133 | 나이아신(mg): 9.987 | 비타민C(mg): 2.03 | 비타민D(μg): 0.01
					                            </p></div>
					                        </div>
					                    </div>
					                </div>
					                <div class="sf_result_section_1_2">
					                    <button class="sf_result_favorite_button_1">즐겨찾기 등록</button>
					                </div>     
					            </div>
					
					            <!-- 두 번째 검색 결과 -->
					            <!-- 동일한 구조 -->
					            <div class="sf_result_section_1">
					                <div class="sf_reult_section_1_1">
					                    <div class="sf_result_item_1">
					                        <img src="#" alt="사진 크롤링" class="sf_result_img_1" id="sf_result_img_1">
					                        <div class="sf_result_info_1">
					                            <div class="sf_result_info_food_name_1">미트볼 조림 100g</div>
					                            <div class="sf_result_info_food_detail_1"><p>
					                                칼로리(kcal): 221 | 단백질(g): 18.15 | 탄수화물(g): 12.95 | 지방(g): 10.73 | 당류(g): 10.52 | 나트륨(mg): 315<br>
					                            <br>칼슘(mg): 24 | 철(mg): 0.91 | 인(mg): 191 | 칼륨(mg): 405 | 콜레스테롤(mg): 29.48 | 포화지방(g): 2.12<br>
					                            <br>트랜스지방(g): 0.08 | 비타민A(μg RAE): 11 | 베타카로틴(μg): 21 | 티아민(mg): 0.927<br>
					                            <br>리보플라빈(mg): 0.133 | 나이아신(mg): 9.987 | 비타민C(mg): 2.03 | 비타민D(μg): 0.01
					                            </p></div>
					                        </div>
					                    </div>
					                </div>
					                <div class="sf_result_section_1_2">
					                    <button class="sf_result_favorite_button_1">즐겨찾기 등록</button>
					                </div>     
					            </div>
					        </section>
					    </div>
					</div>
				</div>
			</div>
			
		</div>
		
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>

	<script>
	

	
	</script>
    



</body>


</html>