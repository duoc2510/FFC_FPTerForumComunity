<%-- 
    Document   : showAds
    Created on : May 15, 2024, 4:26:01â¯PM
    Author     : mac
show this in right index
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký làm Manager</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <style>


        </style>
    </head>
    <body>

        <div class="showAds card">
            <img src="/FPTer/upload/Registr.png" class="card-img-top event-img" alt="...">
            <div class="card-body">
                <h5 class="card-title text-center my-3"><strong>Đã có form đăng kí làm manager</strong></h5>
                <p class="card-text"><strong>Đăng ký để có nhiều quyền lợi hơn nhé: </strong> Nhấn vào nút phía dưới</p>
                <c:choose>
                    <c:when test="${hasRegister}">
                        <button type="button" class="btn btn-secondary" disabled>
                            Đã đăng ký
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registrManagerModal">
                            Đăng ký ngay
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="modal fade" id="registrManagerModal" tabindex="-1" aria-labelledby="registrManagerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registrManagerModalLabel">Đăng ký làm Manager</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="registrManagerForm" action="${pageContext.request.contextPath}/registerManager" method="post">
                            <div class="mb-3">
                                <label for="contributions" class="form-label">Những đóng góp của bạn cho trang web</label>
                                <textarea class="form-control" id="contributions" name="contributions" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="terms" class="form-label">Điều lệ đăng ký làm Manager</label>
                                <textarea class="form-control" id="terms" rows="5" readonly>
1. Chấp hành đúng các quy định của trang web.
2. Hỗ trợ người dùng khi gặp khó khăn.
3. Duyệt và quản lý nội dung bài viết theo đúng quy định.
4. Đảm bảo tính công bằng và minh bạch trong mọi hoạt động.
                                </textarea>
                            </div>
                            <div class="form-check">
                                <input type="hidden" name="userId" value="${USER.userId}">
                                <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">Tôi đồng ý với các điều lệ và cam kết thực hiện đúng</label>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" form="registrManagerForm" class="btn btn-primary">Đăng ký</button>


                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("#registrManagerModal").prependTo("body");
            });
            document.addEventListener("DOMContentLoaded", function (event) {
                // Ensure your DOM is fully loaded before executing any code
                var msg = "${sessionScope.msg}";
                console.log("Message from session:", msg);

                // Kiểm tra nếu msg không rỗng, hiển thị thông báo
                if (msg !== null && msg !== "") {
                    swal({
                        title: msg.includes("successfully") ? "Success" :
                                msg.includes("đăng ký rồi") ? "Warning" :
                                "Error",
                        text: msg,
                        icon: msg.includes("successfully") ? "success" :
                                msg.includes("đăng ký rồi") ? "warning" :
                                "error",
                        button: "OK!"
                    });
                    // Xóa msg sau khi hiển thị để tránh hiển thị lại khi tải lại trang
            <% session.removeAttribute("msg"); %>
                }
            });

        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    </body>
</html>
