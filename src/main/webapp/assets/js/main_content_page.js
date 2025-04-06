window.addEventListener("DOMContentLoaded", function () {
  if (!window.kakao || !kakao.maps || !kakao.maps.services) {
    console.error("Kakao Maps SDK가 로드되지 않았습니다.");
    return;
  }

  const mapContainer = document.getElementById('map');
  const mapOption = {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 3
  };
  const map = new kakao.maps.Map(mapContainer, mapOption);
  const ps = new kakao.maps.services.Places();
  const geocoder = new kakao.maps.services.Geocoder();

  let currentPosition = null;
  let markers = [];

  function clearMarkers() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
  }

  const locationBtn = document.getElementById("setLocationBtn");
  if (locationBtn) {
    locationBtn.addEventListener("click", function () {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
          currentPosition = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);
          map.setCenter(currentPosition);
          const currentMarker = new kakao.maps.Marker({
            map: map,
            position: currentPosition,
            title: "현재 위치",
            zIndex: 10
          });
          markers.push(currentMarker);
          alert("현재 위치가 설정되었습니다.");
        }, function () {
          alert("위치 정보를 가져올 수 없습니다.");
        });
      } else {
        alert("브라우저가 위치 정보를 지원하지 않습니다.");
      }
    });
  }

  // 주소 + 키워드 혼합 대응 스마트 검색
  function smartSearch(keyword, radius) {
    const listEl = document.getElementById('placesList');

    geocoder.addressSearch(keyword, function (result, status) {
      if (status === kakao.maps.services.Status.OK && result.length > 0) {
        const loc = new kakao.maps.LatLng(result[0].y, result[0].x);
        runSearch(keyword, loc, radius);
      } else {
        // fallback: 주소 파싱 실패 시 단어 분리 후 재시도
        const tokens = keyword.split(" ");
        if (tokens.length >= 2) {
          const locationKeyword = tokens[0];
          const placeKeyword = tokens.slice(1).join(" ");

          geocoder.addressSearch(locationKeyword, function (res, stat) {
            if (stat === kakao.maps.services.Status.OK && res.length > 0) {
              const loc = new kakao.maps.LatLng(res[0].y, res[0].x);
              runSearch(placeKeyword, loc, radius);
            } else {
              const fallbackLoc = currentPosition || map.getCenter();
              runSearch(keyword, fallbackLoc, radius);
            }
          });
        } else {
          const fallbackLoc = currentPosition || map.getCenter();
          runSearch(keyword, fallbackLoc, radius);
        }
      }
    });

    function runSearch(keyword, center, radius) {
      ps.keywordSearch(keyword, function (data, status) {
        if (status !== kakao.maps.services.Status.OK) {
          alert("검색 결과가 없습니다.");
          return;
        }

        clearMarkers();
        const bounds = new kakao.maps.LatLngBounds();
        listEl.innerHTML = "";

        data.forEach(place => {
          const position = new kakao.maps.LatLng(place.y, place.x);

          const marker = new kakao.maps.Marker({
            map,
            position,
            title: place.place_name
          });
          markers.push(marker);
          bounds.extend(position);

          const infoWindow = new kakao.maps.InfoWindow({
            content: `<div style="padding:5px;font-size:13px;"><strong>${place.place_name}</strong><br>${place.road_address_name || place.address_name}</div>`
          });
          kakao.maps.event.addListener(marker, 'click', function () {
            infoWindow.open(map, marker);
          });

          const li = document.createElement('li');
          li.innerHTML = `
            <strong>${place.place_name}</strong><br>
            주소: ${place.road_address_name || place.address_name || '주소 없음'}<br>
            전화: ${place.phone || '전화번호 없음'}<br>
            <a href="${place.place_url}" target="_blank">상세 보기</a>
          `;
          li.style.cursor = "pointer";
          li.addEventListener("click", () => {
            map.panTo(position);
            map.setLevel(3);
            infoWindow.open(map, marker);
          });

          listEl.appendChild(li);
        });

        map.setBounds(bounds);
      }, { location: center, radius: radius });
    }
  }

  // 검색 실행
  function handleSearch() {
    const keyword = document.getElementById('keyword').value.trim();
    const radius = parseInt(document.getElementById('radiusSelect').value);
    if (!keyword) {
      alert("검색어를 입력하세요.");
      return;
    }
    smartSearch(keyword, radius);
  }

  const searchBtn = document.getElementById("searchBtn");
  if (searchBtn) {
    searchBtn.addEventListener("click", handleSearch);
  }
});
