<%-- 
    Document   : checkProgress
    Created on : May 26, 2024, 8:01:19 PM
    Author     : mac

    Chekc tình trạng giao hàng Đang chờ shipper | Đang giao | Đã giao 
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="w-100 row">
    <div class="col-md-12 p-2">
        <h2>Check Delivery Status</h2>
    </div>
</div>
<div class="w-100 row">
    <div class="col-md-12 p-2">
        <form method="POST">
            <div class="mb-3 inline d-flex">
                <div class="card w-100 p-4">
                    <div class="spinner-border mx-2 d-inline" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>       
                    <h4 class="mt-3">Đang chờ shipper</h4>

                    <div class="w-25 float-end">
                        <a href="javascript:history.back()" class="btn btn-primary ">Back</a>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


