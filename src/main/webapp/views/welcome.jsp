<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Chào mừng</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
  <h1>Chào mừng đến với ClothingShop</h1>

  <%-- Hiển thị thông tin người dùng --%>
  <%
    String fullName = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("userEmail");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
  %>

  <div class="welcome-info">
    <p>Xin chào, <strong><%= fullName %></strong>!</p>
    <p>Email: <%= email %></p>
    <p>
      Quyền hạn:
      <% if (isAdmin != null && isAdmin) { %>
      <span class="admin-badge">Quản trị viên</span>
      <% } else { %>
      <span class="user-badge">Người dùng</span>
      <% } %>
    </p>
  </div>

  <div class="navigation">
    <% if (isAdmin != null && isAdmin) { %>
    <a href="${pageContext.request.contextPath}/views/admin" class="btn">Quản lý hệ thống</a>
    <% } %>
    <a href="${pageContext.request.contextPath}/product" class="btn">Xem sản phẩm</a>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Đăng xuất</a>
  </div>
</div>
</body>
</html>