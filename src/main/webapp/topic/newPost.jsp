<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<div class="card w-100">
    <div class="card-body p-4">
        <div class="pb-3 d-flex">
            <div class="col-1 text-center d-inline">
                <img class="rounded-circle d-inline mr-3 mt-1" src="/FPTer/static/images/user.png" alt="" width="32">
            </div>
            <div class="col-3 d-inline mx-2">
                <form action="home" method="post"> <!-- Thêm action và method -->
                    <select class="form-select" name="topicId" required> <!-- Thêm name cho select -->
                        <option value="" disabled selected>Select topic</option>
                        <c:forEach var="topic" items="${topics}">
                            <option value="${topic.topicId}">${topic.topicName}</option>
                        </c:forEach>
                    </select>
                    <input type="hidden" name="action" value="addpost">
                    <c:if test="${not empty msg}">
                        <div>${msg}</div>
                        <% session.removeAttribute("msg"); %>
                    </c:if>
            </div>
            <div class="col-6 d-inline">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Hi user, how are you today?" name="content" required> <!-- Thêm name cho input -->
                </div>
            </div>
            <div class="col-2 d-inline text-center">
                <button type="submit" class="btn"> <span><i class="ti ti-bolt"></i></span>
                    <span class="hide-menu">Post</span></button>
                </form> <!-- Đóng thẻ form -->
            </div>
        </div>
    </div>
</div>
