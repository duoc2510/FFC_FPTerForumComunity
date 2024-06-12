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
                    <button class="nav-link" id="add-topic-tab" type="button" role="tab" onclick="showAddTopicForm()">+</button>
                </li>
            </c:if>
        </ul>

        <div class="tab-content">
            <c:forEach var="topic" items="${topics}">
                <div class="tab-pane fade ${topic.topicId == topics[0].topicId ? 'show active' : ''}" id="${topic.topicId}-pane" role="tabpanel" aria-labelledby="${topic.topicId}-tab" tabindex="0">
                    <table class="table table-hover">
                        <thead>
                            <tr>            
                                <th scope="col">#</th>
                                <th scope="col">Topic</th>
                                <th scope="col">Title</th>
                                <th scope="col">Author</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="counter" value="1" />
                            <c:forEach var="post" items="${posts}">
                                <c:if test="${post.topicId == topic.topicId}">
                                    <tr>
                                        <td>${counter}</td>
                                        <td><a href="/topic/${topic.topicId}">${topic.topicName}</a></td>
                                        <td><a href="/post/${post.postId}">${post.content}</a></td>
                                        <td><a href="/user/${post.user.userId}">${post.user.username}</a></td>
                                    </tr>
                                    <c:set var="counter" value="${counter + 1}" />
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>
            <!-- All Topics -->
            <div class="tab-pane fade" id="topic-tab-pane" role="tabpanel" aria-labelledby="all-topic-tab" tabindex="0">

            </div>
            <!-- Add Topic Form -->
            <div id="addTopicForm" class="hidden">
                <h3>Add New Topic</h3>
                <form action="${pageContext.request.contextPath}/addTopic" method="post">
                    <div class="mb-3">
                        <label for="topicName" class="form-label">Topic Name</label>
                        <input type="text" class="form-control" id="topicName" name="topicName" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" name="description" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Add Topic</button>
                </form>
            </div> 
        </div>
    </div>
</div>
<script>
    document.getElementById("all-topic-tab").addEventListener("click", function () {
        fetch("${pageContext.request.contextPath}/topic/list")
                .then(response => response.text())
                .then(data => {
                    document.getElementById("topic-tab-pane").innerHTML = data;
                })
                .catch(error => console.error('Error:', error));
    });
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
