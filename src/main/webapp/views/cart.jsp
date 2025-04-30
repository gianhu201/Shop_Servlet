<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .cart-container {
            width: 80%;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
        }


        input[type="number"] {
            width: 60px;
            padding: 5px;
            margin: 0;
        }

        .total {
            text-align: right;
            padding: 10px 0;
        }

        .checkout-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background: #5cb85c;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        .checkout-btn:hover {
            background: #4cae4c;
        }
    </style>
</head>
<body>
<div class="cart-container">
    <h1>Giỏ hàng của bạn</h1>

    <!-- Kiểm tra nếu giỏ hàng trống -->
    <c:if test="${empty cartItems}">
        <p>Giỏ hàng của bạn hiện tại chưa có sản phẩm.</p>
    </c:if>

<!-- Hiển thị các sản phẩm trong giỏ hàng -->
<c:if test="${not empty cartItems}">
    <table>
        <thead>
        <tr>
            <th>Hình ảnh</th>
            <th>Sản phẩm</th>
            <th>Kích thước</th>
            <th>Màu sắc</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Tổng cộng</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td><img src="${pageContext.request.contextPath}/views/images/${item.productImage}" alt="..." width="100px" height="100px"></td>
                <td>${item.productName}</td>
                <td>${item.size}</td>
                <td>${item.color}</td>
                <td> <!-- Cập nhật số lượng sản phẩm -->
                    <form action="${pageContext.request.contextPath}/update-cart" method="post">
                        <input type="hidden" name="productId" value="${item.productId}">
                        <input type="hidden" name="size" value="${item.size}">
                        <input type="hidden" name="color" value="${item.color}">
                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control" style="width: 70px;">
                        <button type="submit" class="btn btn-info">Cập nhật</button>
                    </form>
                </td>
                <td><fmt:formatNumber value="${item.price}" type="number" pattern="#,###" /> VND</td>
                <td><fmt:formatNumber value="${item.price * item.quantity}" type="number" pattern="#,###" /> VND</td>
                <td>
                    <form action="${pageContext.request.contextPath}/remove-from-cart" method="post">
                        <input type="hidden" name="productId" value="${item.productId}" />
                        <input type="hidden" name="size" value="${item.size}" />
                        <input type="hidden" name="color" value="${item.color}" />
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="total">
        <p>Tổng tiền: <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,###" />
         VND</p>
    </div>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <c:forEach var="item" items="${cartItems}">
            <input type="hidden" name="productId" value="${item.productId}" />
            <input type="hidden" name="quantity" value="${item.quantity}" />
            <input type="hidden" name="price" value="${item.price}" />
            <input type="hidden" name="size" value="${item.size}" />
            <input type="hidden" name="color" value="${item.color}" />
        </c:forEach>
        <input type="hidden" name="totalAmount" value="${totalPrice}" />
        <button type="submit" class="checkout-btn">Thanh toán</button>
    </form>




</c:if>

</div>
</body>
</html>
