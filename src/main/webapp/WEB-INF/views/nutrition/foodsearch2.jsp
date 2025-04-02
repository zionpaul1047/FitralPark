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
<<<<<<< HEAD
							    <form action="searchFood" method="GET">
							        <input type="text" name="query" placeholder="검색어를 입력해 주세요" class="sf_food_search_input">
							        <button type="submit" class="sf_food_search_button">🔍</button>
							    </form>
							</div>

=======
					            <input type="text" placeholder="검색어를 입력해 주세요" class="sf_food_search_input">
					            <button class="sf_food_search_button">🔍</button>
					        </div>
>>>>>>> 0e60b5ec92866662563f0fcb3271f5ff198ede2c
					
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
<<<<<<< HEAD
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
							    
							    <!-- 검색 결과가 없는 경우 -->
							    <c:if test="${empty results}">
							        <div class="no_results_message">
							            <p>검색 결과가 없습니다. 다른 키워드로 검색해 주세요.</p>
							        </div>
							    </c:if>
							</section>

=======
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
>>>>>>> 0e60b5ec92866662563f0fcb3271f5ff198ede2c
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