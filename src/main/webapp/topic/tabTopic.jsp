<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="card">
    <style>
        .btn-delete {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        .btn-delete:hover {
            background-color: #ff1a1a;
        }
        .hidden {
            display: none;
        }
    </style>
    <div class="card-body p-4">
        <ul class="nav nav-tabs" role="tablist">
            <c:forEach var="topic" items="${topics}">
                <li class="nav-item" role="presentation">
                    <button class="nav-link ${topic.topicId == topics[0].topicId ? 'active' : ''}" id="${topic.topicId}-tab" data-bs-toggle="tab" data-bs-target="#${topic.topicId}-pane" type="button" role="tab" aria-controls="${topic.topicId}-pane" aria-selected="${topic.topicId == topics[0].topicId ? 'true' : 'false'}">${topic.topicName}</button>
                </li>
            </c:forEach>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="all-topic-tab" data-bs-toggle="tab" data-bs-target="#topic-tab-pane" type="button" role="tab" aria-controls="topic-tab-pane" aria-selected="false">All topic</button>
            </li>
            <c:if test="${USER.userRole > 1}">
                <li class="nav-item" role="presentation">
                    <a href="#addTopicModal" data-bs-toggle="modal" class="nav-link">+</a>
                </li>
            </c:if>
        </ul>

        <div class="tab-content">
            <c:forEach var="topic" items="${topics}">
                <%@include file="postTopic.jsp"%>
            </c:forEach>
            <!-- All Topics -->
            <div class="tab-pane fade" id="topic-tab-pane" role="tabpanel" aria-labelledby="all-topic-tab" tabindex="0">
                <%@include file="topicContent.jsp"%>
            </div>
            <%@include file="modal.jsp"%>

        </div>
    </div>
</div>
<script>

    let addTopicClickCount = 0; // Biến đếm số lần bấm nút "Add Topic"

    document.getElementById("add-topic-tab").addEventListener("click", function () {
        addTopicClickCount++; // Tăng biến đếm mỗi khi bấm nút "Add Topic"

        // Kiểm tra nếu số lần bấm là số lẻ thì hiển thị form, ngược lại ẩn form
        if (addTopicClickCount % 2 !== 0) {
            showAddTopicForm();
        } else {
            hideAddTopicForm();
        }
    });

    function showAddTopicForm() {
        document.getElementById('addTopicForm').classList.remove('hidden');
    }

    function hideAddTopicForm() {
        document.getElementById('addTopicForm').classList.add('hidden');
    }
</script>
