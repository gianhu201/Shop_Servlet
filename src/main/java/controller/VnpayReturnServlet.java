package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import util.EmailUtil;
import vnpay.common.Config;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet("/vnpay-return")
public class VnpayReturnServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer orderId = (Integer) session.getAttribute("vnp_orderId");
        Order order = (Order) session.getAttribute("vnp_order");
        String email = order != null ? order.getEmailConfirmed(): "";

        if (orderId == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        Map<String, String> vnp_Params = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty() && fieldName.startsWith("vnp_")) {
                vnp_Params.put(fieldName, fieldValue);
            }
        }

        // Remove hash params
        if (vnp_Params.containsKey("vnp_SecureHashType")) {
            vnp_Params.remove("vnp_SecureHashType");
        }
        if (vnp_Params.containsKey("vnp_SecureHash")) {
            vnp_Params.remove("vnp_SecureHash");
        }

        // Sort field names
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        // Create the hash string exactly as VNPAY expects
        StringBuilder hashData = new StringBuilder();

        for (int i = 0; i < fieldNames.size(); i++) {
            String fieldName = fieldNames.get(i);
            String fieldValue = vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                hashData.append(fieldName).append("=")
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII)); // encoding
                if (i < fieldNames.size() - 1) {
                    hashData.append("&");
                }
            }
        }


        // Calculate signature
        String signValue = Config.hmacSHA512(Config.secretKey, hashData.toString());

        // Debug logging
        System.out.println("Expected hash: " + vnp_SecureHash);
        System.out.println("Calculated hash: " + signValue);
        System.out.println("Hash string: " + hashData.toString());


        // Response handling
        if (vnp_SecureHash != null && vnp_SecureHash.equals(signValue)) {
            String responseCode = request.getParameter("vnp_ResponseCode");
            if ("00".equals(responseCode)) {
                // Payment successful
                orderDAO.updateOrderPaymentStatus(orderId, "completed");
                session.removeAttribute("cart");
                session.removeAttribute("vnp_order");
                session.removeAttribute("vnp_orderId");

                if (email != null && !email.isEmpty()) {
                    EmailUtil.sendOrderConfirmationEmail(email, String.valueOf(orderId), order.getTotalAmount());
                }

                request.setAttribute("successMessage", "Thanh toán thành công! Mã đơn hàng của bạn là #" + orderId);
                response.sendRedirect(request.getContextPath() + "/views/order-success.jsp?orderId=" + orderId);
            } else {
                // Payment failed with error code
                orderDAO.updateOrderPaymentStatus(orderId, "failed");
                request.setAttribute("errorMessage", "Thanh toán không thành công. Mã lỗi: " + responseCode);
                response.sendRedirect(request.getContextPath() + "/views/order-failed.jsp?orderId=" + orderId);
            }
        } else {
            // Hash verification failed
            System.out.println("Invalid signature - Hash mismatch");
            orderDAO.updateOrderPaymentStatus(orderId, "failed");

            // Pass orderId to the failed page
            response.sendRedirect(request.getContextPath() + "/views/order-failed.jsp?orderId=" + orderId);
        }
    }
}