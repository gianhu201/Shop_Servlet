<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán và Giao Hàng</title>
    <script src="<%= request.getContextPath() %>/views/js/checkout_validation.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f9fc;
            display: flex;
            justify-content: center;
            padding: 40px;
        }
        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            width: 500px;
        }
        .form-container h2 {
            font-size: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
            display: flex;
            gap: 10px;
        }
        .form-group.full {
            display: block;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .form-group .error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        .note {
            margin-top: 20px;
            font-style: italic;
            color: #555;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="form-container">
    <%@ page import="model.OrderDetail" %>
    <%@ page import="java.util.List" %>
    <%
        List<OrderDetail> cartItems = (List<OrderDetail>) session.getAttribute("checkoutCart");
    %>

    <h2>THANH TOÁN VÀ GIAO HÀNG</h2>
    <form action="order" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <input type="text" name="recipientName" placeholder="Tên" id="recipientName">
            <div id="recipientNameError" class="error"></div>
        </div>
        <div class="form-group full">
            <select name="country" id="country" required>
                <option value="VN">Việt Nam</option>
            </select>
            <div id="countryError" class="error"></div>
        </div>
        <div class="form-group">
            <input type="text" name="address" placeholder="Địa chỉ" id="address">
            <div id="addressError" class="error"></div>
            <input type="text" name="city" placeholder="Tỉnh / Thành phố" id="city">
            <div id="cityError" class="error"></div>
        </div>
        <div class="form-group full">
            <input type="text" name="phone" placeholder="Số điện thoại" id="phone">
            <div id="phoneError" class="error"></div>
        </div>
        <div class="form-group full">
            <input type="email" name="email" placeholder="Địa chỉ email" id="email">
            <div id="emailError" class="error"></div>
        </div>

        <!-- Dòng chọn phương thức thanh toán -->
        <div class="form-group full">
            <select name="paymentMethod" id="paymentMethod">
                <option value="" disabled selected>Chọn phương thức thanh toán</option>
                <option value="cod">Thanh toán khi nhận hàng (COD)</option>
                <option value="vnpay">Thanh toán VNPay</option>
            </select>
            <div id="paymentMethodError" class="error"></div>
        </div>

        <div class="note">
            Xác nhận thanh toán
        </div>

        <!--reCAPTCHA toi khong phai nguoi may -->
            <div class="g-recaptcha" data-sitekey="6Ld7jR8rAAAAAJd3VSc3NYZxr460ikwEZz-13NJI"></div>
        <!-- Load API reCAPTCHA -->


        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <!--reCAPTCHA toi khong phai nguoi may -->

        <!-- Các trường sản phẩm lấy từ session -->
        <c:forEach var="i" begin="0" end="${fn:length(sessionScope.productIds) - 1}">
            <input type="hidden" name="productId" value="${sessionScope.productIds[i]}" />
            <input type="hidden" name="quantity" value="${sessionScope.quantities[i]}" />
            <input type="hidden" name="price" value="${sessionScope.prices[i]}" />
            <input type="hidden" name="size" value="${sessionScope.sizes[i]}" />
            <input type="hidden" name="color" value="${sessionScope.colors[i]}" />
        </c:forEach>
        <input type="hidden" name="totalAmount" value="${sessionScope.totalAmount}" />

        <button type="submit">Đặt hàng</button>
    </form>

</div>
</body>

</html>
