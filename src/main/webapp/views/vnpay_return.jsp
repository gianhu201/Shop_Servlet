<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="vnpay.common.Config" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả thanh toán VNPay</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            padding: 40px;
        }
        .container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            width: 500px;
            text-align: center;
        }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
<div class="container">
    <h2>Kết quả thanh toán</h2>
    <%
        // Lấy tất cả tham số trả về từ VNPay
        Map<String, String> vnp_Params = new HashMap<>();
        for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
            vnp_Params.put(entry.getKey(), entry.getValue()[0]);
        }

        // Kiểm tra chữ ký
        String vnp_SecureHash = vnp_Params.get("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHash"); // Loại bỏ để tính toán lại chữ ký
        String calculatedHash = Config.hashAllFields(vnp_Params);

        String responseCode = vnp_Params.get("vnp_ResponseCode");
        String transactionId = vnp_Params.get("vnp_TxnRef");

        if (calculatedHash.equals(vnp_SecureHash)) {
            if ("00".equals(responseCode)) {
                // Thanh toán thành công
                // Cập nhật trạng thái đơn hàng trong cơ sở dữ liệu
                session.setAttribute("successMessage", "Thanh toán VNPay thành công! Mã đơn hàng: #" + transactionId);
                // Gửi email xác nhận (nếu cần)
                // util.EmailUtil.sendOrderConfirmationEmail(email, transactionId, totalAmount);
    %>
    <p class="success">Thanh toán thành công! Mã giao dịch: <%= transactionId %></p>
    <a href="<%= request.getContextPath() %>/views/order-success.jsp?orderId=<%= transactionId %>">Xem chi tiết đơn hàng</a>
    <%
    } else {
        // Thanh toán thất bại
    %>
    <p class="error">Thanh toán thất bại! Mã lỗi: <%= responseCode %></p>
    <a href="<%= request.getContextPath() %>/cart">Quay lại giỏ hàng</a>
    <%
        }
    } else {
        // Chữ ký không hợp lệ
    %>
    <p class="error">Chữ ký không hợp lệ! Giao dịch không được xác nhận.</p>
    <a href="<%= request.getContextPath() %>/cart">Quay lại giỏ hàng</a>
    <%
        }
    %>
</div>
</body>
</html>