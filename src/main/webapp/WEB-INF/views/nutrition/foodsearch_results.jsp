<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${not empty results}">
        <c:forEach var="item" items="${results}">
            <div class="sf_result_section_1">
                <div class="sf_reult_section_1_1">
                    <div class="sf_result_item_1">
                        <img src="" alt="${item.food_name}" class="sf_result_img_1" id="sf_result_img_${item.food_cd}">
                        <div class="sf_result_info_1">
                            <div class="sf_result_info_food_name_1">
                                ${item.food_name} ${item.nut_con_str_qua} &nbsp;&nbsp;&nbsp;
                                <span class="sf_result_info_food_detail_1">(${item.food_size})</span>
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
                    <button class="sf_result_favorite_button_1" data-food-cd="${item.food_cd}">즐겨찾기 등록</button>
                </div>     
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="no_results_message">
            <p>'${param.query}'에 대한 검색 결과가 없습니다. 다른 키워드로 검색해 주세요.</p>
        </div>
    </c:otherwise>
</c:choose>


    <!-- 페이지네이션 -->
<div id="pagination">
    <!-- 이전 버튼 -->
    <c:if test="${currentPage > 1}">
        <button class="page-btn" data-page="${currentPage - 1}">이전</button>
    </c:if>

    <!-- 동적 페이지 번호 -->
    <c:forEach begin="${startPage}" end="${endPage}" var="page">
        <c:choose>
            <c:when test="${page == currentPage}">
                <button class="page-btn" data-page="${page}"><strong>${page}</strong></button> <!-- 현재 페이지 강조 -->
            </c:when>
            <c:otherwise>
                <button class="page-btn" data-page="${page}">${page}</button>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 버튼 -->
    <c:if test="${currentPage < totalPages}">
        <button class="page-btn" data-page="${currentPage + 1}">다음</button>
    </c:if>
</div>


