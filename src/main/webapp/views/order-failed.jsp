<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thất bại</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f9fc;
            display: flex;
            justify-content: center;
            padding: 40px;
        }
        .failed-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            width: 500px;
            text-align: center;
        }
        .failed-icon {
            color: #f44336;
            font-size: 48px;
            margin-bottom: 20px;
        }
        .order-number {
            font-size: 18px;
            font-weight: bold;
            margin: 20px 0;
        }
        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            margin-right: 10px;
        }
        .btn-retry {
            background-color: #2196F3;
        }
    </style>
</head>
<body>
<div class="failed-container">
    <div class="failed-icon">✗</div>
    <h2>Thanh toán thất bại</h2>

    <%
        String orderId = request.getParameter("orderId");
        String errorMessage = (String) session.getAttribute("errorMessage");
    %>

    <p class="order-number">
        <% if(errorMessage != null) { %>
        <%= errorMessage %>
        <% session.removeAttribute("errorMessage"); %>
        <% } else { %>
        Thanh toán cho đơn hàng #<%= orderId %> không thành công.
        <% } %>
    </p>

    <p>Vui lòng thử lại hoặc chọn phương thức thanh toán khác.</p>

    <a href="<%= request.getContextPath() %>/cart" class="btn btn-retry">Thử lại</a>
    <a href="<%= request.getContextPath() %>/home" class="btn">Tiếp tục mua sắm</a>
</div>
</body>
</html>