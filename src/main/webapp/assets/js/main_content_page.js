//(지도 초기화 및 장소 검색)

window.addEventListener("DOMContentLoaded", function () {
  if (!window.kakao || !kakao.maps || !kakao.maps.services) {
    console.error("Kakao Maps SDK가 로드되지 않았습니다.");
    console.log("지도 로딩 준비 완료");
    return;
  }

  var mapContainer = document.getElementById('map');
  var mapOption = {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 3
  };

  var map = new kakao.maps.Map(mapContainer, mapOption);
  var ps = new kakao.maps.services.Places();

  // 검색 함수 정의
  function searchPlaces() {
    var keyword = document.getElementById('keyword').value;
    if (!keyword.trim()) {
      alert('검색어를 입력하세요!');
      return;
    }

    ps.keywordSearch(keyword + ' 헬스장', function (data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        var bounds = new kakao.maps.LatLngBounds();
        var listEl = document.getElementById('placesList');
        listEl.innerHTML = '';

        data.forEach(place => {
          var position = new kakao.maps.LatLng(place.y, place.x);
          new kakao.maps.Marker({ map, position });
          bounds.extend(position);

		  var li = document.createElement('li');
		  li.innerHTML = `
		    <strong>${place.place_name}</strong><br>
		    주소: ${place.road_address_name || place.address_name || '주소 없음'}<br>
		    전화: ${place.phone || '전화번호 없음'}<br>
		    <a href="${place.place_url}" target="_blank">상세 보기</a>
		  `;
		  listEl.appendChild(li);
        });

        map.setBounds(bounds);
      } else {
        alert('검색 결과가 없습니다.');
      }
    });
  }

  // 🔧 여기서 버튼 클릭 이벤트 바인딩
  const searchBtn = document.getElementById("searchBtn");
  if (searchBtn) {
    searchBtn.addEventListener("click", searchPlaces);
  }
});
