
package uef.edu.vn.managerpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import uef.edu.vn.managerpark.dao.VehicleDAO;
import uef.edu.vn.managerpark.model.Vehicle;

@Controller
@RequestMapping("/vehicles")
public class VehicleController {

    @Autowired
    private VehicleDAO vehicleDAO;

    @GetMapping
    public String listVehicles(Model model) {

        model.addAttribute(
                "vehicles",
                vehicleDAO.findAll()
        );

        return "vehicles";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {

        model.addAttribute(
                "vehicle",
                new Vehicle()
        );

        return "vehicle-form";
    }

    @PostMapping("/save")
    public String saveVehicle(
            @ModelAttribute Vehicle vehicle) {

        vehicleDAO.insert(vehicle);

        return "redirect:/vehicles";
    }

    @GetMapping("/delete/{id}")
    public String deleteVehicle(
            @PathVariable int id) {

        vehicleDAO.delete(id);

        return "redirect:/vehicles";
    }

    @GetMapping("/edit/{id}")
    public String editVehicle(
            @PathVariable int id,
            Model model) {

        model.addAttribute(
                "vehicle",
                vehicleDAO.findById(id)
        );

        return "vehicle-form";
    }

    @PostMapping("/update")
    public String updateVehicle(
            @ModelAttribute Vehicle vehicle) {

        vehicleDAO.update(vehicle);

        return "redirect:/vehicles";
    }
}

