<%-- 
    Document   : honor
    Created on : May 22, 2024, 3:55:55 PM
    Author     : mac
--%>

<%-- 
    Document   : rank.jsp
    Created on : May 22, 2024, 3:12:35 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ include file="../include/header.jsp" %>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>



        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">

                <style>
                    hr{
                        margin: 5px 0;
                    }
                    .rank-col img{
                        width: 100%;
                        max-width: 200px;
                    }
                    .rank-1 .rank-information{
                        margin-top: 20px;

                    }
                    .rank-2{
                        margin-top: 40px;
                    }
                    .rank-3{
                        margin-top: 65px;
                    }
                    .ranl-col{
                        margin-left: 20px;
                        margin-right:20px;
                    }
                    .rank-information h3{
                        color:white;
                        font-size: 13px;
                        font-weight: 600;
                    }
                    .rank-information {
                        position: relative;
                        color: white;
                        top: -37%;
                        left: 0;
                        width: 100%;
                        z-index: 99;
                    }
                    .gift{
                        margin: 5px 0 0 0;
                    }
                    .gift img{
                        width:40px;
                    }
                </style>

                <div class="col-lg-12 ">
                    <div class="card w-100">
                        <div class="card-body p-4">
                            <h2 class="text-center">Bảng xếp hạng</h2>
                            <div class="rank row mx-auto w-100">
                                <div class="rank-col col-4 rank-2">
                                    <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top2.png">
                                    <div class="rank-information">
                                        <h3 class="text-center ">${userlist.get(1).getUsername()}</h3>
                                        <hr/>
                                        <p class="text-center">Score: ${userlist.get(1).getUserScore()}</p>
                                        <div class="gift text-center">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                        </div>
                                    </div>
                                </div>
                                <div class="rank-col col-4 rank-1 ">
                                    <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top1.png">
                                    <div class="rank-information">
                                        <h3 class="text-center ">${userlist.get(0).getUsername()}</h3>
                                        <hr/>
                                        <p class="text-center">Score: ${userlist.get(0).getUserScore()}</p>
                                        <div class="gift text-center">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                        </div>
                                    </div>
                                </div>
                                <div class="rank-col col-4 rank-3">
                                    <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top3.png">
                                    <div class="rank-information">
                                        <h3 class="text-center ">${userlist.get(2).getUsername()}</h3>
                                        <hr/>
                                        <p class="text-center">Score: ${userlist.get(2).getUserScore()}</p>
                                        <div class="gift text-center">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                            <img class="d-inline" src="${pageContext.request.contextPath}/static/images/rank/hopbian.png">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="card w-100">
                        <div class="card-body p-4">
                            <div style="max-height: 400px; overflow-y: scroll;">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Hạng</th>
                                            <th scope="col" class="text-center">Tên</th>
                                            <th scope="col" class="text-center">Bậc</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="userIndex" value="${4}" />
                                        <c:forEach var="user" items="${userlist}" begin="3" end="49">
                                            <c:if test="${user.getUserRank() == 0}">
                                                <c:set var="rank" value="BRONZE" />
                                                <tr>
                                                    <th scope="row">${userIndex}</th>
                                                    <td class="text-center">${user.getUsername()}</td>
                                                    <td class="text-center">${rank}</td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${user.getUserRank() == 1}">
                                                <c:set var="rank" value="SILVER" />
                                                <tr>
                                                    <th scope="row">${userIndex}</th>
                                                    <td class="text-center">${user.getUsername()}</td>
                                                    <td class="text-center">${rank}</td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${user.getUserRank() == 2}">
                                                <c:set var="rank" value="GOLD" />
                                                <tr>
                                                    <th scope="row">${userIndex}</th>
                                                    <td class="text-center">${user.getUsername()}</td>
                                                    <td class="text-center">${rank}</td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${user.getUserRank() == 3}">
                                                <c:set var="rank" value="PLATINUM" />
                                                <tr>
                                                    <th scope="row">${userIndex}</th>
                                                    <td class="text-center">${user.getUsername()}</td>
                                                    <td class="text-center">${rank}</td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${user.getUserRank() == 4}">
                                                <c:set var="rank" value="DIAMOND" />
                                                <tr>
                                                    <th scope="row">${userIndex}</th>
                                                    <td class="text-center">${user.getUsername()}</td>
                                                    <td class="text-center">${rank}</td>
                                                </tr>
                                            </c:if>
                                            <c:set var="userIndex" value="${userIndex + 1}" />
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>

        <%@ include file="../include/right-slidebar.jsp" %>


    </div>
</body>
<%@ include file="../include/footer.jsp" %>
