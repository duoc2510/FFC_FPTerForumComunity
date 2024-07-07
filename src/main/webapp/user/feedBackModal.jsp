<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<button type="button" class="btn btn-dark rounded" data-bs-toggle="modal" data-bs-target="#feedbackModal">
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
                    <button type="button" class="btn btn-secondary rounded" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary rounded">Send</button>
                </div>
            </form>
        </div>
    </div>
</div>


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
