<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
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
    <link rel="stylesheet" href="/fitralpark/assets/css/user/mdfyuserinfo.css">
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
    			<main id="mdfyuserinfo">
    				<h1>회원정보 수정</h1>
    				<div>변경할 정보를 입력해주세요.</div>
	    			<form>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">아이디</div>
	    					<div class="mdfy_item_content no_mdfy_content">hong123</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">비밀번호</div>
	    					<div class="mdfy_item_content">
	    						<input type="password" id="user_pw" class="wide_input" placeholder="영문 대소문자+숫자+특수문자 중 2가지 이상, 8~16자">
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">비밀번호 확인</div>
	    					<div class="mdfy_item_content">
	    						<input type="password" id="user_pw_vrfy" class="wide_input" placeholder="비밀번호를 다시 입력하세요">
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">이름</div>
	    					<div class="mdfy_item_content no_mdfy_content">홍길동</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">주민등록번호</div>
	    					<div class="mdfy_item_content no_mdfy_content">980101-1******</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">닉네임</div>
	    					<div class="mdfy_item_content">
	    						<input type="text" id="user_nickname" class="wide_input" placeholder="한글/영문/숫자 조합, 최대 15자">
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">연락처</div>
	    					<div class="mdfy_item_content">
	    						<select id="user_tel1" class="reg_input">
	    							<option>010</option>
	    							<option>011</option>
	    							<option>016</option>
	    							<option>017</option>
	    							<option>018</option>
	    							<option>019</option>
	    							<option>02 (서울)</option>
	    							<option>031 (경기)</option>
	    							<option>032 (인천)</option>
	    							<option>033 (강원)</option>
	    							<option>041 (충남)</option>
	    							<option>042 (대전)</option>
	    							<option>043 (충북)</option>
	    							<option>044 (세종)</option>
	    							<option>051 (부산)</option>
	    							<option>052 (울산)</option>
	    							<option>053 (대구)</option>
	    							<option>054 (경북)</option>
	    							<option>055 (경남)</option>
	    							<option>061 (전남)</option>
	    							<option>062 (광주)</option>
	    							<option>063 (전북)</option>
	    							<option>064 (제주)</option>
	    							<option>070 (인터넷전화)</option>
	    							<option>직접입력</option>
	    						</select> - <input type="text" id="user_tel2" class="reg_input"> - <input type="text" id="user_tel3" class="reg_input">
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">이메일</div>
	    					<div class="mdfy_item_content">
	    						<input type="text" id="user_email_prefix" class="reg_input" placeholder="아이디"> @ <select id="user_email_domain" class="reg_input">
													    							<option>선택</option>
													    							<option>gmail.com</option>
													    							<option>naver.com</option>
													    							<option>daum.net</option>
													    							<option>hanmail.net</option>
													    							<option>nate.com</option>
													    							<option>kakao.com</option>
													    							<option>직접입력</option>
													    						</select> <button type="button">인증번호 발송</button>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">주소</div>
	    					<div class="mdfy_item_content">
	    						<div><input type="text" id="input_postcode" class="reg_input" placeholder="우편번호" readonly> <input type="button" id="zipCodeCheckBtn" onclick="execDaumPostcode()" value="주소 검색"></div>
	    						<div><input type="text" id="input_address" class="wide_input" placeholder="기본주소" readonly></div>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">상세주소(선택)</div>
	    					<div class="mdfy_item_content">
	    						<input type="text" id="input_detailAddress" class="wide_input" placeholder="나머지 주소 (선택 입력 가능)">
	    					</div>
	    				</div>
	    				<div id="form_bottom">
	    					<button>보내기</button>
	    				</div>
	    				
	    			</form>
    			
    			
    			
    			</main>
			</div>
			
		</div>
		
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>
	
	
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script charset="utf-8" src="/fitralpark/assets/js/user/mdfyuserinfo.js"></script>
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
	    
	    
	   
    </script>


</body>


</html>