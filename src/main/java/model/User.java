package model;

public class User {
    private int userId;
    private String email;
    private String fullname;
    private String role;

    public User(String email, String fullname) {
        this.email = email;
        this.fullname = fullname;
    }

    public User(int userId, String email, String fullname) {
        this.userId = userId;
        this.email = email;
        this.fullname = fullname;
    }

    public User(String email) {
        this.email = email;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getUserId() {
        return userId;
    }

    public String getEmail() {
        return email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
}
