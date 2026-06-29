package uef.edu.vn.managerpark.model;

import java.time.LocalDateTime;

public class Payment {

    public static final String CASH = "CASH";
    public static final String MOMO = "MOMO";
    public static final String VNPAY = "VNPAY";

    public static final String PENDING = "PENDING";
    public static final String PAID = "PAID";

    private int paymentId;

    // Gắn với lượt gửi xe
    private AccessLog accessLog;

    // Số tiền thanh toán
    private double amount;

    // Thời gian thanh toán
    private LocalDateTime paymentTime;

    // CASH, MOMO, VNPAY
    private String paymentMethod;

    // PENDING hoặc PAID
    private String paymentStatus;

    public Payment() {
    }

    public Payment(int paymentId,
                   AccessLog accessLog,
                   double amount,
                   LocalDateTime paymentTime,
                   String paymentMethod,
                   String paymentStatus) {

        this.paymentId = paymentId;
        this.accessLog = accessLog;
        this.amount = amount;
        this.paymentTime = paymentTime;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public AccessLog getAccessLog() {
        return accessLog;
    }

    public void setAccessLog(AccessLog accessLog) {
        this.accessLog = accessLog;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public LocalDateTime getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(LocalDateTime paymentTime) {
        this.paymentTime = paymentTime;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", accessLog=" + accessLog +
                ", amount=" + amount +
                ", paymentTime=" + paymentTime +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                '}';
    }
}