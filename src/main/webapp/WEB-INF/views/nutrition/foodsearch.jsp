<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nutrition/foodsearch.css">
    
    <style>
		
		#pagination {
		    display: flex; /* 버튼을 가로로 배치 */
		    justify-content: center; /* 중앙 정렬 */
		    margin-top: 20px; /* 위쪽 여백 */
		    margin-bottom: 20px;
		}
		
		#pagination button {
		    background-color: #f0f0f0; /* 기본 배경색 */
		    color: #a3a3a3; /* 텍스트 색상 */
		    border: 1px solid #ddd; /* 테두리 색상 */
		    padding: 5px 10px; /* 버튼 크기 */
		    margin: 0 5px; /* 버튼 간격 */
		    border-radius: 5px; /* 둥근 모서리 */
		    font-size: 14px; /* 글꼴 크기 */
		    cursor: pointer; /* 마우스 포인터 변경 */
		    transition: background-color 0.3s ease, color 0.3s ease; /* 호버 효과 전환 */
		}
		
		#pagination button strong{
			color: black;
		}
		
		#pagination button:hover {
		    background-color: #8ee591; /* 호버 시 배경색 변경 */
		    color: white; /* 호버 시 텍스트 색상 변경 */
		}
		
		#pagination button.active {
		    background-color: #8ee591; /* 활성화된 버튼 배경색 */
		    color: white; /* 활성화된 버튼 텍스트 색상 */
		    border-color: #4CAF50;
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
                            <input type="text" id="sf_food_search_input" placeholder="검색어를 입력해 주세요" class="sf_food_search_input">
                            <button type="button" id="sf_food_search_button" class="sf_food_search_button">🔍</button>
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
					            <a href=""><div class="sf_submenu_1_1" id="menu1">통합검색</div></a>
					            <a href=""><div class="sf_submenu_1_1" id="menu2">즐겨찾기</div></a>
					            <!-- 
					            <a href=""><div class="sf_submenu_1_1">메뉴3</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴4</div></a>
					             -->
					            <span class="sf_list_search_bar">
					                <input type="text" placeholder="리스트 내 검색" class="sf_list_search_input">
					                <button class="sf_list_search_button">🔍</button>
					            </span>
					        </div>
					        
					        <!-- 검색 결과 섹션 -->
						    <section class="sf_result_section" id="sf_result_section">
						    	<div class="sf_result_section_defult">위의 검색칸에서 검색을 해주세요</div>
						        <div class="loading" style="display: none;">검색중...</div>
						        <!-- 검색 결과가 여기에 표시됩니다 -->
						    </section>
						
						    <!-- 즐겨찾기 섹션 -->
						    <section class="sf_favorite_section" id="sf_favorite_section" style="display: none;">
						        <!-- 즐겨찾기 데이터가 여기에 표시됩니다 -->
						        <p>즐겨찾기 목록을 불러오는 중...</p>
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
	
	<!-- <script src="${pageContext.request.contextPath}/assets/js/nutrition/foodsearch_ajax.js"></script> --> <!-- JavaScript 파일 -->
	<script>
	  $(document).ready(function() {
		  
		    // 페이지 로드 시 기본값 설정 (통합검색 버튼 활성화)
			$("#menu1").css({
		        "background-color": "oldlace",
		        "font-weight": "bold"
		    });

		    // 메뉴 클릭 이벤트
		    $(".sf_submenu_1_1").click(function (e) {
		        e.preventDefault(); // 기본 동작 방지

		        // 모든 메뉴 배경색 초기화
		        $(".sf_submenu_1_1").css({
		        	"background-color": "lightgray",
			        "font-weight": "normal"
			    });

		        // 클릭된 메뉴만 활성화
		        $(this).css	({
			        "background-color": "oldlace",
			        "font-weight": "bold"
			    });

		        // 섹션 전환 처리
		        if (this.id === "menu1") {
		        	$(".sf_result_section").show();
		        	$(".sf_favorite_section").hide();
		        	$(".loading").hide();
		        	
		        } else if (this.id === "menu2") {
		        	$(".sf_favorite_section").show();
		        	$(".sf_result_section").hide();
		        }
		    });
		    
		    
	        // 검색 버튼 클릭 이벤트
	        $("#sf_food_search_button").click(function () {
		        performSearch(1); // 첫 번째 페이지에서 검색 시작
		    });
	        
	        // 엔터키 입력 이벤트
	        $("#sf_food_search_input").keypress(function (e) {
	        if (e.which == 13) {
	            performSearch(1); // 첫 번째 페이지에서 검색 시작
	            return false; // 폼 제출 방지
	        }
	        });
	        
	        // 페이지네이션 버튼 클릭 이벤트
	        $(document).on("click", ".page-btn", function () {
	            const page = $(this).data("page"); // 클릭한 버튼의 페이지 번호 가져오기
	            performSearch(page); // 해당 페이지로 검색 실행
	        });
	        

	        // 검색 함수
	        function performSearch(page) {
	            const query = $("#sf_food_search_input").val().trim();

	            if (query.length === 0) {
	                alert("검색어를 입력해 주세요.");
	                return;
	            }

	            // 로딩 표시
	            $(".loading").show();
	            $("#sf_result_section").children(":not(.loading)").hide();

	         // AJAX 요청
	            $.ajax({
	                url: "${pageContext.request.contextPath}/nutrition/foodsearch.do",
	                type: "get",
	                data: { query: query, page: page },
	                success: function (response) {
	                    $("#sf_result_section").html(response); // 검색 결과 업데이트
		                    // 동적으로 이미지 src 설정
		                    $(".sf_result_img_1").each(function () {
		                        const foodName = $(this).attr("alt");
		                        const imgElement = $(this);
	
		                        // Google 이미지 API 호출 (이미지 URL 설정)
		                        $.ajax({
		                            url: "/nutrition/getImage.do",
		                            type: "get",
		                            data: { query: foodName },
		                            success: function (imageUrl) {
		                                imgElement.attr("src", imageUrl); // 이미지 업데이트
		                            },
		                            error: function () {
		                                console.error("이미지를 가져오는 중 오류가 발생했습니다.");
		                            }
		                        });
		                    });

	                },
	                error: function (xhr, status, error) {
	                    $("#sf_result_section").html("<p>검색 중 오류가 발생했습니다: " + error + "</p>");
	                },
	                complete: function () {
	                    $(".loading").hide(); // 로딩 표시 숨기기
	                }
	                
	            });
	        }

	    });

	
	</script>
    



</body>


</html>