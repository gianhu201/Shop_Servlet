<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>

<%
    CategoryDAO dao = new CategoryDAO();
    List<Category> list = dao.getAllCategories();
%>

<html>
<head>
    <title>Quản lý Danh mục</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Danh mục</h2>

    <form action="../CategoryServlet" method="post">
        <input type="text" name="name" placeholder="Tên danh mục" required>
        <button type="submit" name="action" value="add" class="btn btn-primary">Thêm</button>
    </form>

    <table class="table mt-3">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên danh mục</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Category c : list) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getName() %></td>
            <td>
                <a href="../CategoryServlet?action=delete&id=<%= c.getId() %>" class="btn btn-danger btn-sm">Xoá</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
