<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>Đăng ký</title>
</head>
<body>
<h2>Đăng ký</h2>
<form action="<%= request.getContextPath() %>/signup" method="post">
	<label>Tên đăng nhập:</label><br>
	<input type="text" name="username" required><br>
	<label>Mật khẩu:</label><br>
	<input type="password" name="password" required><br><br>
	<input type="submit" value="Đăng ký">
</form>
<p>Đã có tài khoản? <a href="<%= request.getContextPath() %>/views/login.jsp">Đăng nhập</a></p>
</body>
</html>
