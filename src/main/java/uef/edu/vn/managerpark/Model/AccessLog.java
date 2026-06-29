package uef.edu.vn.managerpark.model;

import java.time.LocalDateTime;

public class AccessLog {

    private int logId;
    private int vehicleId;
    private int slotId;
    private String licensePlate;
    private String vehicleType;
    private LocalDateTime checkInTime;
    private LocalDateTime checkOutTime;

    private String status;

    public AccessLog() {
    }

    public AccessLog(
            int logId,
            int vehicleId,
            int slotId,
            LocalDateTime checkInTime,
            LocalDateTime checkOutTime,
            String status) {

        this.logId = logId;
        this.vehicleId = vehicleId;
        this.slotId = slotId;
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
        this.status = status;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public LocalDateTime getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(LocalDateTime checkInTime) {
        this.checkInTime = checkInTime;
    }

    public LocalDateTime getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(LocalDateTime checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getLicensePlate() {
    return licensePlate;
}

public void setLicensePlate(String licensePlate) {
    this.licensePlate = licensePlate;
}

public String getVehicleType() {
    return vehicleType;
}

public void setVehicleType(String vehicleType) {
    this.vehicleType = vehicleType;
}
}
