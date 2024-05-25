<%-- 
    Document   : newPost
    Created on : May 23, 2024, 10:53:18 AM
    Author     : mac
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<div class="card w-100">

    <div class="card-body p-4">
        <div class="pb-3 d-flex">
            <div class="col-1 text-center d-inline">
                <img class="rounded-circle d-inline mr-3 mt-1" src="/FPTer/static/images/user.png" alt="" width="32">
            </div>
            <div class="col-3 d-inline mx-2">
                <select class="form-select">
                    <option selected>Select topic</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                </select>
            </div>
            <div class="col-6 d-inline">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Hi user, how are you today?" >
                </div>
            </div>
            <div class="col-2 d-inline text-center">
                <button type="button" class="btn"> <span><i class="ti ti-bolt"></i></span>
                    <span class="hide-menu">Post</span></button>
            </div>

        </div>
    </div>
</div>