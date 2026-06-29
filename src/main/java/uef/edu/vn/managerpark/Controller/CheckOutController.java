package uef.edu.vn.managerpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import uef.edu.vn.managerpark.dao.AccessLogDAO;
import uef.edu.vn.managerpark.dao.ConfigDAO;
import uef.edu.vn.managerpark.model.AccessLog;

import java.util.List;

@Controller
@RequestMapping("/checkout")
public class CheckOutController {

    // SỬA: Sử dụng @Autowired để Spring tự động quản lý Bean, không dùng 'new'
    @Autowired
    private AccessLogDAO accessLogDAO;

    @Autowired
    private ConfigDAO configDAO; // Đã kết nối thành công ConfigDAO để đọc cấu hình slots

    @GetMapping
    public String showPage(Model model) {

        // 1. Lấy danh sách xe đang hoạt động trong bãi
        List<AccessLog> logs = accessLogDAO.findActiveLogs();
        model.addAttribute("logs", logs);

        // 2. Thuật toán đếm số lượng xe thực tế đang có trong bãi
        int motorbikeCount = 0;
        int carCount = 0;
        for (AccessLog log : logs) {
            if ("Xe máy".equals(log.getVehicleType())) {
                motorbikeCount++;
            } else if ("Ô tô".equals(log.getVehicleType()) || "O to".equals(log.getVehicleType())) {
                carCount++;
            }
        }

        // 3. Đọc dữ liệu sức chứa tối đa từ Cấu hình Database
        int maxMoto = Integer.parseInt(configDAO.getValue("max_slots_moto"));
        int maxCar = Integer.parseInt(configDAO.getValue("max_slots_car"));

        // 4. Tính toán số chỗ trống thực tế còn lại
        int availableMoto = maxMoto - motorbikeCount;
        int availableCar = maxCar - carCount;

        // Ràng buộc bảo vệ: nếu số chỗ âm thì đưa về 0 để tránh lỗi giao diện
        if (availableMoto < 0) availableMoto = 0;
        if (availableCar < 0) availableCar = 0;

        // 5. ĐỒNG BỘ: Đẩy dữ liệu chỗ trống sang file checkout.jsp
        model.addAttribute("availableMoto", availableMoto);
        model.addAttribute("availableCar", availableCar);

        // Các cấu hình giao diện chung
        model.addAttribute("activeTab", "checkout");
        model.addAttribute("viewContent", "checkout.jsp");

        return "layout";
    }

    @GetMapping("/confirm/{vehicleId}")
    public String checkout(@PathVariable int vehicleId) {
        return "redirect:/payment/" + vehicleId;
    }
}