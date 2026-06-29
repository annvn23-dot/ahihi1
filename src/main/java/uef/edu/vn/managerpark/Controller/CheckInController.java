package uef.edu.vn.managerpark.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import uef.edu.vn.managerpark.dao.AccessLogDAO;
import uef.edu.vn.managerpark.dao.ParkingSlotDAO;
import uef.edu.vn.managerpark.dao.VehicleDAO;
import uef.edu.vn.managerpark.model.ParkingSlot;
import uef.edu.vn.managerpark.model.Vehicle;

@Controller
@RequestMapping("/checkin")
public class CheckInController {

    private final VehicleDAO vehicleDAO =
            new VehicleDAO();

    private final AccessLogDAO accessLogDAO =
            new AccessLogDAO();

    private final ParkingSlotDAO parkingSlotDAO =
            new ParkingSlotDAO();

    @GetMapping
public String showPage(Model model) {

    model.addAttribute(
            "logs",
            accessLogDAO.findActiveLogs()
    );

    model.addAttribute(
            "activeTab",
            "checkin"
    );

    model.addAttribute(
            "viewContent",
            "checkin.jsp"
    );

    return "layout";
}

    @PostMapping("/save")
    public String saveVehicle(
            @RequestParam String licensePlate,
            @RequestParam String vehicleType,
            @RequestParam(required = false) String ownerName,
            @RequestParam(required = false) String ownerPhone) {

        // Tạo xe
        Vehicle vehicle =
                new Vehicle();

        vehicle.setLicensePlate(
                licensePlate);

        vehicle.setVehicleType(
                vehicleType);

        vehicle.setOwnerName(
                ownerName);

        vehicle.setOwnerPhone(
                ownerPhone);

        vehicleDAO.insert(vehicle);

        // Lấy xe vừa thêm
        Vehicle savedVehicle =
                vehicleDAO.findByLicensePlate(
                        licensePlate);

        // Tìm chỗ trống
        ParkingSlot slot =
                parkingSlotDAO.findAvailableSlot(
                        vehicleType);

        if (slot != null) {

            // Đánh dấu đã sử dụng
            parkingSlotDAO.occupySlot(
                    slot.getSlotId());

            // Tạo log gửi xe
            accessLogDAO.checkIn(
                    savedVehicle.getId(),
                    slot.getSlotId());
        }

        return "redirect:/checkin";
    }

    @GetMapping("/delete/{id}")
    public String deleteVehicle(
            @PathVariable int id) {

        vehicleDAO.delete(id);

        return "redirect:/checkin";
    }
}