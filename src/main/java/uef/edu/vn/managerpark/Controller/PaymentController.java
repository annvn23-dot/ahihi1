package uef.edu.vn.managerpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import uef.edu.vn.managerpark.dao.AccessLogDAO;
import uef.edu.vn.managerpark.dao.PaymentDAO;
import uef.edu.vn.managerpark.dao.ParkingSlotDAO;
import uef.edu.vn.managerpark.dao.VehicleDAO;
import uef.edu.vn.managerpark.model.AccessLog;
import uef.edu.vn.managerpark.model.Vehicle;

import java.time.Duration;
import java.time.LocalDateTime;
import uef.edu.vn.managerpark.dao.ConfigDAO;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private ConfigDAO configDAO;
    @Autowired
    private VehicleDAO vehicleDAO;

    @Autowired
    private AccessLogDAO accessLogDAO;

    @Autowired
    private PaymentDAO paymentDAO;

    @Autowired
    private ParkingSlotDAO parkingSlotDAO;

    @GetMapping("/{vehicleId}")
    public String paymentPage(@PathVariable int vehicleId, Model model) {

        Vehicle vehicle = vehicleDAO.findById(vehicleId);
        AccessLog log = accessLogDAO.findActiveLogByVehicle(vehicleId);

        if (vehicle == null || log == null) {
            return "redirect:/payment";
        }

        // Tính toán số phút xe đã đỗ trong bãi
        long minutes = Duration.between(log.getCheckInTime(), LocalDateTime.now()).toMinutes();

        // Làm tròn lên theo tiếng
        long hours = (long) Math.ceil(minutes / 60.0);

        if (hours <= 0) {
            hours = 1;
        }
        
        // 1. Lấy giá vé lượt cơ bản và phụ phí đêm động từ cấu hình hệ thống
        double basePrice = 0;
        double nightSurcharge = 0;

        if ("Xe máy".equals(vehicle.getVehicleType())) {
            basePrice = Integer.parseInt(configDAO.getValue("price_moto"));
            nightSurcharge = Integer.parseInt(configDAO.getValue("surcharge_moto_night"));
        } else {
            basePrice = Integer.parseInt(configDAO.getValue("price_car"));
            nightSurcharge = Integer.parseInt(configDAO.getValue("surcharge_car_night"));
        }

        // 2. LOGIC TÍNH THEO CHU KỲ QUA MỐC 12H ĐÊM (00:00)
        java.time.LocalDate startDate = log.getCheckInTime().toLocalDate();
        java.time.LocalDate endDate = java.time.LocalDateTime.now().toLocalDate();

        // Số ngày chênh lệch giữa ngày vào và ngày ra (số lần bước qua mốc 12h đêm)
        long daysPassed = java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate);

        long totalTurns = 1;       // Mặc định cứ vào bãi là mất 1 lượt ban đầu
        long totalNightSur = 0;    // Số lần bị tính phụ phí đêm

        if (daysPassed > 0) {
            // Cứ qua mỗi mốc 12h đêm thì tính thêm 1 lượt mới và 1 lần phụ phí đêm
            totalTurns += daysPassed;
            totalNightSur += daysPassed;
        }

        // 3. Tính tổng số tiền cuối cùng theo lũy tiến
        double amount = (totalTurns * basePrice) + (totalNightSur * nightSurcharge);

        // Tính số tiếng thực tế đỗ trong bãi chỉ để hiển thị báo cáo trên giao diện
        long totalMinutes = Duration.between(log.getCheckInTime(), java.time.LocalDateTime.now()).toMinutes();
        hours = (long) Math.ceil(totalMinutes / 60.0);

        // 4. Đẩy thông tin chi tiết ra file JSP để hiển thị hóa đơn minh bạch
        model.addAttribute("vehicle", vehicle);
        model.addAttribute("log", log);
        model.addAttribute("hours", hours <= 0 ? 1 : hours);
        model.addAttribute("amount", amount);
        
        // Gửi thêm các biến phân rã này nếu bạn muốn hiển thị chi tiết "X lượt", "Y lần qua đêm" ở giao diện
        model.addAttribute("totalTurns", totalTurns);
        model.addAttribute("totalNightSur", totalNightSur);
        model.addAttribute("basePrice", basePrice);
        model.addAttribute("nightSurcharge", nightSurcharge);

        model.addAttribute("vehicle", vehicle);
        model.addAttribute("log", log);
        model.addAttribute("hours", hours);
        model.addAttribute("amount", amount);

        model.addAttribute("activeTab", "payment");
        model.addAttribute("viewContent", "payment.jsp");

        return "layout";
    }

    @PostMapping("/pay")
    public String pay(
            @RequestParam int vehicleId,
            @RequestParam double amount,
            @RequestParam String paymentMethod) {

        System.out.println("===== XỬ LÝ THANH TOÁN =====");
        AccessLog log = accessLogDAO.findActiveLogByVehicle(vehicleId);

        if (log == null) {
            return "redirect:/dashboard";
        }

        // Gọi đúng hàm từ lớp DAO để lưu vào DB
        paymentDAO.savePayment(vehicleId, amount, paymentMethod);

        // Cập nhật các trạng thái phụ trợ
        accessLogDAO.checkout(vehicleId);
        vehicleDAO.checkoutVehicle(vehicleId);
        parkingSlotDAO.releaseSlot(log.getSlotId());

        return "redirect:/dashboard";
    }

    @GetMapping
    public String paymentHome(Model model) {
        model.addAttribute("logs", accessLogDAO.findActiveLogs());
        model.addAttribute("activeTab", "payment");
        model.addAttribute("viewContent", "payment-list.jsp");

        return "layout";
    }
}
