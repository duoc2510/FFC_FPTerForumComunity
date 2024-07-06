<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
</head>
<body>
    <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#feedbackModal">
        Send Feedback
    </button>

    <div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="feedbackModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="feedbackModalLabel">Submit Feedback</h5>
                  
                </div>
                <form action="${pageContext.request.contextPath}/feedBack" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="feedbackTitle">Title</label>
                            <input type="text" class="form-control" id="feedbackTitle" name="feedbackTitle" required>
                        </div>
                        <div class="form-group">
                            <label for="feedbackDetail">Detail</label>
                            <textarea class="form-control" id="feedbackDetail" name="feedbackDetail" rows="4" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Submit Feedback</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#feedbackModal").prependTo("body");
        });

        document.addEventListener("DOMContentLoaded", function (event) {
            var msg = "${sessionScope.msg}";
            console.log("Message from session:", msg);

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
                <% session.removeAttribute("msg"); %>
            }
        });
    </script>
</body>
</html>
