package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String description; //
    private String image;
    private double price; //
    private int category;
    private String categoryName;
    private Date created;
    private boolean status;
    private List<ProductVariant> variants = new ArrayList<>();

    // Constructors
    public Product() {}

    public Product(int id, String name, String description, String image, double price, int category, boolean status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.category = category;
        this.status = status;
    }

    public Product(String name, String description, String image, double price, int category, boolean status) {
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.category = category;
        this.status = status;
    }

    public Product(String name, String description, String image, double price, int category, String categoryName, boolean status) {
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.category = category;
        this.categoryName = categoryName;
        this.status = status;
    }

    public Product(int id, String name, String description, String image, double price, int category, Date created, boolean status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.category = category;
        this.created = created;
        this.status = status;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getCategory() { return category; }
    public void setCategory(int category) { this.category = category; }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public void addVariant(ProductVariant variant) {
        this.variants.add(variant);
    }

    public List<ProductVariant> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariant> variants) {
        this.variants = variants;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }


}
