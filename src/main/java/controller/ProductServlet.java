package controller;

import dao.ProductDAO;
import dao.CategoryDAO;
import model.Product;
import model.Category;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String categoryIdStr = request.getParameter("categoryId");

        System.out.println("categoryId: "+categoryIdStr);
        List<Product> productList = new ArrayList<>();

        try {
            if (name != null && !name.isEmpty()) {
                // Chỉ tìm theo tên
                System.out.println("Searching by name");
                productList = productDAO.searchProducts(name);
            } else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                // Chỉ tìm theo danh mục
                int categoryId = Integer.parseInt(categoryIdStr);
                System.out.println("Searching by category");
                productList = productDAO.searchProductsByCategory(categoryId);
                System.out.println("categoryId: " + categoryIdStr);
            } else {
                // Không có gì => Lấy toàn bộ
                System.out.println("Getting all products");
                productList = productDAO.getAllProducts();
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("Invalid categoryId format.");
        }

        request.setAttribute("products", productList);
        request.getRequestDispatcher("/views/product.jsp").forward(request, response);
    }

}