<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f9fc;
            display: flex;
            justify-content: center;
            padding: 40px;
        }
        .success-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            width: 500px;
            text-align: center;
        }
        .success-icon {
            color: #4CAF50;
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
        }
    </style>
</head>
<body>
<div class="success-container">
    <div class="success-icon">✓</div>
    <h2>Đặt hàng thành công!</h2>

    <%
        String orderId = request.getParameter("orderId");
        String successMessage = (String) session.getAttribute("successMessage");
    %>

    <p class="order-number">
        <% if(successMessage != null) { %>
        <%= successMessage %>
        <% session.removeAttribute("successMessage"); %>
        <% } else { %>
        Mã đơn hàng của bạn là: #<%= orderId %>
        <% } %>
    </p>

    <p>Cảm ơn bạn đã mua hàng! Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
    <p>Email xác nhận đã được gửi đến địa chỉ email của bạn.</p>

    <a href="<%= request.getContextPath() %>/home" class="btn">Tiếp tục mua sắm</a>
</div>
</body>
</html>