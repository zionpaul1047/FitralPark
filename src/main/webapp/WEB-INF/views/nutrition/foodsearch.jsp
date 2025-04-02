<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nutrition/foodsearch.css">
    <style>

        
        
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
					            <a href=""><div class="sf_submenu_1_1">메뉴1</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴2</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴3</div></a>
					            <a href=""><div class="sf_submenu_1_1">메뉴4</div></a>
					            <span class="sf_list_search_bar">
					                <input type="text" placeholder="리스트 내 검색" class="sf_list_search_input">
					                <button class="sf_list_search_button">🔍</button>
					            </span>
					        </div>
					        
					        <section class="sf_result_section" id="sf_result_section">
                            <!-- 여기에 결과가 AJAX로 로드됩니다 -->
                            <div class="loading" style="display:none;">검색중...</div>
                        </section>
                        
                        
                        
					        <!-- 
					        <section class="sf_result_section">
							    <c:forEach var="item" items="${results}">
							        <div class="sf_result_section_1">
							            <div class="sf_reult_section_1_1">
							                <div class="sf_result_item_1">
							                    <img src="#" alt="사진 크롤링" class="sf_result_img_1" id="sf_result_img_1">
							                    <div class="sf_result_info_1">
							                        <div class="sf_result_info_food_name_1">
													    ${item.food_name} ${item.nut_con_str_qua} &nbsp;&nbsp;&nbsp;<span class="sf_result_info_food_detail_1">(${item.food_size})</span>
													</div>

							                        <div class="sf_result_info_food_detail_1">
							                            <p>
							                                칼로리(kcal): ${item.enerc} | 단백질(g): ${item.protein} | 탄수화물(g): ${item.chocdf} | 지방(g): ${item.fatce} | 당류(g): ${item.sugar} | 나트륨(mg): ${item.na}<br>
							                                칼슘(mg): ${item.ca} | 철(mg): ${item.fe} | 인(mg): ${item.p} | 칼륨(mg): ${item.k} | 콜레스테롤(mg): ${item.chole} | 포화지방(g): ${item.fasat}<br>
							                                트랜스지방(g): ${item.fatrn} | 비타민A(μg RAE): ${item.vataRae} | 베타카로틴(μg): ${item.cartb} | 티아민(mg): ${item.thia}<br>
							                                리보플라빈(mg): ${item.ribf} | 나이아신(mg): ${item.nia} | 비타민C(mg): ${item.vitac} | 비타민D(μg): ${item.vitd}
							                            </p>
							                        </div>
							                    </div>
							                </div>
							            </div>
							            <div class="sf_result_section_1_2">
							                <button class="sf_result_favorite_button_1">즐겨찾기 등록</button>
							            </div>     
							        </div>
							    </c:forEach>
							    
							    
							    <c:if test="${empty results}">
							        <div class="no_results_message">
							            <p>검색 결과가 없습니다. 다른 키워드로 검색해 주세요.</p>
							        </div>
							    </c:if>
							</section>
								 -->
								 
								 
								 
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
	  $(document).ready(function() {
	        // 검색 버튼 클릭 이벤트
	        $("#sf_food_search_button").click(function() {
	            performSearch();
	        });
	        
	        // 엔터키 입력 이벤트
	        $("#sf_food_search_input").keypress(function(e) {
	            if (e.which == 13) {
	                performSearch();
	                return false; // 폼 제출 방지
	            }
	        });
	        
	        // 검색 함수
	        function performSearch() {
	            var query = $("#sf_food_search_input").val().trim();
	            
	            if(query.length === 0) {
	                alert("검색어를 입력해 주세요.");
	                return;
	            }
	            
	            // 로딩 표시
	            $(".loading").show();
	            $("#sf_result_section").children(":not(.loading)").hide();
	            
	            // AJAX 요청
	            $.ajax({
	                url: "${pageContext.request.contextPath}/nutrition/foodsearch.do",
	                type: "GET",
	                data: { query: query },
	                success: function(response) {
	                    $("#sf_result_section").html(response);
	                },
	                error: function(xhr, status, error) {
	                    $("#sf_result_section").html("<p>검색 중 오류가 발생했습니다: " + error + "</p>");
	                },
	                complete: function() {
	                    $(".loading").hide();
	                }
	            });
	        }
	    });

	
	</script>
    



</body>


</html>