package uef.edu.vn.managerpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uef.edu.vn.managerpark.dao.ConfigDAO;

@Controller
@RequestMapping("/admin/config")
public class ConfigController {

    @Autowired
    private ConfigDAO configDAO;

    @GetMapping
    public String showConfigPage(Model model) {
        model.addAttribute("surchargeMotoNight", configDAO.getValue("surcharge_moto_night"));
model.addAttribute("surchargeCarNight", configDAO.getValue("surcharge_car_night"));
        model.addAttribute("maxMoto", configDAO.getValue("max_slots_moto"));
        model.addAttribute("maxCar", configDAO.getValue("max_slots_car"));
        model.addAttribute("priceMoto", configDAO.getValue("price_moto"));
        model.addAttribute("priceCar", configDAO.getValue("price_car"));
        model.addAttribute("parkingName", configDAO.getValue("parking_name"));
        model.addAttribute("viewContent", "config.jsp"); 
        return "layout"; 
    }

    // Xử lý khi Admin nhấn nút lưu cấu hình
    @PostMapping("/save")
public String saveConfig(
        @RequestParam("maxMoto") String maxMoto,
        @RequestParam("maxCar") String maxCar,
        @RequestParam("priceMoto") String priceMoto,
        @RequestParam("surchargeMotoNight") String surchargeMotoNight, // Nhận thêm
        @RequestParam("priceCar") String priceCar,
        @RequestParam("surchargeCarNight") String surchargeCarNight,   // Nhận thêm
        @RequestParam("parkingName") String parkingName) {

    configDAO.updateValue("max_slots_moto", maxMoto);
    configDAO.updateValue("max_slots_car", maxCar);
    configDAO.updateValue("price_moto", priceMoto);
    configDAO.updateValue("surcharge_moto_night", surchargeMotoNight); // Lưu vào DB
    configDAO.updateValue("price_car", priceCar);
    configDAO.updateValue("surcharge_car_night", surchargeCarNight);   // Lưu vào DB
    configDAO.updateValue("parking_name", parkingName);

    return "redirect:/admin/config?success=true";
}
}