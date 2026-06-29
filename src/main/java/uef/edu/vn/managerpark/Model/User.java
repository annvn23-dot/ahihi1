package uef.edu.vn.managerpark.model;

public class User {

    private int id;
    private String username;
    private String password;
    private String fullName;
    private String phoneNumber; // Bổ sung thuộc tính số điện thoại
    private String role;

    // Constructor mặc định (Không tham số)
    public User() {}

    // Constructor đầy đủ tham số (Hữu ích khi tạo nhanh đối tượng)
    public User(int id, String username, String password, String fullName, String phoneNumber, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Getter và Setter cho phoneNumber mới thêm
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}