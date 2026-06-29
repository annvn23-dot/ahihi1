<%@ page contentType="text/html;charset=UTF-8" %>

<div class="payment-container">

    <div class="payment-card">

        <h2>💳 Thanh toán gửi xe</h2>

        <div class="info-row">
            <span>Biển số xe</span>
            <strong>${vehicle.licensePlate}</strong>
        </div>

        <div class="info-row">
            <span>Loại xe</span>
            <strong>${vehicle.vehicleType}</strong>
        </div>

        <div class="info-row">
            <span>Thời gian gửi</span>
            <strong>${hours} giờ</strong>
        </div>

        <div class="info-row total">
            <span>Tổng tiền</span>
            <strong>${amount} VNĐ</strong>
        </div>

        <form action="${pageContext.request.contextPath}/payment/pay"
              method="post">

            <input type="hidden"
                   name="vehicleId"
                   value="${vehicle.id}">

            <input type="hidden"
                   name="amount"
                   value="${amount}">

            <label>Phương thức thanh toán</label>

            <select id="paymentMethod"
                    name="paymentMethod"
                    class="form-control"
                    onchange="showQR()">

                <option value="Tiền mặt">
    Tiền mặt
</option>

<option value="Chuyển khoản">
    MoMo
</option>

<option value="QR Code">
    VNPay
</option>

            </select>

            <div id="qrArea">

                <h3>📱 Quét mã QR để thanh toán</h3>

<img
id="qrImage"
style="display:none">
<p id="debugPath"></p>
            </div>

            <button type="submit"
                    class="btn-pay">

                Xác nhận thanh toán

            </button>

        </form>

    </div>

</div>

<style>

.payment-container{
    display:flex;
    justify-content:center;
    margin-top:30px;
}

.payment-card{
    width:550px;
    background:#fff;
    border-radius:16px;
    padding:30px;
    box-shadow:0 4px 20px rgba(0,0,0,.1);
}

.payment-card h2{
    text-align:center;
    color:#1e40af;
    margin-bottom:25px;
}

.info-row{
    display:flex;
    justify-content:space-between;
    padding:12px 0;
    border-bottom:1px solid #eee;
}

.total{
    font-size:22px;
    font-weight:bold;
    color:#dc2626;
}

.form-control{
    width:100%;
    padding:12px;
    margin-top:10px;
    margin-bottom:20px;
    border:1px solid #ccc;
    border-radius:8px;
    font-size:15px;
}

#qrArea{

display:none;

width:100%;

margin-top:25px;

padding:20px;

background:#f8fafc;

border-radius:16px;

border:1px solid #e5e7eb;

display:flex;

flex-direction:column;

align-items:center;

justify-content:center;

box-sizing:border-box;

}

#qrArea h3{
    color:#1e3a8a;
    margin-bottom:10px;
}

#qrImage{

display:none;

width:280px;

height:280px;

object-fit:contain;

margin:20px auto;

padding:14px;

background:white;

border-radius:18px;

border:1px solid #dbeafe;

box-shadow:
0 10px 30px rgba(37,99,235,.15);

}

.btn-pay{
    width:100%;
    background:#2563eb;
    color:white;
    border:none;
    padding:14px;
    border-radius:10px;
    cursor:pointer;
    font-size:16px;
    font-weight:bold;
}

.btn-pay:hover{
    background:#1d4ed8;
}

</style>

<script>

function showQR(){

    let method =
        document.getElementById("paymentMethod").value;

    let qrArea =
        document.getElementById("qrArea");

    let qrImage =
        document.getElementById("qrImage");

    if(method === "Chuyển khoản"){

        qrArea.style.display = "flex";
        qrImage.style.display = "block";

        qrImage.src =
        "${pageContext.request.contextPath}/images/momo-qr.png";

    }
    else if(method === "QR Code"){

        qrArea.style.display = "flex";
        qrImage.style.display = "block";

        qrImage.src =
        "${pageContext.request.contextPath}/images/vnpay-qr.jpg";

    }
    else{

        qrArea.style.display = "none";
        qrImage.style.display = "none";
        qrImage.src = "";

    }
}

window.onload=showQR;
</script>