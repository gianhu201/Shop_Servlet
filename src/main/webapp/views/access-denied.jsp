<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Truy cập bị từ chối</title>
</head>
<body>
<h2>🚫 Bạn không có quyền truy cập vào trang này.</h2>
<a href="<%= request.getContextPath() %>/views/login.jsp">⬅ Quay lại trang đăng nhập</a>
</body>
</html>
