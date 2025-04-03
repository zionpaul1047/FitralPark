$(document).ready(function () {
    // 페이지 로드 시 기본값 설정 (통합검색 버튼 활성화)
	$("#menu1").css({
        "background-color": "oldlace",
        "font-weight": "bold"
    });

    // 메뉴 클릭 이벤트
    $(".sf_submenu_1_1").click(function (e) {
        e.preventDefault(); // 기본 동작 방지

        // 모든 메뉴 배경색 초기화
        $(".sf_submenu_1_1").css("background-color", "lightgray");

        // 클릭된 메뉴만 활성화
        $(this).css	({
	        "background-color": "oldlace",
	        "font-weight": "bold"
	    });

        // 섹션 전환 처리
        if (this.id === "menu1") {
            showSection("sf_result_section");
            loadContent("/nutrition/foodsearch_results.jsp", "#sf_result_section");
        } else if (this.id === "menu2") {
            showSection("sf_favorite_section");
            loadContent("/nutrition/foodsearch_favorite.jsp", "#sf_favorite_section");
        }
    });

    // 섹션 전환 함수
    function showSection(sectionId) {
        $("section").hide(); // 모든 섹션 숨기기
        $("#" + sectionId).show(); // 선택한 섹션만 표시
    }

    // AJAX로 콘텐츠 로드 함수
    function loadContent(url, target) {
        $.ajax({
            url: url,
            type: "get",
            success: function (response) {
                $(target).html(response);
            },
            error: function (xhr, status, error) {
                $(target).html(
                    `<p>콘텐츠를 불러오는 중 오류가 발생했습니다: ${error}</p>`
                );
            },
        });
    }
});
