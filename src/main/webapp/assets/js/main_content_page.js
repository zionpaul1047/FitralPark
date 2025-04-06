window.addEventListener("DOMContentLoaded", function() {
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
	let searchCircle = null;
	let currentInfoWindow = null;

	function clearMarkers() {
		markers.forEach(marker => marker.setMap(null));
		markers = [];
	}

	function clearCircle() {
		if (searchCircle) {
			searchCircle.setMap(null);
			searchCircle = null;
		}
	}

	function getZoomLevelFromRadius(radius) {
		if (radius <= 500) return 4;
		if (radius <= 1000) return 5;
		if (radius <= 2000) return 6;
		if (radius <= 3000) return 7;
		return 8;
	}

	const locationBtn = document.getElementById("setLocationBtn");
	if (locationBtn) {
		locationBtn.addEventListener("click", function() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
					currentPosition = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);
					map.setCenter(currentPosition);

					const radius = parseInt(document.getElementById('radiusSelect').value);
					const zoomLevel = getZoomLevelFromRadius(radius);
					map.setLevel(zoomLevel);

					const marker = new kakao.maps.Marker({
						map: map,
						position: currentPosition,
						title: "현재 위치",
						zIndex: 10
					});
					markers.push(marker);

					// ✅ 반경 원 표시
					clearCircle();
					searchCircle = new kakao.maps.Circle({
						center: currentPosition,
						radius: radius,
						strokeWeight: 2,
						strokeColor: '#244d8e',
						strokeOpacity: 0.8,
						fillColor: '#244d8e',
						fillOpacity: 0.1
					});
					searchCircle.setMap(map);

					alert("현재 위치가 설정되었습니다.");
				}, function() {
					alert("위치 정보를 가져올 수 없습니다.");
				});
			} else {
				alert("브라우저가 위치 정보를 지원하지 않습니다.");
			}
		});
	}

	function searchPlaces() {
		const rawKeyword = document.getElementById('keyword').value.trim();
		const radius = parseInt(document.getElementById('radiusSelect').value);
		const listEl = document.getElementById('placesList');

		if (!rawKeyword) {
			alert("검색어를 입력하세요.");
			return;
		}

		const [addressHint, ...rest] = rawKeyword.split(" ");
		const keywordOnly = rest.length ? rest.join(" ") : rawKeyword;

		geocoder.addressSearch(addressHint, function(result, status) {
			let center = currentPosition || map.getCenter();

			if (status === kakao.maps.services.Status.OK && result.length > 0) {
				center = new kakao.maps.LatLng(result[0].y, result[0].x);
				currentPosition = center;
			}

			runSearch(rawKeyword, center, radius);
		});

		function runSearch(keyword, center, radius) {
			const searchOption = { location: center, radius: radius };

			ps.keywordSearch(keyword, function(data, status) {
				if (status !== kakao.maps.services.Status.OK) {
					alert("검색 결과가 없습니다.");
					return;
				}

				clearMarkers();
				clearCircle();

				searchCircle = new kakao.maps.Circle({
					center: center,
					radius: radius,
					strokeWeight: 2,
					strokeColor: '#244d8e',
					strokeOpacity: 0.8,
					fillColor: '#244d8e',
					fillOpacity: 0.1
				});
				searchCircle.setMap(map);

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

					kakao.maps.event.addListener(marker, 'click', function() {
						map.panTo(position);
						const zoomLevel = getZoomLevelFromRadius(radius);
						map.setLevel(zoomLevel);

						if (currentInfoWindow) currentInfoWindow.close();
						currentInfoWindow = infoWindow;
						infoWindow.open(map, marker);

						clearCircle();
						searchCircle = new kakao.maps.Circle({
							center: position,
							radius: radius,
							strokeWeight: 2,
							strokeColor: '#244d8e',
							strokeOpacity: 0.8,
							fillColor: '#244d8e',
							fillOpacity: 0.1
						});
						searchCircle.setMap(map);
					});

					const li = document.createElement('li');
					const imageUrl = "assets/images/icon/EmptyImage.png";

					li.innerHTML = `
					  <div class="place-item">
					    <img src="${imageUrl}" alt="썸네일" class="place-thumb">
					    <div class="place-info">
					      <strong>${place.place_name}</strong><br>
					      주소: ${place.road_address_name || place.address_name || '주소 없음'}<br>
					      전화: ${place.phone || '전화번호 없음'}<br>
					    </div>
					  </div>
					`;

					const detailBtn = document.createElement('button');
					detailBtn.textContent = "상세 보기";
					detailBtn.className = "search-btn";
					detailBtn.addEventListener("click", (e) => {
						e.stopPropagation(); // li 클릭 이벤트 중단

						const modal = document.getElementById("placeModal");
						const modalContent = document.getElementById("modalContentArea");

						modalContent.innerHTML = `
					    <iframe src="${place.place_url}" width="100%" height="100%" frameborder="0"></iframe>
					  `;
						modal.style.display = "flex";
					});
					li.appendChild(detailBtn);
					li.style.cursor = "pointer";
					li.addEventListener("click", () => {
						map.panTo(position);
						const zoomLevel = getZoomLevelFromRadius(radius);
						map.setLevel(zoomLevel);

						if (currentInfoWindow) currentInfoWindow.close();
						currentInfoWindow = infoWindow;
						infoWindow.open(map, marker);

						clearCircle();
						searchCircle = new kakao.maps.Circle({
							center: position,
							radius: radius,
							strokeWeight: 2,
							strokeColor: '#244d8e',
							strokeOpacity: 0.8,
							fillColor: '#244d8e',
							fillOpacity: 0.1
						});
						searchCircle.setMap(map);
					});

					listEl.appendChild(li);
				});

				map.setBounds(bounds);
			}, searchOption);
		}
	}

	const searchBtn = document.getElementById("searchBtn");
	if (searchBtn) {
		searchBtn.addEventListener("click", searchPlaces);
	}

	// ✅ 반경 select 박스 변경 시 자동 검색 재실행 (옵션)
	const radiusSelect = document.getElementById('radiusSelect');
	if (radiusSelect) {
		radiusSelect.addEventListener('change', () => {
			// 원과 줌 먼저 반영
			const radius = parseInt(radiusSelect.value);
			const center = currentPosition || map.getCenter();
			const zoomLevel = getZoomLevelFromRadius(radius);
			map.setLevel(zoomLevel);

			clearCircle();
			searchCircle = new kakao.maps.Circle({
				center: center,
				radius: radius,
				strokeWeight: 2,
				strokeColor: '#244d8e',
				strokeOpacity: 0.8,
				fillColor: '#244d8e',
				fillOpacity: 0.1
			});
			searchCircle.setMap(map);

			// 선택적으로 검색도 새로 하려면 아래 줄 주석 해제
			/*searchPlaces();*/
		});
	}
});
const modalCloseBtn = document.getElementById("modalCloseBtn");
modalCloseBtn.addEventListener("click", () => {
	const modal = document.getElementById("placeModal");
	modal.style.display = "none";
	document.getElementById("modalContentArea").innerHTML = "";
});
window.addEventListener("click", function(e) {
	const modal = document.getElementById("placeModal");
	if (e.target === modal) {
		modal.style.display = "none";
		document.getElementById("modalContentArea").innerHTML = "";
	}
});
document.addEventListener("keydown", function(e) {
	if (e.key === "Escape") {
		const modal = document.getElementById("placeModal");
		modal.style.display = "none";
		document.getElementById("modalContentArea").innerHTML = "";
	}
});


/* 회원가입 버튼 클릭시 회원가입 팝업 띄우기*/
function openJoinPopup() {
  const width = 800;
  const height = 850;
  const left = (screen.width - width) / 2;
  const top = (screen.height - height) / 2;

  window.open(
    '/fitralpark/login.do?show=signup',
    'joinPopup',
    `width=${width},height=${height},left=${left},top=${top},resizable=no`
  );
}
