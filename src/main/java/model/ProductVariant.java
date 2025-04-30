package model;

public class ProductVariant {
    private int id;
    private int productId;
    private String size;
    private String color;
    private int quantity;
    private String imageUrl;

    public ProductVariant() {
    }

    public ProductVariant(int id, int productId, String size, String color, int quantity) {
        this.id = id;
        this.productId = productId;
        this.size = size;
        this.color = color;
        this.quantity = quantity;
    }

    public ProductVariant(int productId, String color, String size, int quantity) {
        this.productId = productId;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
    }

    public ProductVariant(int id, int productId, String size, String color, int quantity, String imageUrl) {
        this.id = id;
        this.productId = productId;
        this.size = size;
        this.color = color;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "ProductVariant [id=" + id + ", productId=" + productId + ", size=" + size + ", color=" + color
                + ", quantity=" + quantity + ", imageUrl=" + imageUrl + "]";
    }
}