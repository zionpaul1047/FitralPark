<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

.footer_set {

  background-color: #f9f9f9;
  padding: 30px 20px;
  text-align: center;
  border-top: 1px solid #ddd;
  width: 100%; 
  box-sizing: border-box; 
}

.footer_set .footer-content {
  width: 100%; 
  color: #333;
}

.footer_set .footer-content h3 {
    font-size: 18px;
    margin-bottom: 10px;
}

.footer_set .footer-content p {
    margin: 5px 0;
}

.footer_set .footer-content p span {
    font-weight: bold;
}

.footer_set .logo {
  display: flex; /* Flexbox 사용 */
  justify-content: center; /* 로고를 중앙 정렬 */
}

.footer_set .logo img {
    width: 200px; /* 로고 너비를 설정 */
    height: auto; /* 비율 유지 */
}

.footer_set .copyright {
    margin-top: 20px;
    font-size: 14px;
    color: #777;
}
</style>
	<div class="footer_set">
        <div class="footer-content">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo/basiclogo.png" alt="logo">
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
    </div>


