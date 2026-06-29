package uef.edu.vn.managerpark.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.springframework.stereotype.Repository;
import uef.edu.vn.managerpark.model.User;
import uef.edu.vn.managerpark.dao.DBConnection; // Đảm bảo đúng package chứa lớp kết nối của bạn

import java.util.ArrayList;
import java.util.List;

@Repository // Thêm Annotation để Spring Boot quản lý Bean này
public class UserDAO {

    /* ==========================================
     * 1. LẤY TẤT CẢ TÀI KHOẢN (Cập nhật phone_number)
     * ========================================== */
    public List<User> getAllUsers() {
    List<User> list = new ArrayList<>();
    String sql = "SELECT * FROM users";

    try (
        Connection conn = DBConnection.getConnection(); 
        PreparedStatement ps = conn.prepareStatement(sql); 
        ResultSet rs = ps.executeQuery()
    ) {
        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password")); // <--- THÊM DÒNG NÀY ĐỂ LẤY MẬT KHẨU
            user.setFullName(rs.getString("full_name"));
            user.setPhoneNumber(rs.getString("phone_number"));
            user.setRole(rs.getString("role"));

            list.add(user);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    /* ==========================================
     * 2. ĐĂNG NHẬP HỆ THỐNG
     * ========================================== */
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username=? AND password=?";

        try (
            Connection conn = DBConnection.getConnection(); 
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("full_name")); // Nên lấy cả tên khi đăng nhập thành công
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /* ==========================================
     * 3. TẠO TÀI KHOẢN MỚI (Cập nhật phone_number)
     * ========================================== */
    public boolean createUser(User user) {
        String sql = "INSERT INTO users(username, password, full_name, phone_number, role) VALUES(?,?,?,?,?)";

        try (
            Connection conn = DBConnection.getConnection(); 
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPhoneNumber()); // Bổ sung lưu SĐT
            ps.setString(5, user.getRole());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ==========================================
     * 4. LẤY TÀI KHOẢN THEO ID (Viết thêm phục vụ sửa đổi)
     * ========================================== */
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("full_name"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /* ==========================================
     * 5. XÓA TÀI KHOẢN (Viết thêm phục vụ xóa nhân viên)
     * ========================================== */
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

  public boolean updateUser(User user) {
    String sql;
    // Nếu mật khẩu không trống, cập nhật cả mật khẩu, ngược lại thì giữ nguyên
    boolean updatePass = user.getPassword() != null && !user.getPassword().trim().isEmpty();
    
    if (updatePass) {
        sql = "UPDATE users SET full_name = ?, phone_number = ?, role = ?, password = ? WHERE id = ?";
    } else {
        sql = "UPDATE users SET full_name = ?, phone_number = ?, role = ? WHERE id = ?";
    }
    
    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)
    ) {
        ps.setString(1, user.getFullName());
        ps.setString(2, user.getPhoneNumber());
        ps.setString(3, user.getRole());
        
        if (updatePass) {
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getId());
        } else {
            ps.setInt(4, user.getId());
        }
        
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}