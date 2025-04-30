package dao;

import model.ProductVariant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ProductVariantDAO {

    public void deleteVariantsByProductId(int productId) {
        String sql = "DELETE FROM product_variants WHERE product_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertVariant(ProductVariant variant) {
        String sql = "INSERT INTO product_variants(product_id, color, size, variant_quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, variant.getProductId());
            ps.setString(2, variant.getColor());
            ps.setString(3, variant.getSize());
            ps.setInt(4, variant.getQuantity());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();
        String sql = "SELECT * FROM product_variants WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductVariant variant = new ProductVariant();
                    variant.setId(rs.getInt("variant_id"));
                    variant.setProductId(rs.getInt("product_id"));
                    variant.setColor(rs.getString("color"));
                    variant.setSize(rs.getString("size"));
                    variant.setQuantity(rs.getInt("variant_quantity"));
                    variant.setImageUrl(rs.getString("image_url"));

                    variants.add(variant);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return variants;
    }

    public Set<String> getColorsByProductId(int productId) {
        Set<String> colors = new HashSet<>();
        String sql = "SELECT DISTINCT color FROM product_variants WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    colors.add(rs.getString("color"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return colors;
    }

    public Set<String> getSizesByProductId(int productId) {
        Set<String> sizes = new HashSet<>();
        String sql = "SELECT DISTINCT size FROM product_variants WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sizes.add(rs.getString("size"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sizes;
    }

    public void updateVariant(ProductVariant variant) {
        String sql = "UPDATE product_variants SET color=?, size=?, variant_quantity=?, image_url=? WHERE variant_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, variant.getColor());
            ps.setString(2, variant.getSize());
            ps.setInt(3, variant.getQuantity());
            ps.setString(4, variant.getImageUrl());
            ps.setInt(5, variant.getId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ProductVariant getVariantByProductIdAndColorAndSize(int productId, String color, String size) {
        String sql = "SELECT * FROM product_variants WHERE product_id = ? AND LOWER(color) = LOWER(?) AND LOWER(size) = LOWER(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, color);
            ps.setString(3, size);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductVariant variant = new ProductVariant();
                    variant.setId(rs.getInt("variant_id"));
                    variant.setProductId(rs.getInt("product_id"));
                    variant.setColor(rs.getString("color"));
                    variant.setSize(rs.getString("size"));
                    variant.setQuantity(rs.getInt("variant_quantity"));
                    variant.setImageUrl(rs.getString("image_url"));

                    return variant;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    //    Kiểm tra sự tồn tại
    private boolean variantExists(int productId, String color, String size) {
        String sql = "SELECT COUNT(*) FROM product_variants WHERE product_id = ? AND color = ? AND size = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, color);
            ps.setString(3, size);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public void addNewColorToProduct(int productId, String newColor) {
        Set<String> sizes = getSizesByProductId(productId);

        for (String size : sizes) {
            ProductVariant newVariant = new ProductVariant();
            newVariant.setProductId(productId);
            newVariant.setColor(newColor);
            newVariant.setSize(size);
            newVariant.setQuantity(0); // Mặc định số lượng ban đầu là 0

            if (!variantExists(productId, newColor, size)) {
                insertVariant(newVariant);
            }
        }
    }

    public void addNewSizeToProduct(int productId, String newSize) {
        Set<String> colors = getColorsByProductId(productId);

        for (String color : colors) {
            ProductVariant newVariant = new ProductVariant();
            newVariant.setProductId(productId);
            newVariant.setColor(color);
            newVariant.setSize(newSize);
            newVariant.setQuantity(0);

            if (!variantExists(productId, color, newSize)) {
                insertVariant(newVariant);
            }
        }
    }

    public void addNewVariantType(int productId, String newColor, String newSize) {
        ProductVariant newVariant = new ProductVariant();
        newVariant.setProductId(productId);
        newVariant.setColor(newColor);
        newVariant.setSize(newSize);
        newVariant.setQuantity(0);

        if (!variantExists(productId, newColor, newSize)) {
            insertVariant(newVariant);
        }
    }

}