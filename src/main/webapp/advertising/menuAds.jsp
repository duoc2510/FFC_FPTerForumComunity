<%-- 
    Document   : menuAds
    Created on : Jun 23, 2024, 3:20:38 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="bg-white shadow rounded p-4 ">
      <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/combo" class="btn btn-outline-dark btn-sm w-100">Combo advertising</a>
    </li>
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising" class="btn btn-outline-dark btn-sm w-100">My advertising</a>
    </li>
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/boost" class="btn btn-outline-dark btn-sm w-100">Boost</a>
    </li>
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/advertising/library" class="btn btn-outline-dark btn-sm w-100">Library</a>
    </li>
</div>