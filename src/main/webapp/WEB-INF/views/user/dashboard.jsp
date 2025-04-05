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
        
        #dashboard {
        	position: relative;
        	/* top: 125px;
        	width: 1024px; */
        	top: 0;
        	width: 0;
            /* border: 1px solid black; */

            display: grid;
            /* grid-template-columns: 100px 100px 100px 100px;
            grid-template-columns: 100px 100px 100px 100px; */
            grid-template-columns: 1fr 1fr 1fr 1fr;
            grid-template-rows: 250px 250px auto auto;

        }

        /* 그리드 확인용 */
        main#dashboard > div {
            /* border: 1px solid black; */
            position: relative;
            top: 0;
            left: 0;
        }

        
        #profile {
            grid-column-end: span 2;
            grid-row-end: span 2;

            background-color: white;
            border-radius: 10px;
            height: 500px;
            width: 512px;

            position: relative;
            top: 0;
            left: 0;
        }

        /* 프로필 헤드 */
        #profile > #prf_head {
            height: 250px;
            border-radius: 10px;
            background-color: azure;
            /* border: 1px solid black; */
        }

        #profile > #prf_head > #prf_head_info {
            display: inline-block;
            
            font-weight: bold;
            font-size: 1.4rem;

            position: absolute;
            top: 50px;
            left: 30px;
        }

       
        /* 랭크 */
        #profile > #prf_head > #rnk {
            width: 75px;
            height: 75px;
            display: inline-block;

            position: absolute;
            right: 50px;
            top: 20px;
        }

        #rnk > img {
            display: block;
            width: 75px;
            height: 75px;
            margin: 10px auto;
        }

        #rnk > div {
            display: block;
            text-align: center;
        }

        /* 프로필 내용 */
        .prf_box {
            /* border: 1px solid black; */
            width: 180px;
            height: 130px;
            border-radius: 10px;
            background-color: #EEE;
        }

        .prf_box > div:nth-child(1) {
            font-weight: bold;
            text-align: center;
            font-size: 0.8rem;
            margin-top: 20px;
            
        }

        .prf_box > div:nth-child(2) {
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
            margin-top: 30px;
        }

        .prf_box:nth-child(2) {
            position: absolute;
            top: 150px;
            left: 45px;

            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .prf_box:nth-child(3) {
            position: absolute;
            top: 150px;
            right: 45px;

            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .prf_box:nth-child(4) {
            position: absolute;
            top: 300px;
            left: 45px;

            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .prf_box:nth-child(5) {
            position: absolute;
            top: 300px;
            right: 45px;

            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }



        #today_exercise {
        	width: 256px;
        	height: 245px;
        	background-color: white;
        	/* border: 1px solid black; */
        	border-radius: 10px;
        	margin: 3px 3px;

            position: relative;
            top: 0;
            left: 0;
            

        }

        .dash_subject {
            display: inline-block;
            width: 150px;
            font-size: 1.1rem;
            font-weight: bold;
            padding-left: 10px;
            padding-top: 5px;
            /* border: 1px solid black; */

        }
        
        .dash_subject_wide {
            display: inline-block;
            width: 200px;
            font-size: 1.1rem;
            font-weight: bold;
            padding-left: 10px;
            padding-top: 5px;
            /* border: 1px solid black; */

        }

        .dot_btn_group {
            display: inline-block;
            /* border: 1px solid black; */
            position: absolute;
            padding-right: 10px;
            padding-top: 3px;
            right: 0;
            top: 0;
            
        }
        .dot_btn {
            
            width: 10px;
            height: 10px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 0;
        }

        .card_mid_subj {
            /* border: 1px solid black; */
            padding-top: 10px;
            padding-left: 25px;
            padding-bottom: 10px;
            font-weight: bold;
            font-size: 1.08rem;
        }

        .mid_part {
            width: 256px;
            height: 120px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            
        }
        
        .mid_part_empty {
            width: 256px;
            height: 164px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            text-align: center;
        }
        

        .prgres_chart {
            width: 70px;
            height: 70px;
            /* border: 1px solid black; */

            margin-left: 10px;

            position: relative;
            display: inline-block;
            border-radius: 50%;
            transition: 0.3s;
        }

        .chart_center {
            background: #fff;
            display : block;
            position: absolute;
            top:50%; left:50%;
            width:40px; height:40px;
            border-radius: 50%;
            text-align:center; 
            line-height: 100px;
            font-size:1rem;
            transform: translate(-50%, -50%);
        }
        
        

        .hist_content {    
            /* border: 1px solid black; */
            width: 150px;
            height: 120px;
            margin-right:10px;
            padding: 3px 5px;

            display: flex;
            flex-wrap: wrap;
            font-size: 0.9rem;
            overflow: auto;
            
        }
        
        .hist_content > div {
            display: block;
            margin: 1px 5px;
            
        }
        
        
        .hist_content_wide {
        	/* border: 1px solid black; */
            width: 230px;
            height: 80px;
            padding: 5px 5px;
            
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            font-size: 0.9rem;
            overflow: auto;
            
        }
		.hist_content_wide > .tdy_diet_food_list {
			width: 100%;
			padding-left: 40px;
			display: block;
            
            text-align: left;
            
		}
		

        #today_diet {
         	width: 256px;
        	height: 245px;
        	background-color: white;
        	/* border: 1px solid black; */
        	border-radius: 10px;
        	margin: 3px 3px;
        }
        #current_exercise {
         	width: 256px;
        	height: 245px;
        	background-color: white;
        	/* border: 1px solid black; */
        	border-radius: 10px;
        	margin: 3px 3px;
        }
        #current_diet {
        	width: 256px;
        	height: 245px;
        	background-color: white;
        	/* border: 1px solid black; */
        	border-radius: 10px;
        	margin: 3px 3px;
        }
        #intake_diagram {

        	background-color: white;
        	/* border: 1px solid black; */
        	border-radius: 10px;
            grid-column-end: span 4;
            grid-row-end: span 4;
            
            margin-top: 20px;
            margin-bottom: 20px;
            
            padding-bottom:20px;
            
        }

        .bottom_part {
            /* border: 1px solid black; */
            
            display: flex;
            justify-content: space-around;
            align-items: center;
            width: 256px;
            height: 50px;
            

            font-weight: bold;
        }

        .card_btn {
            display: inline-block;
            width: 120px;
            height: 30px;
            border: 1px solid black;
            border-radius: 10px;
            
        }
        
        .card_btn_wide {
            display: inline-block;
            width: 200px;
            height: 30px;
            border: 1px solid black;
            border-radius: 10px;
            
        }
        
        .dash_chart_top {
        	display: flex;
        	justify-content: space-between;
        	margin: 10px 10px;
        }
        
        #intake_diagram .dash_progress_bar {
        	width: 1000px;
		    height: 20px;
		    background-color: #dedede;
		    font-weight: 600;
		    font-size: .8rem;
		    border-radius: 5px;
		    margin: 5px 10px; 
        }
        
		.dash_progress_bar .dash_progress {
			/* 퍼센티지 값 */
			/* width: 72%; */
			max-width: 100%;
		    height: 20px;
		    padding: 0;
		    text-align: center;
		    background-color: #4F98FF;
		    color: #111;
		    border-radius: 5px;
		}
		
		.dash_dot_wrap {
			width: auto;
			height: 35px;
			position: absolute;
			right: 0;
			top: 0;
			display: flex;
			justify-content: center;
			align-items: center;
			/* background: rgb(0, 0, 0, 0.2); */
		}
		
		.dash_dot_wrap ul li {
			width: 7px;
			height: 7px;
			background-color: #94aef4;
			border-radius: 50px;
			float: left;
			margin: 0 2px;
			transition: all 0.5s ease;
		}
		
		.dash_dot_wrap ul li.active {
			width: 20px;
			background-color: #94aef4;
		}
		
		.dash_dot_wrap ul li a {
			font-size: 0;
			width: 100%;
			height: 100%;
			float: left;
		}

		#open_popup_btn {
			position: absolute;
			bottom: 10px;
			right: 10px;
			width: 200px;
            height: 30px;
            border: 1px solid black;
            border-radius: 10px;
            
		}
		
		.popup {
			/* display: grid; */
			display:none;
			grid-template-columns: 1fr;
		    grid-template-rows: 90px 300px 50px;
		    
			border: 1px solid black;
			background-color: white;
			width: 790px;
			height: 480px;
			position: fixed;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
			z-index: 1001;
			
		}
		

		.popup_close {
			position: absolute;
			top: 10px;
			right: 15px;
			font-size: 20px;
			cursor: pointer;
		}
		
		.modal-backdrop {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background: rgba(0, 0, 0, 0.5);
			z-index: 1000;
		}
		
		#popup_head {
			/* border: 1px solid black; */
			height: 90px;
			
		}
		
		#popup_head > h2 {
			/* border: 1px solid black; */
			margin: 10px;
			font-weight: bold;
		}
		
		#popup_head > div:nth-child(2) {
			/* border: 1px solid black; */
			margin: 10px;
		}
		
		#popup_head > div:nth-child(2) > input {
			border: 1px solid black;
			border-radius: 3px;
		}
		
		#popup_head > div:nth-child(3) {
			display: none;
			margin: 10px;
		}
		
		.popup_in_btn {
			display: inline-block;
            width: 120px;
            height: 30px;
            border: 1px solid black;
            border-radius: 10px;
            margin: 5px;
		}

		#popup_content {
			overflow: auto;
			height: 300px;
			position: relative;
			top: 0;
			left: 0;
		}
		#physical_hist_tbl {
			border: 1px solid black;
			border-radius: 5px;
			margin: 10px auto; 
			width: 500px;
			text-align: center;
		}
		#physical_hist_tbl th:nth-child(1){
			width: 200px;
		}
		#physical_hist_tbl th:nth-child(2), #physical_hist_tbl th:nth-child(3){
			width: 100px;
		}
		
		#physical_hist_tbl th, #physical_hist_tbl td {
			border: 1px solid black;
			
		}
		
		#popup_bottom {
			position: relative;
			top: 0;
			left: 0;
			/* border: 1px solid black; */
			display: flex;
			justify-content: right;
		}
		
		#physical_hist_div {
			overflow: auto;
		}
		
		#physical_hist_input {
			display: none;
			width: 300px;
			height: 120px;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -90%);
			
			
		}
		
		#physical_hist_input > div:nth-child(1) {
			display: flex;
			flex-direction:column;
			
			align-items: center;
			justify-content: space-around;
			
			border: 1px solid black;
			border-radius: 5px;
			margin: 10px;
			padding: 10px;
			width: 300px;
			height: 120px;
			
			
		}
		
		#physical_hist_input > div:nth-child(1) > div {
			
			display:flex;
			justify-content: space-around;
			padding: 5px auto;
			
		}
		
		
		#physical_hist_input > div:nth-child(1) span {
			display: inline-block;
			text-align: right;
			width: 80px;
			height: 30px;
			/* border: 1px solid black; */
			
		}
		
		#physical_hist_input > div:nth-child(1) input {
			border: 1px solid black;
			border-radius: 5px;
			width: 100px;
			height: 30px;
			flex-basis: 50%;
			flex-grow: 50%;
			
		}

		
		#physical_hist_input button {
			display: block;
			width: 200px;
            height: 30px;
            border: 1px solid black;
            border-radius: 10px;
            margin: 5px auto;
            
		}
		
		#popup_bottom button#view_hist_btn {
			display: none;
		   
		}
		#rnk_name {
			font-size: 1.2rem;
			font-weight: bold;
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
			    <%-- <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %> --%>
			    <%@ include file="/WEB-INF/views/common/left_menu_mypage.jsp" %>
		</div>
		
		<div class="grid_center">
		
			<div class="grid_center_L"></div>
			
			<div class="grid_center_R">
				<!-- 컨텐츠페이지 -->
				<script src="https://kit.fontawesome.com/0c27eb5545.js" crossorigin="anonymous"></script>
			    <main id="dashboard">
			        <div id="profile">
			            <div id="prf_head">
			                <div id="prf_head_info">${dto.userName}님의 신체 정보</div>
			                <div id="rnk">
			                    <img id="rnk_img" src="/fitralpark/assets/images/icon/${rank}.png">
			                    <div id="rnk_name">${rank}</div>
			                </div>
			            </div>
			            <div class="prf_box">
			                <div>키(cm)</div>
			                <div>${dto.height}</div>
			            </div>
			            <div class="prf_box">
			                <div>성별</div>
			                <div>${dto.gender eq "m" ? "남성" : "여성"}</div>
			            </div>
			            <div class="prf_box">
			                <div>체중(kg)</div>
			                <div>${dto.weight}</div>
			            </div>
			            <div class="prf_box">
			                <div>나이</div>
			                <div>만 ${dto.age}세</div>
			            </div>
			            <button id="open_popup_btn">신체기록 등록/보기</button>
			        </div>
			        <div id="today_exercise">
				        <div class="dash_subject">오늘의 운동</div>
				        <div class="dash_dot_wrap">
	                        <ul>
								<c:if test="${dto.tdyExcsList.size() gt 0}">
									<c:forEach begin="0" end="${dto.tdyExcsList.size() - 1}" var="i">
										
										<li class=""><a href="#!" onclick="pos_list_btn(0, 'today_exercise', ${i})">${i+1}</a></li>
										<%-- <li class=""><a href="#!" onclick="pos_list_btn(${dto.tdyExcsList[i].processivity},'today_exercise', ${i})">${i+1}</a></li> --%>
										<!-- <li class=""><a href="#!" onclick="pos_list_btn(1)">2</a></li>
										<li class=""><a href="#!" onclick="pos_list_btn(2)">3</a></li>
										<li class=""><a href="#!" onclick="pos_list_btn(3)">4</a></li>
										<li class=""><a href="#!" onclick="pos_list_btn(4)">5</a></li>
										<li class=""><a href="#!" onclick="pos_list_btn(5)">6</a></li>
										<li class=""><a href="#!" onclick="pos_list_btn(6)">7</a></li> -->
									</c:forEach>
								</c:if>
	                        </ul>
                    	</div>
                    	<c:if test="${dto.tdyExcsList.size() gt 0}">
					        <c:forEach var="item" items="${dto.tdyExcsList}">
					        	<div class="dash_content_part" style="display: none;" data-crttype="${item.excsCrtType}" data-excsno="${item.excsNo}">
						        	<div id="tdy_excs_nm" class="card_mid_subj">${item.exerciseName}</div>
							        <div class="mid_part">
							            <div class="hist_content">
							            	<c:if test="${not empty item.ining}">
								                <div class="ining">
								                    <i class="fa-solid fa-arrow-right"></i> <span>${item.ining}</span>회
								                </div>
							                </c:if>
							                <c:if test="${not empty item.set}">
								                <div class="sets">
								                    <i class="fa-solid fa-arrow-right"></i> <span>${item.set}</span>세트
								                </div>
							                </c:if>
							                <c:if test="${not empty item.load}">
								                <div class="load">
								                    <i class="fa-solid fa-arrow-right"></i> <span>${item.load}</span>kg
								                </div>
							                </c:if>
							                <c:if test="${not empty item.times}">
							                	<div class="times">
								                    <i class="fa-solid fa-arrow-right"></i> <span>${item.times}</span>min
								                </div>
							                </c:if>
							            </div>
							        </div>
						        </div>
					        </c:forEach>
					        <div class="bottom_part">
					            <button class="card_btn" onclick="location.href='/fitralpark/exerciseList.do';">운동 등록/수정</button>
					            <button class="card_btn" onclick="do_record('today_exercise');">운동 완료</button>
					        </div>
				        </c:if>
				        <c:if test="${dto.tdyExcsList.size() le 0}">
				        	<div class="mid_part_empty">등록된 운동이 없습니다.<br>운동을 등록해주세요.</div>
				        	<div class="bottom_part">
				        		<button class="card_btn_wide" onclick="location.href='/fitralpark/exerciseList.do';">운동 등록</button>
				        	</div>
				        </c:if>
			        </div>
			        
			        <div id="today_diet">
			            <div class="dash_subject">오늘의 식사</div>
						<div class="dash_dot_wrap">
	                        <ul>
	                        	<c:if test="${dto.tdyDietList.size() gt 0}">
									<c:forEach begin="0" end="${dto.tdyDietList.size() - 1}" var="i">
										<li class=""><a href="#!" onclick="pos_list_btn(0, 'today_diet', ${i})">${i+1}</a></li>
									</c:forEach>
								</c:if>
	                        </ul>
                    	</div>
                    	<c:if test="${dto.tdyDietList.size() gt 0}">
	                    	<c:forEach var="item" items="${dto.tdyDietList}">
	                    		<div class="dash_content_part" style="display: none;" data-dietno="${item.dietNo}">
							        <div id="tdy_diet_nm"  class="card_mid_subj">${item.mealClassify}</div>
							        <div class="mid_part">
							            <div class="hist_content_wide">
							            	<c:forEach var="food" items="${item.foodList}">
								                <div class="tdy_diet_food_list" data-crttype="${food.foodCreationType}" data-foodno="${food.foodNo}">
								                    <i class="fa-solid fa-arrow-right"></i> ${food.foodName} <span>${food.intake}</span>g
								                </div>
							                </c:forEach>
							            </div>
							        </div>
						        </div>
					        </c:forEach>
					        <div class="bottom_part">
					            <button class="card_btn"  onclick="location.href='/fitralpark/dietRecommend.do';">식단 등록/수정</button>
					            <button class="card_btn" onclick="do_record('today_diet');">식사 완료</button>
					        </div>
				        </c:if>
				        <c:if test="${dto.tdyDietList.size() le 0}">
				        	<div class="mid_part_empty">등록된 식단이 없습니다.<br>식단을 등록해주세요.</div>
				        	<div class="bottom_part">
				        		<button class="card_btn_wide" onclick="location.href='dietRecommend.do';">식단 등록</button>
				        	</div>
				        </c:if>
				        
			        </div>
			        <div id="current_exercise">
			            <div class="dash_subject">최근 운동 기록</div>
			            <div class="dash_dot_wrap">
	                        <ul>
	                        	<c:if test="${dto.crtExcsList.size() gt 0}">
									<c:forEach begin="0" end="${dto.crtExcsList.size() - 1}" var="i">
										<li class=""><a href="#!" onclick="pos_list_btn(${ not empty dto.crtExcsList[i].processivity ? dto.crtExcsList[i].processivity : 0},'current_exercise', ${i})">${i+1}</a></li>
									</c:forEach>
								</c:if>
	                        </ul>
                    	</div>
                    	<c:if test="${dto.crtExcsList.size() gt 0}">
	                    	<c:forEach var="item" items="${dto.crtExcsList}">
		                    	<div class="dash_content_part" style="display: none;">
							        <div id="crt_excs_date" class="card_mid_subj">${item.regdate}</div>
							        <div class="mid_part">
							            <div class="prgres_chart">
							                <span class="chart_center">${ not empty item.processivity ? item.processivity : 0 }%</span>
							            </div>
							            <div class="hist_content">
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>총 운동계획: </span><span>${item.totalPlanCnt}회</span> 
							                </div>
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>완료: </span><span>${item.completePlanCnt}회</span>
							                </div>
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>미완료: </span><span>${item.incompletePlanCnt}회</span>
							                </div>
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>계획외 운동: </span><span>${item.unplanCnt}회</span>
							                </div>
							            </div>
							        </div>
						        </div>
					        </c:forEach>
					        <div class="bottom_part">
					            <button id="" class="card_btn_wide" onclick="location.href='#!';">더 많은 기록 보러가기</button>
					        </div>
				        </c:if>
				        <c:if test="${dto.crtExcsList.size() le 0}">
				        	<div class="mid_part_empty">최근 등록된<br>운동기록이 없습니다.</div>
				        	<div class="bottom_part">
				        		<button id="" class="card_btn_wide" onclick="location.href='#!';">더 많은 기록 보러가기</button>
				        	</div>
				        </c:if>
				        
			        </div>
			        <div id="current_diet">
			            <div class="dash_subject">최근 식사 기록</div>
			            <div class="dash_dot_wrap">
	                        <ul>
	                        	<c:if test="${dto.crtdietList.size() gt 0}">
									<c:forEach begin="0" end="${dto.crtdietList.size() - 1}" var="i">
										<li class=""><a href="#!" onclick="pos_list_btn(${not empty dto.crtdietList[i].processivity ? dto.crtdietList[i].processivity : 0}, 'current_diet', ${i})">${i+1}</a></li>
									</c:forEach>
								</c:if>
	                        </ul>
                    	</div>
                    	<c:if test="${dto.crtdietList.size() gt 0}">
	                    	<c:forEach var="item" items="${dto.crtdietList}">
		                    	<div class="dash_content_part" style="display: none;">
							        <div id="crt_diet_date" class="card_mid_subj">${item.regdate}</div>
							        <div class="mid_part">
							            <div class="prgres_chart">
							                <span class="chart_center">${not empty item.processivity ? item.processivity : 0}%</span>
							            </div>
							            <div class="hist_content">
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>총 식사계획: </span><span>${item.totalPlanCnt}회</span> 
							                </div>
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>완료: </span><span>${item.completePlanCnt}회</span>
							                </div>
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>미완료: </span><span>${item.incompletePlanCnt}회</span>
							                </div>
							                <div>
							                    <i class="fa-solid fa-arrow-right"></i><span>계획외 식사: </span><span>${item.unplanCnt}회</span>
							                </div>
							            </div>
							        </div>
						        </div>
					        </c:forEach>
					        <div class="bottom_part">
					            <button id="" class="card_btn_wide" onclick="location.href='#!';">더 많은 기록 보러가기</button>
					        </div>
				        </c:if>
				        <c:if test="${dto.crtdietList.size() le 0}">
				        	<div class="mid_part_empty">최근 등록된<br>식사기록이 없습니다.</div>
				        	<div class="bottom_part">
				        		<button id="" class="card_btn_wide" onclick="location.href='#!';">더 많은 기록 보러가기</button>
				        	</div>
				        </c:if>
			        </div>
			        <c:if test="${dto.tdyintake ne null}">
				        <div id="intake_diagram">
				            <div class="dash_subject_wide">하루 영양소 섭취량</div>
				            <div id="ntrt_calorie">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	열량 (<span class="intake_ntrt">${dto.tdyintake.ntrt_calorie}</span> / <span class="required_ntrt">2700</span>) <span>kcal</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
					            </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
	
				            </div>
				            <div id="ntrt_chocdf">
				            	<div class="dash_chart_top">
					            	<div class="dash_ntrt_chart_subject">
					            		탄수화물 (<span class="intake_ntrt">${dto.tdyintake.ntrt_chocdf}</span> / <span class="required_ntrt">324</span>) <span>g</span>
					            	</div>
					            	<div class="dash_ntrt_chart_percent">90%</div>
					            </div>
				            	<div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_prot">
				            	<div class="dash_chart_top">
					            	<div class="dash_ntrt_chart_subject">
					            		단백질 (<span class="intake_ntrt">${dto.tdyintake.ntrt_prot}</span> / <span class="required_ntrt">55</span>) <span>g</span>
					            	</div>
					            	<div class="dash_ntrt_chart_percent">0%</div>
					            </div>
				            	<div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_fatce">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	지방 (<span class="intake_ntrt">${dto.tdyintake.ntrt_fatce}</span> / <span class="required_ntrt">54</span>) <span>g</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_sugar">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	당류 (<span class="intake_ntrt">${dto.tdyintake.ntrt_sugar}</span> / <span class="required_ntrt">100</span>) <span>g</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
					        </div>
					        <div id="ntrt_fibtg">
					        	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	식이섬유 (<span class="intake_ntrt">${dto.tdyintake.ntrt_fibtg}</span> / <span class="required_ntrt">25</span>) <span>g</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_ca">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	칼슘 (<span class="intake_ntrt">${dto.tdyintake.ntrt_ca}</span> / <span class="required_ntrt">700</span>) <span>mg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
					        </div>
					        <div id="ntrt_nat">
					        	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	나트륨 (<span class="intake_ntrt">${dto.tdyintake.ntrt_nat}</span> / <span class="required_ntrt">2000</span>) <span>mg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_vitaRae">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	비타민A (<span class="intake_ntrt">${dto.tdyintake.ntrt_vitaRae}</span> / <span class="required_ntrt">700</span>) <span>μg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
					        </div>
					        <div id="ntrt_thia">
					        	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	비타민B1 (<span class="intake_ntrt">${dto.tdyintake.ntrt_thia}</span> / <span class="required_ntrt">1.2</span>) <span>mg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_ribf">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	비타민B2 (<span class="intake_ntrt">${dto.tdyintake.ntrt_ribf}</span> / <span class="required_ntrt">1.4</span>) <span>mg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_nia">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	비타민B3 (<span class="intake_ntrt">${dto.tdyintake.ntrt_nia}</span> / <span class="required_ntrt">15</span>) <span>mg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						       	</div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_vitc">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	비타민C (<span class="intake_ntrt">${dto.tdyintake.ntrt_vitc}</span> / <span class="required_ntrt">100</span>) <span>mg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				            <div id="ntrt_vitd">
				            	<div class="dash_chart_top">
						            <div class="dash_ntrt_chart_subject">
						            	비타민D (<span class="intake_ntrt">${dto.tdyintake.ntrt_vitd}</span> / <span class="required_ntrt">10</span>) <span>μg</span>
						            </div>
						            <div class="dash_ntrt_chart_percent">80%</div>
						        </div>
					            <div class="dash_progress_bar">
					            	<div class="dash_progress"></div>
					            </div>
				            </div>
				             
				        </div>
			        </c:if>
			    </main>

    			
			</div>
			
		</div>
		
		
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>
	<div id="modalBackdrop" class="modal-backdrop"></div>
	<div id="popup_physical_hist" class="popup">
		<div id="popup_head">
			<h2>신체 기록</h2>
			<div>원하시는 월을 선택해주세요: <input id="hist_month" type="month"><button id="get_hist_btn" class="popup_in_btn" required>조회하기</button></div>
			<div>각 항목에 맞는 정보를 입력해주세요.</div>
		</div>
		<div id="popup_content">
			<div id="physical_hist_div">
				<table id="physical_hist_tbl">

				</table>
			</div>
			<div id="physical_hist_input">
				<div>
					<div><span> 키: </span><input type="number" id="input_height" min="0" max="300"></div>
					<div><span> 몸무게: </span><input type="number" id="input_weight" min="0" max="200"></div>
				</div>
				<div><button id="hist_input_btn">저장하기</button></div>
				
			</div>
		</div>
		<div id="popup_bottom">
			<button id="put_hist_btn" class="popup_in_btn" onclick="physical_info_regist();">기록 등록하기</button>
			<button id="view_hist_btn" class="popup_in_btn" onclick="physical_info_view();">기록 확인하기</button>			
			<button id="close_popup_btn" class="popup_in_btn">닫기</button>
		</div>
	</div>

	<script>
		// 모든 메뉴 항목을 선택
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
	    });
		
	
		document.getElementById('open_popup_btn').addEventListener('click', function() {
		    document.getElementById('popup_physical_hist').style.display = 'grid';
		    document.getElementById("modalBackdrop").style.display = "block"; // 배경 활성화
		    document.body.style.overflow = "hidden"; // 스크롤 방지
		    
		    $('#popup_content > #physical_hist_div').css('display', 'block');
    		$('#popup_content > #physical_hist_input').css('display', 'none');
		});
		
		document.getElementById('close_popup_btn').addEventListener('click', function() {
		    document.getElementById('popup_physical_hist').style.display = 'none';
		    document.getElementById("modalBackdrop").style.display = "none"; // 배경 숨김
		    document.body.style.overflow = "auto"; // 스크롤 다시 활성화
		});
		
		$('#popup_close_btn').click(function(){
			document.getElementById('popup_physical_hist').style.display = 'none';
		    document.getElementById("modalBackdrop").style.display = "none"; // 배경 숨김
		    document.body.style.overflow = "auto"; // 스크롤 다시 활성화
		});
		
		
	
		const colorname='#115500';
		const max = 100;
		const classname = '.prgres_chart';
		$(window).ready(function() {
			//test
			console.log(${dto.crtExcsList[0].processivity});
			
			
			/* 퍼센티지: 첫번째 인자 */
		    //draw(70, '.prgres_chart', '#ccc');
			//초기 페이지
			if (${dto.tdyExcsList.size() gt 0}) {
				$('#today_exercise .dash_dot_wrap ul li a').eq(0).trigger("click");
				$('#today_exercise .dash_dot_wrap ul li').eq(0).addClass("active");
			}
			if (${dto.tdyDietList.size() gt 0}) {
				$('#today_diet .dash_dot_wrap ul li a').eq(0).trigger("click");
				$('#today_diet .dash_dot_wrap ul li').eq(0).addClass("active");
			}
			
			if (${dto.crtExcsList.size() gt 0}) {
				$('#current_exercise .dash_dot_wrap ul li a').eq(0).trigger("click");
				$('#current_exercise .dash_dot_wrap ul li').eq(0).addClass("active");
			}
			
			if (${dto.crtdietList.size() gt 0}) {
				$('#current_diet .dash_dot_wrap ul li a').eq(0).trigger("click");
				$('#current_diet .dash_dot_wrap ul li').eq(0).addClass("active");
			}
			
			
			/* 
			$('#today_exercise .dash_dot_wrap ul li').eq(0).addClass("active");
			$('#today_exercise .dash_content_part').eq(0).css('display', 'block');
			$('#today_diet .dash_dot_wrap ul li').eq(0).addClass("active");
			$('#today_diet .dash_content_part').eq(0).css('display', 'block');
			$('#current_exercise .dash_dot_wrap ul li').eq(0).addClass("active");
			$('#current_exercise .dash_content_part').eq(0).css('display', 'block');
			$('#current_diet .dash_dot_wrap ul li').eq(0).addClass("active");
			$('#current_diet .dash_content_part').eq(0).css('display', 'block'); 
			*/
			
			
			
		});
		
		/* 퍼센티지: 첫번째 인자 */
		function draw(max, menu, colorname){
			var i=1;
			var func1 = setInterval(function() {
			    if(i < max){
			        color1(i, menu, colorname);
			        i++;
			    } else{
			        clearInterval(func1);
			    }
			}, 10);
		}
		function color1(i, menu, colorname){
		    $('#' + menu + ' .prgres_chart').css({
		            "background": "conic-gradient(" + colorname + " 0% " + i + "%, #ffffff " + i + "% 100%)"
		    });
		}
       
       function pos_list_btn(processivity, menu, i) {
    	   console.log('processivity: ',processivity);
    	   console.log('menu: ',menu);
    	   console.log('i: ',i);
			if(processivity == null) {
				processivity = 0;
			}

   			if(menu == 'current_exercise' || menu == 'current_diet' ) {
   				draw(processivity, menu, '#ccc');
   			}
    	   
    		//clearInterval(cn_bn);
    		$('#' + menu + ' .dash_content_part').eq(i).css('display', 'block');
    		$('#' + menu + ' .dash_content_part').not(':eq('+ i + ')').css('display', 'none');
    		
    		//$(".dash_dot_wrap ul li").eq(i).addClass("active");
    		$(event.target.parentElement).addClass("active");
    		
    		//$(".dash_dot_wrap ul li").eq(i).siblings().removeClass("active");
    		$(event.target.parentElement).siblings().removeClass("active");
    		
    		//cn_bn = setInterval(() => cash_bn(), interTime);
    		//main_cash_bn_idx = i;
    	}
       
 			
		
		function physical_info_regist() {
			$('#popup_content > #physical_hist_div').css('display', 'none');
    		$('#popup_content > #physical_hist_input').css('display', 'block');
    		$('#popup_bottom button#put_hist_btn').css('display', 'none');
    		$('#popup_bottom button#view_hist_btn').css('display', 'block');
    		
    		
    		$('#popup_head > div:nth-child(2)').css('display', 'none');
    		$('#popup_head > div:nth-child(3)').css('display', 'block');
    		
    		
		}
		
		function physical_info_view() {
			$('#popup_content > #physical_hist_div').css('display', 'block');
    		$('#popup_content > #physical_hist_input').css('display', 'none');
    		$('#popup_bottom button#put_hist_btn').css('display', 'block');
    		$('#popup_bottom button#view_hist_btn').css('display', 'none');
    		
    		
    		$('#popup_head > div:nth-child(2)').css('display', 'block');
    		$('#popup_head > div:nth-child(3)').css('display', 'none');
		}
		
		$('#get_hist_btn').click(() => {
			console.log($('#hist_month').val(),Object.prototype.toString.call($('#hist_month').val()));
			
			if($('#hist_month').val() == '') {
				alert('값을 입력해주세요.');
				return false;
			}
			
		 	$.ajax({
				type: 'GET',
				url: '/fitralpark/dashphysicalinfo.do',
				data: {
					id: '${id}',
					month: $('#hist_month').val().replace('-', '')
				},
				dataType: 'json',
				success: function(result){
					console.log(result);
					
					$('#physical_hist_div').html('');
					
					$('#physical_hist_div').append('<table id="physical_hist_tbl">');
					$('#physical_hist_tbl').append(`<tr>
							<th>날짜</th>
							<th>키(cm)</th>
							<th>몸무게(kg)</th>
						</tr>
						`);
					result.forEach(item => {
						$('#physical_hist_tbl').append(`
								<tr>
									<td>\${item.regdate}</td>
									<td>\${item.height}</td>
									<td>\${item.weight}</td>
								</tr>
								`);
					});
					
				},
				error: function(a,b,c){
					console.log(a,b,c);
				} 
			});
		});
		
		$('#hist_input_btn').click(function() {
			$.ajax({
				type: 'GET',
				url: '/fitralpark/dashphysicalregist.do',
				data: {
					id: '${id}',
					height: $('#input_height').val(),
					weight: $('#input_weight').val()
				},
				dataType: 'json',
				success: function(result) {
					if(result == 1) {
						alert('성공적으로 저장되었습니다.');
					} else {
						alert('저장에 실패하였습니다.');
					}
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
		});
		
		function do_record(content_id) {
			if(content_id == 'today_exercise') {
				//console.log($('#today_exercise .dash_content_part[display="block"] .ining span').get(0));
				
				$.ajax({
					type: 'GET',
					url: '/fitralpark/dashrecordexcs.do',
					data: {
						id: '${id}',
						sets: $('#today_exercise .dash_content_part[style="display: block;"] .sets span').text(),
						reps_per_set: $('#today_exercise .dash_content_part[style="display: block;"] .ining span').text(),
						weight: $('#today_exercise .dash_content_part[style="display: block;"] .load span').text(),
						exercise_time: $('#today_exercise .dash_content_part[style="display: block;"] .times span').text(),
						exercise_no: $('#today_exercise .dash_content_part[style="display: block;"]').data('excsno'),
						exercise_creation_type: $('#today_exercise .dash_content_part[style="display: block;"]').data('crttype')
					},
					contentType: 'application/json',
					dataType: 'json',
					success: function(result) {
						if(result.result == 1) {
							alert('성공적으로 저장되었습니다.');
						} else if(result.result == 0) {
							alert('저장에 실패하였습니다.');
						} else {
							alert('이미 저장 되었습니다.');
						}
					},
					error: function(a,b,c) {
						console.log(a,b,c);
					}
				});
			} else if(content_id == 'today_diet') {
				
				
				let diet = new Object();
				let arrFood = [];
				
				$('#today_diet .dash_content_part[style="display: block;"] .tdy_diet_food_list').each((index, item) => {
					arrFood.push({
						food_creation_type: $(item).data('crttype'),
						food_no: $(item).data('foodno'),
						intake: $(item).find('span').text()
					});
				});
				diet.id = '${id}';
				diet.diet_no = $('#today_diet .dash_content_part[style="display: block;"]').data('dietno');
				diet.meal_classify = $('#today_diet .dash_content_part[style="display: block;"] #tdy_diet_nm').text();
				diet.arrFood = arrFood;
				
				console.log(diet);			
				
				$.ajax({
					type: 'POST',
					url: '/fitralpark/dashrecordintake.do',
					data: JSON.stringify(diet),
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					success: function(result) {
						console.log(result.result);
						
						if(result.result >= 1) {
							alert('성공적으로 저장되었습니다.');
						} else if(result.result == 0) {
							alert('저장에 실패하였습니다.');
						} else {
							alert('이미 저장 되었습니다.');
						}
					},
					error: function(a,b,c) {
						console.log(a,b,c);
					}
				});
			}
		}
		
		
	       
        //그래프 영양소 비율 변수
		let calorie_ratio = (Math.round(Number($('#ntrt_calorie > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_calorie > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let chocdf_ratio = (Math.round(Number($('#ntrt_chocdf > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_chocdf > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let prot_ratio = (Math.floor(Number($('#ntrt_prot > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_prot > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let fatce_ratio = (Math.round(Number($('#ntrt_fatce > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_fatce > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let sugar_ratio = (Math.round(Number($('#ntrt_sugar > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_sugar > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let fibtg_ratio = (Math.round(Number($('#ntrt_fibtg > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_fibtg > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let ca_ratio = (Math.round(Number($('#ntrt_ca > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_ca > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let nat_ratio = (Math.round(Number($('#ntrt_nat > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_nat > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let vitaRae_ratio = (Math.round(Number($('#ntrt_vitaRae > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_vitaRae > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let thia_ratio = (Math.round(Number($('#ntrt_thia > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_thia > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let ribf_ratio = (Math.round(Number($('#ntrt_ribf > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_ribf > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let nia_ratio = (Math.round(Number($('#ntrt_nia > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_nia > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let vitc_ratio = (Math.round(Number($('#ntrt_vitc > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_vitc > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		let vitd_ratio = (Math.round(Number($('#ntrt_vitd > .dash_chart_top > .dash_ntrt_chart_subject > span.intake_ntrt').text()) / Number($('#ntrt_vitd > .dash_chart_top > .dash_ntrt_chart_subject > span.required_ntrt').text()) * 1000) / 1000 * 100).toFixed(1) ;
		
		$('#ntrt_calorie > .dash_chart_top > .dash_ntrt_chart_percent').text(calorie_ratio + '%');
		$('#ntrt_chocdf > .dash_chart_top > .dash_ntrt_chart_percent').text(chocdf_ratio + '%');
		$('#ntrt_prot > .dash_chart_top > .dash_ntrt_chart_percent').text(prot_ratio + '%');
		$('#ntrt_fatce > .dash_chart_top > .dash_ntrt_chart_percent').text(fatce_ratio + '%');
		$('#ntrt_sugar > .dash_chart_top > .dash_ntrt_chart_percent').text(sugar_ratio + '%');
		$('#ntrt_fibtg > .dash_chart_top > .dash_ntrt_chart_percent').text(fibtg_ratio + '%');
		$('#ntrt_ca > .dash_chart_top > .dash_ntrt_chart_percent').text(ca_ratio + '%');
		$('#ntrt_nat > .dash_chart_top > .dash_ntrt_chart_percent').text(nat_ratio + '%');
		$('#ntrt_vitaRae > .dash_chart_top > .dash_ntrt_chart_percent').text(vitaRae_ratio + '%');
		$('#ntrt_thia > .dash_chart_top > .dash_ntrt_chart_percent').text(thia_ratio + '%');
		$('#ntrt_ribf > .dash_chart_top > .dash_ntrt_chart_percent').text(ribf_ratio + '%');
		$('#ntrt_nia > .dash_chart_top > .dash_ntrt_chart_percent').text(nia_ratio + '%');
		$('#ntrt_vitc > .dash_chart_top > .dash_ntrt_chart_percent').text(vitc_ratio + '%');
		$('#ntrt_vitd > .dash_chart_top > .dash_ntrt_chart_percent').text(vitd_ratio + '%');
		
		$('#ntrt_calorie .dash_progress_bar .dash_progress').css('width', calorie_ratio + '%');
		$('#ntrt_chocdf .dash_progress_bar .dash_progress').css('width', chocdf_ratio + '%');
		$('#ntrt_prot .dash_progress_bar .dash_progress').css('width', prot_ratio + '%');
		$('#ntrt_fatce .dash_progress_bar .dash_progress').css('width', fatce_ratio + '%');
		$('#ntrt_sugar .dash_progress_bar .dash_progress').css('width', sugar_ratio + '%');
		$('#ntrt_fibtg .dash_progress_bar .dash_progress').css('width', fibtg_ratio + '%');
		$('#ntrt_ca .dash_progress_bar .dash_progress').css('width', ca_ratio + '%');
		$('#ntrt_nat .dash_progress_bar .dash_progress').css('width', nat_ratio + '%');
		$('#ntrt_vitaRae .dash_progress_bar .dash_progress').css('width', vitaRae_ratio + '%');
		$('#ntrt_thia .dash_progress_bar .dash_progress').css('width', thia_ratio + '%');
		$('#ntrt_ribf .dash_progress_bar .dash_progress').css('width', ribf_ratio + '%');
		$('#ntrt_nia .dash_progress_bar .dash_progress').css('width', nia_ratio + '%');
		$('#ntrt_vitc .dash_progress_bar .dash_progress').css('width', vitc_ratio + '%');
		$('#ntrt_vitd .dash_progress_bar .dash_progress').css('width', vitd_ratio + '%');
		
 		
   </script>
    



</body>
</html>