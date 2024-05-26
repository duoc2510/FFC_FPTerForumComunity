<%-- 
    Document   : createShop
    Created on : May 26, 2024, 4:40:12â¯PM
    Author     : mac
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="w-100 row">
    <div class="col-md-12 p-2">
        <h2>Create Your Brand To Have More Income</h2>
        <img class="w-100 rounded" src="${pageContext.request.contextPath}/static/images/bannerShop.jpg"/>
    </div>
</div>
<div class="w-100 row">
    <div class="col-md-12 p-2">

        <form method="POST">
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Shop Name</label>
                <input type="email" class="form-control" />
            </div>

            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Shop Address</label>
                <input type="email" class="form-control" />
            </div>
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Campus</label>
                <select class="form-select form-control" aria-label="ConsciousSelect" id="consciousSelect" onchange="loadDistricts()">
                    <option value="29">Ha Noi</option>
                    <option value="29">Hoa Lac</option>
                    <option value="29">Quy Nhon</option>
                    <option value="43">Da Nang</option>
                    <option value="51">TP. HCM</option>
                </select>
            </div>

            <div class="mb-3" id="districtSelectDiv" style="display:none;">
                <label class="form-label">District</label>
                <select name="district" class="form-select form-control" aria-label="DistrictSelect" id="districtSelect">
                    <!-- District options will be populated dynamically using JavaScript -->
                </select>
            </div>

            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Shop Phone</label>
                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
            </div>

            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Shop Description</label>
                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
            </div>

            <button type="submit" class="btn btn-primary float-end">Create</button>
        </form>
    </div>
</div>
