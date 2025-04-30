<!-- /admin/dashboard.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Trang Quản Trị</h2>
    <a href="${pageContext.request.contextPath}/views/admin/ADcategory" class="btn btn-primary mt-3">Quản lý Danh mục</a>
    <a href="${pageContext.request.contextPath}/views/admin/ADproduct"  class="btn btn-success mt-3">Quản lý Sản phẩm</a>
</div>

</body>
</html>
