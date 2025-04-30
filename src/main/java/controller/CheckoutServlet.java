package controller;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Order;
import model.OrderDetail;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");
        String[] sizes = request.getParameterValues("size");
        String[] colors = request.getParameterValues("color");
        String totalAmount = request.getParameter("totalAmount");

        HttpSession session = request.getSession();
        session.setAttribute("productIds", productIds);
        session.setAttribute("quantities", quantities);
        session.setAttribute("prices", prices);
        session.setAttribute("sizes", sizes);
        session.setAttribute("colors", colors);
        session.setAttribute("totalAmount", totalAmount);

        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
    }
}

