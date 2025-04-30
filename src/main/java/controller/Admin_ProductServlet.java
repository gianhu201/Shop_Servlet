package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductVariantDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Product;
import model.ProductVariant;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/ADproduct")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class Admin_ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private ProductVariantDAO variantDAO = new ProductVariantDAO();
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        variantDAO = new ProductVariantDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String successMessage = (String) request.getSession().getAttribute("successMessage");
        String errorMessage = (String) request.getSession().getAttribute("errorMessage");

        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }

        String editId = request.getParameter("editId");

        if (editId != null) {
            int productId = Integer.parseInt(editId);
            Product product = productDAO.getProductById(productId);
            request.setAttribute("editProduct", product);

            List<ProductVariant> variants = variantDAO.getVariantsByProductId(productId);


            // Tạo danh sách màu sắc duy nhất
            List<String> colors = variants.stream()
                    .map(ProductVariant::getColor)
                    .distinct()
                    .collect(Collectors.toList());

            // Tạo danh sách kích thước duy nhất
            List<String> sizes = variants.stream()
                    .map(ProductVariant::getSize)
                    .distinct()
                    .collect(Collectors.toList());


            request.setAttribute("variants", variants);
            request.setAttribute("colors", colors);
            request.setAttribute("sizes", sizes);
        }
        request.setAttribute("products", productDAO.getAllProducts());
        request.setAttribute("categoryList", categoryDAO.getAllCategories());

        request.getRequestDispatcher("/views/admin/ADproduct.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {
            case "update":
                updateProduct(request, response);
                break;
            case "add":
                addProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/ADproduct");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("add-name");
        String description = request.getParameter("add-description");
        boolean status = request.getParameter("add-status") != null;
        String priceParam = request.getParameter("add-price");
        double price = parseDoubleSafe(priceParam);

        String categoryParam = request.getParameter("add-category");
        int categoryId = parseIntSafe(categoryParam);


        Part imagePart = request.getPart("add-image");
        String imageFileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            String realPath = request.getServletContext().getRealPath("/views/images");
            imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imagePart.write(realPath + File.separator + imageFileName);
        }

        if (imageFileName == null || imageFileName.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng chọn ảnh cho sản phẩm.");
            response.sendRedirect(request.getContextPath() + "/admin/ADproduct");
            return;
        }

        Product newProduct = new Product(name, description, imageFileName, price, categoryId, status);
        productDAO.insertProduct(newProduct);

        request.getSession().setAttribute("successMessage", "Thêm sản phẩm thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/ADproduct");

    }


    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        boolean status = request.getParameter("status") != null;
        double price = Double.parseDouble(request.getParameter("price"));

        Part imagePart = request.getPart("image");
        String imageFileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            String realPath = request.getServletContext().getRealPath("/views/images");
            imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imagePart.write(realPath + File.separator + imageFileName);
        }

        Product oldProduct = productDAO.getProductById(id);
        if (oldProduct == null) {
            request.setAttribute("errorMessage", "Không tìm thấy sản phẩm cần cập nhật!");
            response.sendRedirect(request.getContextPath() + " /admin/ADproduct");
            return;
        }

        if (imageFileName == null || imageFileName.isEmpty()) {
            imageFileName = oldProduct.getImage();
        }

        Product updatedProduct = new Product(id, name, description, imageFileName, price, categoryId, status);
        productDAO.updateProduct(updatedProduct);

        String[] colors = request.getParameterValues("color");
        String[] sizes = request.getParameterValues("size");

        if (colors != null && sizes != null) {
            for (String color : colors) {
                for (String size : sizes) {
                    String quantityParam = request.getParameter("quantity_" + color + "_" + size);
                    int quantity = Math.max(0, parseIntSafe(quantityParam));
                    ProductVariant existingVariant = variantDAO.getVariantByProductIdAndColorAndSize(id, color, size);

                    if (existingVariant != null && existingVariant.getQuantity() != quantity) {
                        existingVariant.setQuantity(quantity);
                        variantDAO.updateVariant(existingVariant);
                    } else if (existingVariant == null && quantity > 0) {
                        variantDAO.insertVariant(new ProductVariant(id, color, size, quantity));
                    }
                }
            }
        }

        String newColor = request.getParameter("updateColor");
        String newSize = request.getParameter("updateSize");

        if (newColor != null && !newColor.isEmpty() && newSize != null && !newSize.isEmpty()) {
            ProductVariant existingVariant = variantDAO.getVariantByProductIdAndColorAndSize(id, newColor, newSize);
            if (existingVariant == null) {
                variantDAO.insertVariant(new ProductVariant(id, newColor, newSize, 0));
                request.setAttribute("successMessage", "Đã thêm màu và kích thước mới!");
            } else {
                request.setAttribute("errorMessage", "Biến thể này đã tồn tại!");
            }
        }

        request.getSession().setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/ADproduct");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        int productId = parseIntSafe(idParam);

        Product product = productDAO.getProductById(productId);
        if (product == null) {
            request.getSession().setAttribute("errorMessage", "Không tìm thấy sản phẩm cần xóa!");
            response.sendRedirect(request.getContextPath() + "/admin/ADproduct");
            return;
        }

        // Xóa các biến thể liên quan trước
        variantDAO.deleteVariantsByProductId(productId);

        boolean success = productDAO.deleteProduct(productId);

        if (success) {
            // Xóa tệp ảnh nếu tồn tại
            String imagePath = request.getServletContext().getRealPath("/views/images") + File.separator + product.getImage();
            File imageFile = new File(imagePath);
            if (imageFile.exists()) {
                imageFile.delete();
            }

            request.getSession().setAttribute("successMessage", "Xóa sản phẩm thành công!");
        } else {
            request.getSession().setAttribute("errorMessage", "Xóa sản phẩm thất bại!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/ADproduct");
    }

    private int parseIntSafe(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private double parseDoubleSafe(String value) {
        try {
            return value != null && !value.isEmpty() ? Double.parseDouble(value) : 0.0;
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
}
