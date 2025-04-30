package controller;

import dao.CartDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.OrderDetail;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(util.EmailUtil.class);

    private OrderDAO orderDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/cart");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("userId hien tai: "+ userId);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        List<OrderDetail> details = new ArrayList<>();

        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");
        String[] sizes = request.getParameterValues("size");
        String[] colors = request.getParameterValues("color");

        String recipientName = request.getParameter("recipientName");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String phoneNumber = request.getParameter("phone");
        String email = request.getParameter("email");
        String paymentMethod = request.getParameter("paymentMethod");

        double totalAmount = 0;
        for (int i = 0; i < productIds.length; i++) {
            OrderDetail detail = new OrderDetail();
            detail.setProductId(Integer.parseInt(productIds[i]));
            detail.setQuantity(Integer.parseInt(quantities[i]));
            detail.setPrice(Double.parseDouble(prices[i]));
            detail.setSize(sizes[i]);
            detail.setColor(colors[i]);
            details.add(detail);

            System.out.println("Product ID: " + productIds[i] + ", Quantity: " + quantities[i] + ", Price: " + prices[i] + ", Size: " + sizes[i] + ", Color: " + colors[i]);
            totalAmount += detail.getPrice() * detail.getQuantity();
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setStatus("processing");
        order.setEmailConfirmed(email);
        order.setRecipientName(recipientName);
        order.setPhoneNumber(phoneNumber);
        order.setAddress(address);
        order.setPaymentMethod(paymentMethod);
        order.setOrderDetails(details);

        String recaptchaResponse = request.getParameter("g-recaptcha-response");

        if (!util.Recaptcha.verify(recaptchaResponse)) {
            logger.info("Xác minh reCAPTCHA thất bại ");
            request.setAttribute("errorMessage", "Xác minh reCAPTCHA thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("/form.jsp").forward(request, response);
            return;
        }

        int orderId = orderDAO.insertOrder(order);// Nhận lại order_id từ DB

        if (orderId > 0) {
            orderDAO.insertOrderDetails(orderId, details);
            cartDAO.clearCart(userId);
            session.removeAttribute("cart");

            if ("cod".equals(paymentMethod)) {
                session.setAttribute("successMessage", "Đặt hàng thành công! Mã đơn hàng của bạn là #" + orderId);
                util.EmailUtil.sendOrderConfirmationEmail(email, String.valueOf(orderId), totalAmount);
                response.sendRedirect("views/order-success.jsp?orderId=" + orderId);
            } else if ("vnpay".equals(paymentMethod)) {
                // Nếu là VNPAY → chuyển hướng sang servlet thanh toán VNPAY
                session.setAttribute("vnp_order", order); // lưu order tạm
                session.setAttribute("vnp_orderId", orderId);
                response.sendRedirect(request.getContextPath() + "/vnpay");
            }

        } else {
            response.getWriter().println("Lỗi khi tạo đơn hàng.");
        }
    }
}
