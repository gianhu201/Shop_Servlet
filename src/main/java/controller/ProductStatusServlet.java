package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/update-product-status")
public class ProductStatusServlet extends HttpServlet{
    private ProductDAO productDAO;

    public ProductStatusServlet() {
        productDAO = new ProductDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID");
            return;
        }

        String status = request.getParameter("status");
        boolean newStatus = (status != null && status.equals("on"));  // Chuyển đổi trạng thái từ "on" thành true, ngược lại thành false

        boolean isUpdated = productDAO.updateStatus(productId, newStatus);

        if (isUpdated) {
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("views/admin/ADproduct.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update product status");
        }
    }
}


