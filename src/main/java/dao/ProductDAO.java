package dao;

import java.sql.*;
import java.util.*;
import model.Product;
import model.ProductVariant;

public class ProductDAO {
    private Connection conn;

    public ProductDAO() {
        conn = DBConnection.getConnection();
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.*, v.variant_id, v.color, v.size, v.variant_quantity, v.image_url AS variant_image_url, " +
                "c.name AS category_name " +
                "FROM products p " +
                "LEFT JOIN product_variants v ON p.product_id = v.product_id " +
                "LEFT JOIN categories c ON p.category_id = c.category_id"; // Thêm truy vấn cho category
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Product> productMap = new HashMap<>();

            while (rs.next()) {
                int productId = rs.getInt("product_id");

                // Kiểm tra nếu sản phẩm chưa có trong map
                Product p = productMap.get(productId);
                if (p == null) {
                    // Tạo đối tượng sản phẩm và thêm vào map
                    p = new Product(
                            productId,
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("image_url"),
                            rs.getDouble("price"),
                            rs.getInt("category_id"),
                            rs.getDate("created"),
                            rs.getBoolean("status")
                    );
                    p.setCategoryName(rs.getString("category_name")); // Thêm tên danh mục
                    productMap.put(productId, p);
                }

                // Lấy thông tin về variant và thêm vào sản phẩm
                int variantId = rs.getInt("variant_id");
                if (variantId != 0) { // Nếu có variant
                    ProductVariant variant = new ProductVariant(
                            variantId,
                            productId,
                            rs.getString("size"),
                            rs.getString("color"),
                            rs.getInt("variant_quantity"),
                            rs.getString("variant_image_url")
                    );
                    p.addVariant(variant);
                }
            }

            // Thêm tất cả sản phẩm vào danh sách trả về
            productList.addAll(productMap.values());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> searchProducts(String name) {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products WHERE name LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getDate("created"),
                        rs.getBoolean("status")
                );
                products.add(p);
            }
            System.out.println("Search SQL: SELECT * FROM products WHERE name LIKE '%" + name + "%'");
            System.out.println("Kết quả tìm được: " + products.size());


            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> searchProductsByCategory(int categoryID) {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products WHERE category_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryID );

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getDate("created"),
                        rs.getBoolean("status")
                );
                products.add(p);
            }
            System.out.println("Search SQL: SELECT * FROM products WHERE category_id = " + categoryID);
            System.out.println("Kết quả tìm được: " + products.size());


            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT p.*, c.name AS categoryName, pv.size, pv.color, pv.variant_quantity " +
                "FROM products p " +
                "JOIN categories c ON p.category_id = c.category_id " +
                "LEFT JOIN product_variants pv ON p.product_id = pv.product_id " +
                "WHERE p.product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            // Tạo đối tượng Product và gán các giá trị từ kết quả truy vấn
            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image_url"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("categoryName"));
                product.setCreated(rs.getDate("created"));
                product.setStatus(rs.getBoolean("status"));

                // Duyệt qua các variant và thêm vào danh sách của sản phẩm
                List<ProductVariant> variants = new ArrayList<>();
                do {
                    ProductVariant variant = new ProductVariant();
                    variant.setSize(rs.getString("size"));
                    variant.setColor(rs.getString("color"));
                    variant.setQuantity(rs.getInt("variant_quantity"));
                    variants.add(variant);
                } while (rs.next());

                product.setVariants(variants);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    public boolean updateStatus(int productId, boolean status) {
        String sql = "UPDATE products SET status = ? WHERE product_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, productId);

            // update
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu có ít nhất 1 bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE products SET name=?, price=?, image_url=?, description=?, category_id=?, status=? WHERE product_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getImage());
            ps.setString(4, product.getDescription());
            ps.setInt(5, product.getCategory());
            ps.setBoolean(6, product.isStatus());
            ps.setInt(7, product.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int insertProduct(Product product) {
        String sql = "INSERT INTO products (name, description, image_url, price, category_id, created, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        int generatedId = -1;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setString(3, product.getImage());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getCategory());

            // Ngày hiện tại theo kiểu java.sql.Date
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
            ps.setDate(6, currentDate);

            ps.setBoolean(7, product.isStatus());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}