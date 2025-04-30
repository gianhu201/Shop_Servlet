package dao;

import model.CartItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    public static void addProductToCart(int userId, int productId, int quantity, String size, String color) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        String checkSql = "SELECT cart_id, quantity FROM cart WHERE user_id = ? AND product_id = ? AND size = ? AND color = ? AND status = 'pending'";

        try (Connection conn = dao.DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            checkStmt.setString(3, size);
            checkStmt.setString(4, color);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // Sản phẩm đã có trong giỏ hàng, cộng thêm số lượng
                    int existingQuantity = rs.getInt("quantity");
                    int cartId = rs.getInt("cart_id");
                    int newQuantity = existingQuantity + quantity;

                    // Cập nhật số lượng sản phẩm trong giỏ hàng
                    String updateSql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, newQuantity);
                        updateStmt.setInt(2, cartId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // Sản phẩm chưa có trong giỏ hàng, thêm mới
                    String insertSql = "INSERT INTO cart (user_id, product_id, quantity, size, color) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, productId);
                        insertStmt.setInt(3, quantity);
                        insertStmt.setString(4, size);
                        insertStmt.setString(5, color);
                        insertStmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.cart_id, c.product_id, c.quantity, c.size, c.color, p.name, p.price, p.image_url " +
                "FROM cart c JOIN products p ON c.product_id = p.product_id " +
                "WHERE c.user_id = ? AND c.status = 'pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int cartId = rs.getInt("cart_id");
                    int productId = rs.getInt("product_id");
                    int quantity = rs.getInt("quantity");
                    String size = rs.getString("size");
                    String color = rs.getString("color");
                    String productName = rs.getString("name");
                    String productImage = rs.getString("image_url");
                    double price = rs.getDouble("price");

                    cartItems.add(new CartItem(cartId, productId, productName, productImage, price, quantity, size, color));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public static void updateCartQuantity(int userId, int productId, String size, String color, int quantity) {
        // Kiểm tra xem sản phẩm có trong giỏ hàng hay không
        String checkSql = "SELECT cart_id, quantity FROM cart WHERE user_id = ? AND product_id = ? AND size = ? AND color = ? AND status = 'pending'";

        try (Connection conn = dao.DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            checkStmt.setString(3, size);
            checkStmt.setString(4, color);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    int cartId = rs.getInt("cart_id");

                    // Kiểm tra nếu quantity > 0 và cập nhật
                    if (quantity <= 0) {
                        // Nếu số lượng <= 0, xóa sản phẩm khỏi giỏ hàng
                        String deleteSql = "DELETE FROM cart WHERE cart_id = ?";
                        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                            deleteStmt.setInt(1, cartId);
                            deleteStmt.executeUpdate();
                        }
                    } else {
                        // Cập nhật lại số lượng sản phẩm bằng số lượng từ form
                        String updateSql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                            updateStmt.setInt(1, quantity);  // Cập nhật số lượng mới
                            updateStmt.setInt(2, cartId);
                            updateStmt.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void removeProductFromCart(int userId, int productId, String size, String color) {
        // Kiểm tra xem sản phẩm có trong giỏ hàng hay không
        String checkSql = "SELECT cart_id FROM cart WHERE user_id = ? AND product_id = ? AND size = ? AND color = ? AND status = 'pending'";

        try (Connection conn = dao.DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            checkStmt.setString(3, size);
            checkStmt.setString(4, color);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    int cartId = rs.getInt("cart_id");

                    // Xóa sản phẩm khỏi giỏ hàng
                    String deleteSql = "DELETE FROM cart WHERE cart_id = ?";
                    try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                        deleteStmt.setInt(1, cartId);
                        deleteStmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void clearCart(int userId) {
        String deleteSql = "DELETE FROM cart WHERE user_id = ?";

        try (Connection conn = dao.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}