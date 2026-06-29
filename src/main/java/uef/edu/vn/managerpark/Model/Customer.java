package uef.edu.vn.managerpark.model;

public class Customer {

    private int id;
    private String fullName;
    private String phone;
    private String plateNumber;
    private String vehicleType;
    private String packageType;
    private String status;

    public Customer() {
    }

    public Customer(int id, String fullName, String phone,
            String plateNumber, String vehicleType,
            String packageType, String status) {

        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.plateNumber = plateNumber;
        this.vehicleType = vehicleType;
        this.packageType = packageType;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getPackageType() {
        return packageType;
    }

    public void setPackageType(String packageType) {
        this.packageType = packageType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}