<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
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
            height: 80px;
            margin-right:10px;
            padding: 3px 5px;

            display: flex;
            flex-wrap: wrap;
            font-size: 0.9rem;
            
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
            
        }
		.hist_content_wide > div {
			flex-basis: 40%;
			flex-grow: 1;
			display: block;
            
            text-align: center;
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
			width: 72%;	/* 퍼센티지 값 */
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
				<script src="https://kit.fontawesome.com/0c27eb5545.js" crossorigin="anonymous"></script>
			    <main id="dashboard">
			        <div id="profile">
			            <div id="prf_head">
			                <div id="prf_head_info">홍길동님의 신체 정보</div>
			                <div id="rnk">
			                    <img id="rnk_img" src="/fitralpark/assets/images/rank/beginner.png">
			                    <div id="rnk_name">beginner</div>
			                </div>
			            </div>
			            <div class="prf_box">
			                <div>키(cm)</div>
			                <div>182.1</div>
			            </div>
			            <div class="prf_box">
			                <div>성별</div>
			                <div>남성</div>
			            </div>
			            <div class="prf_box">
			                <div>체중(kg)</div>
			                <div>65.7</div>
			            </div>
			            <div class="prf_box">
			                <div>나이</div>
			                <div>만 20세</div>
			            </div>
			        </div>
			        <div id="today_exercise">
				        <div class="dash_subject">오늘의 운동</div>
				        <div class="dash_dot_wrap">
	                        <ul>
	                           <li class="active"><a href="#!" onclick="pos_list_btn(0)">1</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(1)">2</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(2)">3</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(3)">4</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(4)">5</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(5)">6</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(6)">7</a></li>
	                        </ul>
                    	</div>
				        <div id="tdy_excs_nm" class="card_mid_subj">스쿼트</div>
				        
				        <div class="mid_part">
				            <div class="prgres_chart">
				                <span class="chart_center">80%</span>
				            </div>
				            <div class="hist_content">
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i> 10회
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i> 3세트
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i> 50kg
				                </div>
				            </div>
				        </div>
				        <div class="bottom_part">
				            <button id="" class="card_btn">운동 등록/수정</button>
				            <button id="" class="card_btn">운동 완료</button>
				        </div>
			        </div>
			        
			        <div id="today_diet">
			            <div class="dash_subject">오늘의 식사</div>
						<div class="dash_dot_wrap">
	                        <ul>
	                           <li class="active"><a href="#!" onclick="pos_list_btn(0)">1</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(1)">2</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(2)">3</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(3)">4</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(4)">5</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(5)">6</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(6)">7</a></li>
	                        </ul>
                    	</div>
				        <div id="tdy_diet_nm"  class="card_mid_subj">아침식사</div>
				        
				        <div class="mid_part">
				            
				            <div class="hist_content_wide">
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i> 닭가슴살
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i> 샐러드
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i> 바나나
				                </div>
				            </div>
				        </div>
				        <div class="bottom_part">
				            <button id="" class="card_btn">식단 등록/수정</button>
				            <button id="" class="card_btn">식사 완료</button>
				        </div>
			        </div>
			        <div id="current_exercise">
			            <div class="dash_subject">최근 운동 기록</div>
			            <div class="dash_dot_wrap">
	                        <ul>
	                           <li class="active"><a href="#!" onclick="pos_list_btn(0)">1</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(1)">2</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(2)">3</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(3)">4</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(4)">5</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(5)">6</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(6)">7</a></li>
	                        </ul>
                    	</div>
				        <div id="crt_excs_date" class="card_mid_subj">2025.03.17. (월)</div>
				        
				        <div class="mid_part">
				            <div class="prgres_chart">
				                <span class="chart_center">80%</span>
				            </div>
				            <div class="hist_content">
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i><span>총 운동계획: </span><span>30회</span> 
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i><span>완료: </span><span>20회</span>
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i><span>미완료: </span><span>10회</span>
				                </div>
				            </div>
				        </div>
				        <div class="bottom_part">
				            <button id="" class="card_btn_wide">더 많은 기록 보러가기</button>
				        </div>
			        </div>
			        <div id="current_diet">
			            <div class="dash_subject">최근 식사 기록</div>
			            <div class="dash_dot_wrap">
	                        <ul>
	                           <li class="active"><a href="#!" onclick="pos_list_btn(0)">1</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(1)">2</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(2)">3</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(3)">4</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(4)">5</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(5)">6</a></li>
	                           <li class=""><a href="#!" onclick="pos_list_btn(6)">7</a></li>
	                        </ul>
                    	</div>
				        <div id="crt_excs_date" class="card_mid_subj">2025.03.17. (월)</div>
				        
				        <div class="mid_part">
				            <div class="prgres_chart">
				                <span class="chart_center">80%</span>
				            </div>
				            <div class="hist_content">
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i><span>총 식사계획: </span><span>21회</span> 
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i><span>완료: </span><span>16회</span>
				                </div>
				                <div>
				                    <i class="fa-solid fa-arrow-right"></i><span>미완료: </span><span>5회</span>
				                </div>
				            </div>
				        </div>
				        <div class="bottom_part">
				            <button id="" class="card_btn_wide">더 많은 기록 보러가기</button>
				        </div>
			        </div>
			        <div id="intake_diagram">
			            <div class="dash_subject_wide">하루 영양소 섭취량</div>
			            
			            <div id="ntrt_calorie">
			            	<div class="dash_chart_top">
					            <div class="dash_ntrt_chart_subject">
					            	열량 (<span class="intake_ntrt">2600</span> / <span class="required_ntrt">2700</span>) <span>kcal</span>
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
				            		탄수화물 (<span class="intake_ntrt">400</span> / <span class="required_ntrt">324</span>) <span>g</span>
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
				            		단백질 (<span class="intake_ntrt">50</span> / <span class="required_ntrt">55</span>) <span>g</span>
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
					            	지방 (<span class="intake_ntrt">50</span> / <span class="required_ntrt">54</span>) <span>g</span>
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
					            	당류 (<span class="intake_ntrt">80</span> / <span class="required_ntrt">100</span>) <span>g</span>
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
					            	식이섬유 (<span class="intake_ntrt">30</span> / <span class="required_ntrt">25</span>) <span>g</span>
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
					            	칼슘 (<span class="intake_ntrt">750</span> / <span class="required_ntrt">700</span>) <span>mg</span>
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
					            	나트륨 (<span class="intake_ntrt">1900</span> / <span class="required_ntrt">2000</span>) <span>mg</span>
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
					            	비타민A (<span class="intake_ntrt">700</span> / <span class="required_ntrt">700</span>) <span>μg</span>
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
					            	비타민B1 (<span class="intake_ntrt">0</span> / <span class="required_ntrt">1.2</span>) <span>mg</span>
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
					            	비타민B2 (<span class="intake_ntrt">1.2</span> / <span class="required_ntrt">1.4</span>) <span>mg</span>
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
					            	비타민B3 (<span class="intake_ntrt">20</span> / <span class="required_ntrt">15</span>) <span>mg</span>
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
					            	비타민C (<span class="intake_ntrt">500</span> / <span class="required_ntrt">100</span>) <span>mg</span>
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
					            	비타민D (<span class="intake_ntrt">15</span> / <span class="required_ntrt">10</span>) <span>μg</span>
					            </div>
					            <div class="dash_ntrt_chart_percent">80%</div>
					        </div>
				            <div class="dash_progress_bar">
				            	<div class="dash_progress"></div>
				            </div>
			            </div>
			             
			        </div>
			        
			    </main>

    			
			</div>
			
		</div>
		
		
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>

	<script>
       const colorname='#115500';
       const max = 100;
       const classname = '.prgres_chart';
       $(window).ready(function(){
       	/* 퍼센티지: 첫번째 인자 */
           draw(80, '.prgres_chart', '#ccc');
       });

       function draw(max, classname, colorname){
           var i=1;
           var func1 = setInterval(function() {
               if(i<max){
                   color1(i,classname,colorname);
                   i++;
               } else{
                   clearInterval(func1);
               }
           },10);
       }
       function color1(i, classname,colorname){
           $(classname).css({
                   "background":"conic-gradient("+colorname+" 0% "+i+"%, #ffffff "+i+"% 100%)"
           });
       }
       
       function pos_list_btn(i) {
    		//clearInterval(cn_bn);
    		//$(".main_cash_con li").eq(i).fadeIn();
    		//$(".main_cash_con li").eq(i).siblings().fadeOut();
    		
    		
    		//$(".dash_dot_wrap ul li").eq(i).addClass("active");
    		$(event.target.parentElement).addClass("active");
    		
    		//$(".dash_dot_wrap ul li").eq(i).siblings().removeClass("active");
    		$(event.target.parentElement).siblings().removeClass("active");
    		
    		//cn_bn = setInterval(() => cash_bn(), interTime);
    		//main_cash_bn_idx = i;
    	}
       
       function cash_bn() {
    		const len = $(".main_cash_con li").length;

    		main_cash_bn_idx++;
    		if (main_cash_bn_idx >= len) {
    			main_cash_bn_idx = 0;
    		}
    		pos_list_btn(main_cash_bn_idx);
    	}
       
       //let cn_bn;
       //let interTime = 5000;
       /* 
       $(window).on('load', () => {
       	cn_bn = setInterval(() => cash_bn(), interTime);
       });
 		*/
   </script>
    



</body>
</html>