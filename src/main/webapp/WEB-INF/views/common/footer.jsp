<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<style>

html, body {
  margin: 0;
  padding: 0;
  height: 100%; /* 전체 화면 높이를 차지하도록 설정 */
  display: flex;
  flex-direction: column; /* 세로 방향 배치 */
}

main {
  flex: 1; /* 메인 콘텐츠가 남은 공간을 채우도록 설정 */
}

body {
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column; /* Flexbox를 사용하여 세로 방향 배치 */
	min-height: 100vh; /* 페이지 높이를 화면 높이로 설정 */
}

main {
	flex: 1; /* 메인 콘텐츠가 남은 공간을 채우도록 설정 */
}

footer {
  background-color: #f9f9f9;
  padding: 30px 20px;
  text-align: center;
  border-top: 1px solid #ddd;
  width: 100%; 
  box-sizing: border-box; 
}

footer .footer-content {
  width: 100%; 
  color: #333;
}

footer .footer-content h3 {
	font-size: 18px;
	margin-bottom: 10px;
}

footer .footer-content p {
	margin: 5px 0;
}

footer .footer-content p span {
	font-weight: bold;
}

footer .logo {
  display: flex; /* Flexbox 사용 */
  justify-content: center; /* 로고를 중앙 정렬 */
}

footer .logo img {
	width: 200px; /* 로고 너비를 설정 */
	height: auto; /* 비율 유지 */
}

footer .copyright {
	margin-top: 20px;
	font-size: 14px;
	color: #777;
}
</style>
</head>
<body>

	<footer>
		<div class="footer-content">
			<div class="logo">
				<img src="assets/logo/basiclogo.png" alt="logo">
			</div>
			<h3>피트럴파크 FitralPark</h3>
			<p>서울특별시 강남구 테헤란로 132(역삼동) 한독약품빌딩 8층 쌍용교육센터</p>
			<p>
				<span>Tel:</span> 02-1234-5678 &nbsp;&nbsp; <span>Fax:</span>
				02-1234-5678
			</p>
		</div>
		<div class="copyright">Copyrightⓒ 2025 FitralPark, All Right
			Reserved.</div>
	</footer>

</body>
</html>