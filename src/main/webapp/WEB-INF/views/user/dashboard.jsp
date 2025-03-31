<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
	<!-- favicon.png" -->
	<%@ include file="/WEB-INF/views/common/asset.jsp" %>
    <style>
    	body {background-color: rgb(218, 243, 211);}
    	
    	#dashboard {
        	position: absolute;
        	/* top: 125px;
        	width: 1024px; */
            border: 1px solid black;

            display: grid;
            /* grid-template-columns: 100px 100px 100px 100px;
            grid-template-columns: 100px 100px 100px 100px; */
            grid-template-columns: 1fr 1fr 1fr 1fr;
            grid-template-rows: 1fr 1fr 1fr 1fr

        }

        /* 그리드 확인용 */
        main#dashboard > div {
            border: 1px solid black;
            position: relative;
            top: 0;
            left: 0;
        }

        
        #profile {
            grid-column-end: span 2;
            grid-row-end: span 2;

            background-color: white;
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
            border: 1px solid black;
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
            border: 1px solid black;
            width: 180px;
            height: 130px;
            border-radius: 10px;
            background-color: white;
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
        	border: 1px solid black;

            position: relative;
            top: 0;
            left: 0;

        }

        #today_exercise >.dash_subject {
            display: inline-block;
            width: 150px;
            font-size: 1.1rem;
            font-weight: bold;
            padding-left: 10px;
            padding-top: 5px;
            border: 1px solid black;

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

        #crt_excs_nm {
            border: 1px solid black;
            padding-top: 10px;
            padding-left: 25px;
            padding-bottom: 10px;
            font-weight: bold;
        }

        .mid_part {
            width: 256px;
            height: 120px;
            display: flex;
            justify-content: space-around;
            align-items: center;

            display: flex;
        }

        .prgres_chart {
            width: 80px;
            height: 80px;
            border: 1px solid black;

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
            font-size:30px;
            transform: translate(-50%, -50%);
        }

        .hist_content {    
            border: 1px solid black;
            width: 140px;
            height: 80px;
            margin-right:10px;
            padding: 3px 5px;

            display: flex;
            flex-wrap: wrap;
            
        }

        .hist_content > div {
            display: inline-block;
            margin: 1px 5px;
        }



        #today_diet {
         	width: 256px;
        	height: 100px;
        	background-color: tomato;
        	border: 1px solid black;
        }
        #current_exercise {
         	width: 256px;
        	height: 100px;
        	background-color: tomato;
        	border: 1px solid black;
        }
        #current_diet {
        	width: 256px;
        	height: 100px;
        	background-color: tomato;
        	border: 1px solid black;
        }
        #intake_diagram {

        	background-color: tomato;
        	border: 1px solid black;
            grid-column-end: span 4;
            grid-row-end: span 4;
        }

        .bottom_part {
            border: 1px solid black;
            
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
        }  
        
        
        
    </style>
</head>
<body>

	<!-- 메인메뉴 -->
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <!-- 오른쪽메뉴 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
    <!-- 왼쪽메뉴 -->
    <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %>

<main>
	<script src="js/jquery-3.7.1.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="https://kit.fontawesome.com/0c27eb5545.js" crossorigin="anonymous"></script>
    <main id="dashboard">
        <div id="profile">
            <div id="prf_head">
                <div id="prf_head_info">홍길동님의 신체 정보</div>
                <div id="rnk">
                    <img id="rnk_img" src="circle_icon05.png">
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
            <div id ="today_exercise_list_btn" class="dot_btn_group">
                <!-- <button class="dot_btn"></button>
                <button class="dot_btn"></button>
                <button class="dot_btn"></button> -->
                <img src="dot.png" class="dot_btn">
                <img src="dot.png" class="dot_btn">
                <img src="dot.png" class="dot_btn">
            </div>
            <div id="crt_excs_nm">스쿼트</div>
            
            <div class="mid_part">
                <div class="prgres_chart">
                    <span class="chart_center"></span>
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
        </div>
        <div id="current_exercise">
            <div class="dash_subject">최근 운동 기록</div>
        </div>
        <div id="current_diet">
            <div class="dash_subject">최근 식사 기록</div>
        </div>
        <div id="intake_diagram">
            <div class="dash_subject">하루 영양소 섭취량</div>
        </div>
        
    </main>




    <script>
        const colorname='#115500';
        const max = 100;
        const classname = '.prgres_chart';
        $(window).ready(function(){
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

    </script>
</main>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
</body>
</html>