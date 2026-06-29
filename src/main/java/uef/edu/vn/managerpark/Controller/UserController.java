package uef.edu.vn.managerpark.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import uef.edu.vn.managerpark.dao.UserDAO;
import uef.edu.vn.managerpark.model.User;

@Controller
public class UserController {

    // Sử dụng cơ chế ép kiểu tự động (Dependency Injection) của Spring
    @Autowired
    private UserDAO userDAO;

    // Kiểm tra nhanh quyền ADMIN để tái sử dụng, tránh lặp code (DRY)
    private boolean isAdmin(HttpSession session) {
        User loginUser = (User) session.getAttribute("user");
        return loginUser != null && "ADMIN".equals(loginUser.getRole());
    }

    /* ==========================================
     * 1. DANH SÁCH TÀI KHOẢN
     * ========================================== */
    @GetMapping("/users")
    public String users(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard"; // Hoặc redirect:/login nếu session null
        }

        model.addAttribute("activeTab", "users");
        model.addAttribute("users", userDAO.getAllUsers());
        model.addAttribute("viewContent", "/WEB-INF/views/users.jsp"); // Đường dẫn tùy cấu trúc dự án bạn
        return "layout"; // Trả về trang layout chính chứa thanh sidebar
    }

    /* ==========================================
     * 2. TẠO TÀI KHOẢN (GET & POST)
     * ========================================== */
    @GetMapping("/create-user")
    public String createUserPage(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard";
        }

        model.addAttribute("activeTab", "create-user");
        model.addAttribute("viewContent", "/WEB-INF/views/create-user.jsp");
        return "layout";
    }

    // Đổi lại url thành "/users/create" để khớp hoàn toàn với thuộc tính action của Form
    @PostMapping("/users/create")
    public String createUser(
            HttpSession session,
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String fullName,
            @RequestParam(required = false) String phoneNumber, // Nhận thêm số điện thoại
            @RequestParam String role,
            Model model) {

        if (!isAdmin(session)) {
            return "redirect:/dashboard";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setPhoneNumber(phoneNumber);
        user.setRole(role);

        boolean success = userDAO.createUser(user);

        if (success) {
            return "redirect:/users?success=create"; // Tạo xong đẩy về danh sách cho tiện theo dõi
        } else {
            model.addAttribute("message", "Lỗi: Tên đăng nhập đã tồn tại!");
            model.addAttribute("viewContent", "/WEB-INF/views/create-user.jsp");
            return "layout";
        }
    }

    /* ==========================================
     * 3. XÓA TÀI KHOẢN 
     * ========================================== */
    @GetMapping("/users/delete/{id}")
    public String deleteUser(HttpSession session, @PathVariable int id) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard";
        }

        // Ngăn chặn admin tự xóa chính mình dựa trên session hiện tại
        User loginUser = (User) session.getAttribute("user");
        User userToDelete = userDAO.getUserById(id); // Giả định DAO có hàm này

        if (userToDelete != null && !loginUser.getUsername().equals(userToDelete.getUsername())) {
            userDAO.deleteUser(id); // Giả định DAO có hàm này
        }

        return "redirect:/users";
    }

    /* ==========================================
     * 4. SỬA TÀI KHOẢN (Bổ sung để giao diện không bị lỗi 404)
     * ========================================== */
    @GetMapping("/users/edit/{id}")
    public String editUserPage(HttpSession session, @PathVariable int id, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard";
        }

        User user = userDAO.getUserById(id);
        model.addAttribute("userEdit", user); // Đẩy dữ liệu user cần sửa qua
        model.addAttribute("viewContent", "/WEB-INF/views/create-user.jsp"); // <--- Đổi thành file create-user luôn!
        return "layout";
    }

    @PostMapping("/users/update")
public String updateUser(
        HttpSession session,
        @RequestParam int id,
        @RequestParam String fullName,
        @RequestParam(required = false) String password, // Hứng thêm mật khẩu mới
        @RequestParam(required = false) String phoneNumber,
        @RequestParam String role) {

    User loginUser = (User) session.getAttribute("user");
    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
        return "redirect:/dashboard";
    }

    User user = new User();
    user.setId(id);
    user.setFullName(fullName);
    user.setPhoneNumber(phoneNumber);
    user.setRole(role);
    user.setPassword(password); // Truyền mật khẩu vào (có thể trống)

    userDAO.updateUser(user);
    return "redirect:/users";
}
}
