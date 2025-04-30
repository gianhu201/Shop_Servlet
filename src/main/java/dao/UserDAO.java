package dao;

import model.User;

import java.sql.*;

public class UserDAO {
    public static User getUserByEmailAndPassword(String email, String password) throws SQLException {
        String sql = "SELECT u.user_id, u.email, u.full_name FROM users u WHERE u.email = ? AND u.password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String userEmail = rs.getString("email");
                    String fullName = rs.getString("full_name");
                    return new User(userId, userEmail, fullName); // dùng constructor có fullName
                }
            }
        }
        return null;
    }


    public static String getUserRole(int userId) throws SQLException {
        String sql = "SELECT r.role_name " +
                "FROM roles r " +
                "JOIN user_roles ur ON r.role_id = ur.role_id " +
                "WHERE ur.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("role_name");
                }
            }
        }

        return null;
    }

    public static User getUserByEmail(String email) throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE email = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("user_id");
            String userEmail = rs.getString("email");
            String fullName = rs.getString("full_name");
            User user = new User(userId, userEmail, fullName);
            user.setFullname(fullName);
            return user;
        }
        return null;
    }

    public static void insertUser(User user) throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO users (email, full_name) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getEmail());
        ps.setString(2, user.getFullname());
        ps.executeUpdate();
    }

    //add role
    public static void assignRoleToUser(int userId, int roleId) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try {
            String sql = "INSERT INTO user_roles (user_id, role_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, roleId);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Lỗi khi gán vai trò cho người dùng: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
}
