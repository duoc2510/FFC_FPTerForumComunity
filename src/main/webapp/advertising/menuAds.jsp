<%-- 
    Document   : menuAds
    Created on : Jun 23, 2024, 3:20:38 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="bg-white shadow rounded p-4 ">

    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising" class="rounded btn btn-outline-dark btn-sm w-100 d-flex justify-content-start px-2 py-2">
            <img src="${pageContext.request.contextPath}/static/images/ad-2.svg" class="mx-2" width="20px">Advertising</a>
    </li>
    
<!--    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/combo" class="rounded btn btn-outline-dark btn-sm w-100 d-flex justify-content-start px-2 py-2">
            <img src="${pageContext.request.contextPath}/static/images/ad.svg" class="mx-2" width="20px">Quick start with combo</a>
    </li>-->

    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/campaign" class="rounded btn btn-outline-dark btn-sm w-100 d-flex justify-content-start px-2 py-2">
            <img src="${pageContext.request.contextPath}/static/images/brand-campaignmonitor.svg" class="mx-2" width="20px">My campaign</a>
    </li>

    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/boost" class="rounded btn btn-outline-dark btn-sm w-100 d-flex justify-content-start px-2 py-2">
            <img src="${pageContext.request.contextPath}/static/images/bolt.svg" class="mx-2" width="20px">Boost</a>
    </li>
    
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/library" class="rounded btn btn-outline-dark btn-sm w-100 d-flex justify-content-start px-2 py-2"> 
            <img src="${pageContext.request.contextPath}/static/images/library.svg" class="mx-2" width="20px"> Library</a>
    </li> 
<!--    
    <li class="list-inline-item w-100 mt-2">
        
        
        <a href="${pageContext.request.contextPath}/advertising/report" class="btn btn-outline-dark btn-sm w-100 d-flex justify-content-start px-2 py-2"> 
            <img src="${pageContext.request.contextPath}/static/images/file-description.svg" class="mx-2" width="20px"> Report</a>
    </li>-->
</div>