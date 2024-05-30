<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
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
        .success-message {
            color: green;
            font-weight: bold;
            margin: 10px 0;
        }
        .error-message {
            color: red;
            font-weight: bold;
            margin: 10px 0;
        }
        .hidden {
            display: none;
        }
    </style>
    <script>
        function showAddTopicForm() {
            document.getElementById('addTopicForm').classList.remove('hidden');
        }
    </script>
</head>
<div class="card">
    <div class="card-body p-4">
        <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#qa-tab-pane" type="button" role="tab" aria-controls="qa-tab-pane" aria-selected="true">Q&A</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#market-tab-pane" type="button" role="tab" aria-controls="market-tab-pane" aria-selected="false">Market</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#document-tab-pane" type="button" role="tab" aria-controls="document-tab-pane" aria-selected="false">Document</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="all-topic-tab" data-bs-toggle="tab" data-bs-target="#topic-tab-pane" type="button" role="tab" aria-controls="topic-tab-pane" aria-selected="false">All topic</button>
            </li>
             <li class="nav-item" role="presentation">
                    <button class="nav-link" id="add-topic-tab" type="button" role="tab" onclick="showAddTopicForm()">+</button>
                </li>
        </ul>
        <div class="tab-content">
            <!-- Noi dung hoi dap -->
            <div class="tab-pane fade show active" id="qa-tab-pane" role="tabpanel" aria-labelledby="qa-tab" tabindex="0">
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
                        <tr>
                            <th scope="row">1</th>
                            <td><a href="/topic/topicID">Q&A</a></td>
                            <td><a href="/post/postID"><p>Em cần người hướng dẫn chi tiết deploy BE spring boot lên server ạ</p></a></td>
                            <td><a href="/post/userID">phuc888</a></td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td><a href="/topic/topicID">Q&A</a></td>
                            <td><a href="/post/postID"><p>em cần mua source prf192 ạ</p></a></td>
                            <td><a href="/post/userID">giangphuonganh</a></td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td><a href="/topic/topicID">Linh tinh</a></td>
                            <td><a href="/post/postID"><p>Có bán src lọc câu hỏi theo đề thi FE chứ k phải quizlet môn SWE201c, WED201c, DBI202, CSD201, PRJ301 9+ chỉ 40k, ai cần ib mình</p></a></td>
                            <td><a href="/post/userID">ngocsonn</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Noi dung mua ban -->
            <div class="tab-pane fade" id="market-tab-pane" role="tabpanel" aria-labelledby="market-tab" tabindex="0">
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
                        <tr>
                            <th scope="row">1</th>
                            <td><a href="/topic/topicID">Tìm Support</a></td>
                            <td><a href="/post/postID"><p>Em cần người hướng dẫn chi tiết deploy BE spring boot lên server ạ</p></a></td>
                            <td><a href="/post/userID">phuc888</a></td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td><a href="/topic/topicID">Cần Mua</a></td>
                            <td><a href="/post/postID"><p>em cần mua source prf192 ạ</p></a></td>
                            <td><a href="/post/userID">giangphuonganh</a></td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td><a href="/topic/topicID">Cần Bán</a></td>
                            <td><a href="/post/postID"><p>Có bán src lọc câu hỏi theo đề thi FE chứ k phải quizlet môn SWE201c, WED201c, DBI202, CSD201, PRJ301 9+ chỉ 40k, ai cần ib mình</p></a></td>
                            <td><a href="/post/userID">ngocsonn</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Noi dung tai lieu -->
            <div class="tab-pane fade" id="document-tab-pane" role="tabpanel" aria-labelledby="document-tab" tabindex="0">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Title</th>
                            <th scope="col">Author</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row">1</th>
                            <td><a href="/post/postID"><p>Tổng hợp code C prf192</p></a></td>
                            <td><a href="/post/userID">phuc888</a></td>
                        </tr>
                        <tr>
                            <th scope="row">2</th>
                            <td><a href="/post/postID"><p>University Success - READING TRANSITION LEVEL</p></a></td>
                            <td><a href="/post/userID">giangphuonganh</a></td>
                        </tr>
                        <tr>
                            <th scope="row">3</th>
                            <td><a href="/post/postID"><p>PRJ301_ThuLVM_HCM</p></a></td>
                            <td><a href="/post/userID">ngocsonn</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- All Topics -->
            <div class="tab-pane fade" id="topic-tab-pane" role="tabpanel" aria-labelledby="topic-tab" tabindex="0">
                <!-- Nội dung sẽ được tải động bằng AJAX -->
            </div>
        </div>
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
    <!-- Display Messages -->
    <c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
</div>

<script>
    document.getElementById("all-topic-tab").addEventListener("click", function () {
        fetch("${pageContext.request.contextPath}/viewTopicAdmin")
            .then(response => response.text())
            .then(data => {
                document.getElementById("topic-tab-pane").innerHTML = data;
            })
            .catch(error => console.error('Error:', error));
    });
</script>


