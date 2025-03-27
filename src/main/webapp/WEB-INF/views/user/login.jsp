<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Sign In</title>
<link rel="stylesheet" href="/assets/css/auth/login.css">
<script defer src="/assets/js/auth/login.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>
	<div class="login-container">
		<div class="image-section">
			<img
				src="${pageContext.request.contextPath}/assets/images/logo/squarelogo.png"
				alt="Login Image">
		</div>
		<div class="form-section">
			<h2>Sign In</h2>
			<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
			<form method="POST" action="${pageContext.request.contextPath}/login">
				<input type="email" name="email" placeholder="Email" required />
				<div class="password-wrapper">
					<input type="password" name="password" placeholder="Password"
						id="password" required /> <i id="togglePassword"
						class="fa fa-eye"></i>
				</div>
				<button type="submit">Sign In</button>
			</form>
			<div class="links">
				<a href="#">Create an account?</a> <a href="#">Forgot password</a>
			</div>
		</div>
	</div>
</body>
</html>
