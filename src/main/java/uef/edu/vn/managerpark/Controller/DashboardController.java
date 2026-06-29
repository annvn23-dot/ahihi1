package uef.edu.vn.managerpark.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import uef.edu.vn.managerpark.dao.AccessLogDAO;
import uef.edu.vn.managerpark.dao.PaymentDAO;
import uef.edu.vn.managerpark.dao.ConfigDAO; // Nhập thêm ConfigDAO
import uef.edu.vn.managerpark.model.AccessLog;
import uef.edu.vn.managerpark.model.User;

import java.util.List;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private AccessLogDAO accessLogDAO;

    @Autowired
    private PaymentDAO paymentDAO;

    @Autowired
    private ConfigDAO configDAO; // Tiêm thêm ConfigDAO để đọc cấu hình hệ thống

    @GetMapping
    public String dashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);

        // Lấy danh sách xe đang hoạt động 1 lần duy nhất để tối ưu hiệu năng
        List<AccessLog> activeLogs = accessLogDAO.findActiveLogs();

        model.addAttribute("totalVehicles", accessLogDAO.countActiveVehicles());
        model.addAttribute("recentLogs", activeLogs); 

        int motorbike = 0;
        int car = 0;

        // Vòng lặp đếm số lượng xe dựa trên danh sách xe đang trong bãi
        for (AccessLog log : activeLogs) {
            if ("Xe máy".equals(log.getVehicleType())) {
                motorbike++;
            } else if ("Ô tô".equals(log.getVehicleType()) || "O to".equals(log.getVehicleType())) {
                car++;
            }
        }

        model.addAttribute("motorbikeCount", motorbike);
        model.addAttribute("carCount", car);

        // --- TÍNH TOÁN SỐ CHỖ CÒN LẠI DỰA TRÊN CẤU HÌNH ---
        // 1. Lấy tên bãi xe và sức chứa tối đa từ cơ sở dữ liệu
        String parkingName = configDAO.getValue("parking_name");
        int maxMoto = Integer.parseInt(configDAO.getValue("max_slots_moto"));
        int maxCar = Integer.parseInt(configDAO.getValue("max_slots_car"));

        // 2. Tính toán số chỗ trống thực tế
        int availableMoto = maxMoto - motorbike;
        int availableCar = maxCar - car;

        // Giới hạn nếu số chỗ trống bị âm (do cấu hình giảm đột ngột), hạ về 0 cho đẹp giao diện
        if (availableMoto < 0) availableMoto = 0;
        if (availableCar < 0) availableCar = 0;

        // 3. Đẩy dữ liệu động ra cho dashboard.jsp nhận
        model.addAttribute("parkingName", parkingName);
        model.addAttribute("availableMoto", availableMoto);
        model.addAttribute("availableCar", availableCar);

        // --- ĐỒNG BỘ DOANH THU REALTIME ---
        model.addAttribute("todayRevenue", paymentDAO.getTodayRevenue());
        model.addAttribute("weeklyRevenue", paymentDAO.getWeeklyRevenue());
        model.addAttribute("monthlyRevenue", paymentDAO.getMonthlyRevenue());
        
        model.addAttribute("activeTab", "dashboard");
        model.addAttribute("viewContent", "dashboard.jsp");

        return "layout";
    }
}