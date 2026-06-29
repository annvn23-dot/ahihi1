package uef.edu.vn.managerpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import uef.edu.vn.managerpark.dao.AccessLogDAO;

@Controller
@RequestMapping("/history")
public class historyController { // Đã sửa tên Class thành viết hoa chữ H đúng chuẩn Java

    // Sử dụng @Autowired để nạp Bean tự động, đồng bộ với toàn bộ hệ thống
    @Autowired
    private AccessLogDAO accessLogDAO;

    @GetMapping
    public String history(Model model) {

        model.addAttribute(
                "logs",
                accessLogDAO.findAll()
        );

        model.addAttribute(
                "activeTab",
                "history"
        );

        model.addAttribute(
                "viewContent",
                "history.jsp"
        );

        return "layout";
    }
}