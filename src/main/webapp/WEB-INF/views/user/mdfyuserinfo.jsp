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
			    <%-- <%@ include file="/WEB-INF/views/common/left_menu1.jsp" %> --%>
			    <%@ include file="/WEB-INF/views/common/left_menu_mypage.jsp" %>
			    
		</div>
		
		<div class="grid_center">
		
			<div class="grid_center_L"></div>
			
			<div class="grid_center_R">
				<!-- 컨텐츠페이지 -->
    			<main id="mdfyuserinfo">
    				
			    	<c:if test="${serviceResult eq 1}"> 
			    		<script>alert('회원정보 수정에 성공하였습니다');</script>
			    	</c:if>
			    	<c:if test="${serviceResult eq 0}">
			    		<script>alert('회원정보 수정에 실패하였습니다');</script>
			    	  
			    	</c:if>
    				
    				<h1>회원정보 수정</h1>
    				<div>변경할 정보를 입력해주세요.</div>
	    			<form id="member_info_form" method="POST" action="modfyuserinfook.do">
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">아이디 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content no_mdfy_content">${userInfo.memberId }</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">비밀번호 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content">
	    						<input type="password" id="user_pw" class="wide_input" name="user_pw" placeholder="영문 대소문자+숫자+특수문자 중 2가지 이상, 8~16자" minlength="8" maxlength="16" required>
	    						<small id="pwValidationMessage" style="display: block; margin-top: 4px;"></small>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">비밀번호 확인 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content">
	    						<input type="password" id="user_pw_vrfy" class="wide_input" placeholder="비밀번호를 다시 입력하세요" minlength="8" maxlength="16" required>
	    						<small id="pwMatchMessage" style="display: block; margin-top: 4px;"></small>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">이름 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content no_mdfy_content">${userInfo.memberName}</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">주민등록번호 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content no_mdfy_content">${userInfo.personalNumber}</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">닉네임 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content">
	    						<input type="text" id="user_nickname" class="wide_input" name="user_nickname" placeholder="한글/영문/숫자 조합, 최대 15자" value="${userInfo.memberNickname}" minlength="1" maxlength="15" required>
	    					</div>
	    					<div><small id="nickMessage"></small></div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">연락처 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content">
	    						<div>
		    						<select id="user_tel1" class="reg_input" name="user_tel1">
		    							<option value="010">010</option>
		    							<option value="011">011</option>
		    							<option value="016">016</option>
		    							<option value="017">017</option>
		    							<option value="018">018</option>
		    							<option value="019">019</option>
		    							<option value="02">02 (서울)</option>
		    							<option value="031">031 (경기)</option>
		    							<option value="032">032 (인천)</option>
		    							<option value="033">033 (강원)</option>
		    							<option value="041">041 (충남)</option>
		    							<option value="042">042 (대전)</option>
		    							<option value="043">043 (충북)</option>
		    							<option value="044">044 (세종)</option>
		    							<option value="051">051 (부산)</option>
		    							<option value="052">052 (울산)</option>
		    							<option value="053">053 (대구)</option>
		    							<option value="054">054 (경북)</option>
		    							<option value="055">055 (경남)</option>
		    							<option value="061">061 (전남)</option>
		    							<option value="062">062 (광주)</option>
		    							<option value="063">063 (전북)</option>
		    							<option value="064">064 (제주)</option>
		    							<option value="070">070 (인터넷전화)</option>
		    							<option value="custom">직접입력</option>
		    						</select> - <input type="text" id="user_tel2" name="user_tel2" class="reg_input" value="${userInfo.tel2}"  minlength="3" maxlength="4" required> - <input type="text" id="user_tel3" class="reg_input" name="user_tel3"  value="${userInfo.tel3}"  minlength="4" maxlength="4" required>
	    						</div>
	    						<div>
	    							<input type="text" id="custom_phone" name="custom_phone" class="wide_input" name="custom_phone" placeholder="+82-10-1234-5678 형식 가능" minlength="3" style="display: none;">
	    							<small id="custom_phone_message" style="display: block; margin-top: 4px;"></small>
	    							<input type="hidden" id ="tel_select" name="tel_select" value="${userInfo.tel_select}">
	    						</div>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">이메일 <span class="ncsry_item">*</span></div>
	    					<div class="mdfy_item_content">
	    						<div>
	    							<div>
			    						<input type="text" id="user_email_prefix" class="reg_input" name="user_email_prefix" placeholder="아이디" value="${userInfo.email1}"> @ <select id="user_email_domain" class="reg_input" name="user_email_domain" minlength="1" required>
															    							<option value="default">선택</option>
															    							<option value="gmail.com">gmail.com</option>
															    							<option value="naver.com">naver.com</option>
															    							<option value="daum.net">daum.net</option>
															    							<option value="hanmail.net">hanmail.net</option>
															    							<option value="nate.com">nate.com</option>
															    							<option value="kakao.com">kakao.com</option>
															    							<option value="custom">직접입력</option>
															    						</select> <button id="emailAuthBtn" type="button">인증번호 발송</button>
									</div>
									<div>
										<input type="text" id="email_domain_custom" class="wide_input" name="email_domain_custom" placeholder="직접 도메인 입력" style="display: none;">
										<input type="hidden" id ="email_domain_select" name="email_domain_select" value="${userInfo.email_domain_select}">
									</div>
								</div>
								<div><small id="emailMessage"></small></div>
								<div id="authCodeWrap" style="display: none; width: 100%;">
									<div>
										<input type="text" id="authCode" class="reg_input" maxlength="6" placeholder="인증번호를 입력해주세요" >
										<button type="button" id="authCodeCheckBtn">확인</button>
										<small id="authTimer"></small>
									</div>
									<div id="authCodeMessage" style="color: red;"></div>
								</div>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">주소</div>
	    					<div class="mdfy_item_content">
	    						<div><input type="text" id="input_postcode" class="reg_input" name="input_postcode" placeholder="우편번호" value="${userInfo.address1}" readonly> <input type="button" id="zipCodeCheckBtn" onclick="execDaumPostcode()" value="주소 검색"></div>
	    						<div><input type="text" id="input_address" class="wide_input" name="input_address" placeholder="기본주소" value="${userInfo.address2}" readonly></div>
	    					</div>
	    				</div>
	    				<div class="mdfy_item">
	    					<div class="mdfy_item_subj">상세주소(선택)</div>
	    					<div class="mdfy_item_content">
	    						<input type="text" id="input_detailAddress" class="wide_input" name="input_detailAddress" placeholder="나머지 주소 (선택 입력 가능)"  value="${userInfo.address3}">
	    					</div>
	    				</div>
	    				<div id="form_bottom">
	    					<button id="mdfy_submit_btn">회원정보 수정</button>
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
	    
	  //기존 회원정보 불러오기
	  $('#user_tel1').val('${userInfo.tel1}');
	  $('#user_email_domain').val('${userInfo.email2}');
	    
	   
    </script>


</body>


</html>