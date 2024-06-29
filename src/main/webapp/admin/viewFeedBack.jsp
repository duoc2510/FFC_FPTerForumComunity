<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.USER}">
            <%@ include file="../index_guest.jsp" %>
        </c:when>
        <c:otherwise>
            <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
                 data-sidebar-position="fixed" data-header-position="fixed">
                <%@ include file="../include/slidebar.jsp" %>
                <div class="body-wrapper">
                    <%@ include file="../include/navbar.jsp" %>
                    <div class="container-fluid d-flex">
                        <div class="col-lg-12 w-100">
                            <div id="report-sections">
                                <div id="reported-posts-section">
                                    <h2>List all feedback of users</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                               <th>Stt</th>
                                                <th>Feedback title</th>
                                                <th>Feedback detail</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty feedbackList}">
                                                <tr>
                                                    <td colspan="4">
                                                        <p>There aren't any feedback.</p>
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach var="feedback" items="${feedbackList}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${feedback.feedbackTitle}</td>
                                                    <td>${feedback.feedbackDetail}</td>
                                                    <td>                                  
                                                        <form id="deleteFeedbackForm_${feedback.feedbackId}" action="${pageContext.request.contextPath}/admin/viewFeedBack" method="post">
                                                            <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
                                                            <input type="hidden" name="action" value="delete">
                                                            <button type="button" class="btn btn-danger" onclick="confirmDelete('deleteFeedbackForm_${feedback.feedbackId}')">Delete</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <%@ include file="../include/footer.jsp" %>

    <script>
        document.addEventListener("DOMContentLoaded", function (event) {
            var msg = "${sessionScope.msg}";
            console.log("Message from session:", msg);
            if (msg !== null && msg !== "") {
                swal({
                    title: msg.includes("successfully") ? "Success" : "Error",
                    text: msg,
                    icon: msg.includes("successfully") ? "success" : "error",
                    button: "OK!"
                });
                <% session.removeAttribute("msg"); %>
            }
        });

        function confirmDelete(formId) {
            if (confirm("Bạn có chắc chắn muốn thực hiện hành động này?")) {
                document.getElementById(formId).submit();
            }
        }
    </script>
</body>