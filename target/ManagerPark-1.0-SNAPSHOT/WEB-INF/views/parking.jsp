<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="page">

<div class="header">

<div>

<h1>🚗 Quản Lý Xe</h1>

<p>Quản lý gửi xe và vị trí đỗ</p>

</div>

</div>


<div class="stats">

<div class="card">
<h3>Tổng xe</h3>
<h1>${vehicles.size()}</h1>
</div>

<div class="card">
<h3>Xe máy</h3>
<h1>48</h1>
</div>

<div class="card">
<h3>Ô tô</h3>
<h1>18</h1>
</div>

</div>


<div class="card">

<form
action="parking/add"
method="post">

<div class="row">

<input
name="plate"
placeholder="Nhập biển số"
required>

<select
name="slot">

<option value="A01">
A01
</option>

<option value="A02">
A02
</option>

<option value="B01">
B01
</option>

<option value="B02">
B02
</option>

<option value="C01">
C01
</option>

</select>

</div>


<div class="type">

<label>

<input
type="radio"
name="type"
value="Xe máy"
checked>

<span>

🏍 Xe máy

</span>

</label>


<label>

<input
type="radio"
name="type"
value="Ô tô">

<span>

🚘 Ô tô

</span>

</label>

</div>


<button
class="send">

+ Gửi Xe

</button>

</form>

</div>



<div class="card">

<form>

<input
name="keyword"

placeholder="🔍 Tìm biển số">

<button>

Tìm

</button>

</form>

</div>


<div class="card">

<table>

<tr>

<th>Biển số</th>

<th>Loại</th>

<th>Vị trí</th>

<th>Trạng thái</th>

<th></th>

</tr>


<c:forEach
items="${vehicles}"
var="v"
varStatus="i">

<tr>

<td>

${v[0]}

</td>

<td>

${v[1]}

</td>

<td>

${v[2]}

</td>

<td>

<span class="ok">

Đang gửi

</span>

</td>

<td>

<a
class="checkout"

href="parking/checkout?id=${i.index}">

Trả xe

</a>

</td>

</tr>

</c:forEach>

</table>

</div>

</div>



<style>

.page{

padding:40px;

background:#f5f7fb;

min-height:100vh;

}

.header{

margin-bottom:30px;

}

.header h1{

font-size:38px;

}

.stats{

display:grid;

grid-template-columns:
repeat(3,1fr);

gap:20px;

margin-bottom:30px;

}

.card{

background:white;

padding:25px;

border-radius:20px;

box-shadow:
0 2px 10px rgba(0,0,0,.05);

margin-bottom:20px;

}

.row{

display:flex;

gap:20px;

}

input,select{

padding:14px;

border:1px solid #ddd;

border-radius:12px;

width:260px;

}

.type{

display:flex;

gap:20px;

margin-top:20px;

}

.type input{

display:none;

}

.type span{

padding:14px 24px;

border-radius:12px;

background:#eef2ff;

cursor:pointer;

display:inline-block;

}

.type input:checked+span{

background:#2847d5;

color:white;

}

.send{

margin-top:25px;

background:#2847d5;

color:white;

padding:14px 24px;

border:none;

border-radius:12px;

cursor:pointer;

}

table{

width:100%;

border-collapse:collapse;

}

th{

text-align:left;

padding:18px;

background:#f6f8fc;

}

td{

padding:18px;

}

.ok{

background:#dcfce7;

color:#166534;

padding:8px 14px;

border-radius:20px;

}

.checkout{

background:#ef4444;

color:white;

padding:10px 18px;

border-radius:10px;

text-decoration:none;

}

</style>