<%-- 
    Document   : menuWallet
    Created on : Jun 23, 2024, 12:08:04 PM
    Author     : mac
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="bg-white shadow rounded p-4 ">
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/wallet" class="btn btn-outline-dark btn-sm w-100">My Wallet</a>
    </li>
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/wallet/deposit" class="btn btn-outline-dark btn-sm w-100">Deposit</a>
    </li>
    <li class="list-inline-item w-100 mt-2">
        <a href="${pageContext.request.contextPath}/wallet/withdraw" class="btn btn-outline-dark btn-sm w-100">Withdraw</a>
    </li>
</div>