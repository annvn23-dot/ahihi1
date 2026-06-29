package uef.edu.vn.managerpark.controller;

import uef.edu.vn.managerpark.dao.UserDAO;
import uef.edu.vn.managerpark.model.User;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    private UserDAO userDAO = new UserDAO();

    @GetMapping({"/", "/login"})
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        User user = userDAO.login(username, password);

        if (user != null) {

            session.setAttribute("user", user);

            return "redirect:/dashboard";
        }

        model.addAttribute("error",
                "Sai tài khoản hoặc mật khẩu");

        return "login";
    }
}