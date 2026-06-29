package uef.edu.vn.managerpark.model; // Viết hoa chữ M để đồng bộ với các Controller khác

public class Dashboard {

    // 1. Khai báo các thuộc tính (Properties) lên đầu file
    private int totalSlots;
    private int availableSlots;
    private int occupiedSlots;
    private int totalCustomers;
    private int monthlyTickets;
    private double todayRevenue;

    // 2. Hàm tạo mặc định không tham số (No-args Constructor)
    public Dashboard() {
    }

    // 3. Hàm tạo đầy đủ tham số (All-args Constructor)
    public Dashboard(int totalSlots, int availableSlots, int occupiedSlots, 
                     int totalCustomers, int monthlyTickets, double todayRevenue) {
        this.totalSlots = totalSlots;
        this.availableSlots = availableSlots;
        this.occupiedSlots = occupiedSlots;
        this.totalCustomers = totalCustomers;
        this.monthlyTickets = monthlyTickets;
        this.todayRevenue = todayRevenue;
    }

    // 4. Toàn bộ các hàm Getter và Setter
    public int getTotalSlots() {
        return totalSlots;
    }

    public void setTotalSlots(int totalSlots) {
        this.totalSlots = totalSlots;
    }

    public int getAvailableSlots() {
        return availableSlots;
    }

    public void setAvailableSlots(int availableSlots) {
        this.availableSlots = availableSlots;
    }

    public int getOccupiedSlots() {
        return occupiedSlots;
    }

    public void setOccupiedSlots(int occupiedSlots) {
        this.occupiedSlots = occupiedSlots;
    }

    public int getTotalCustomers() {
        return totalCustomers;
    }

    public void setTotalCustomers(int totalCustomers) {
        this.totalCustomers = totalCustomers;
    }

    public int getMonthlyTickets() {
        return monthlyTickets;
    }

    public void setMonthlyTickets(int monthlyTickets) {
        this.monthlyTickets = monthlyTickets;
    }

    public double getTodayRevenue() {
        return todayRevenue;
    }

    public void setTodayRevenue(double todayRevenue) {
        this.todayRevenue = todayRevenue;
    }
}