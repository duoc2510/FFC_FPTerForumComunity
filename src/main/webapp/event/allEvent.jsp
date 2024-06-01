<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <div class="row" >
            <c:forEach var="event" items="${events}">
                <div class="card col-md-3 m-2">
                    <img src="${pageContext.request.contextPath}/${event.image}" class="card-img-top event-img"
                         alt="...">
                    <div class="card-body">
                        <h5 class="card-title">
                            <a href="viewEvent?eventId=${event.eventId}" class="event-link">
                                ${event.title}
                            </a>
                        </h5>
                        <p class="card-text">${event.description}</p>
                        <p class="card-text">Start Date: ${event.startDate}</p>
                        <p class="card-text">End Date: ${event.endDate}</p>
                        <c:if test="${not empty event.imagePaths}">
                            <p class="card-text">Images:</p>
                            <ul>
                                <c:forEach var="imagePath" items="${event.imagePaths}">
                                    <li>${imagePath}</li>
                                    </c:forEach>
                            </ul>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
            <div class="card col-md-3 m-2">
                <img src="${pageContext.request.contextPath}/upload/tien-do-quy-4-4.png" class="card-img-top event-img" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Event 1 </h5>
                    <p class="card-text">Start: DD/MM/YY </p>
                    <p class="card-text">End: DD/MM/YY </p>
                    <p class="card-text">Organize: FPT Smoker </p>


                    <a href="#" class="btn btn-primary w-100 mt-3">Interest</a>
                </div>
            </div>

            <div class="card col-md-3 m-2">
                <img src="${pageContext.request.contextPath}/upload/ss1.png" class="card-img-top event-img" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Event 2</h5>
                    <p class="card-text">Start: DD/MM/YY </p>
                    <p class="card-text">End: DD/MM/YY </p>
                    <p class="card-text">Organize: FPT Smoker </p>


                    <a href="#" class="btn btn-primary w-100 mt-3">Interest</a>
                </div>
            </div>

            <div class="card col-md-3 m-2">
                <img src="${pageContext.request.contextPath}/upload/deli-2.png" class="card-img-top event-img" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Event 3</h5>
                    <p class="card-text">Start: DD/MM/YY </p>
                    <p class="card-text">End: DD/MM/YY </p>
                    <p class="card-text">Organize: FPT Smoker </p>



                    <a href="#" class="btn btn-primary w-100 mt-3">Interest</a>
                </div>
            </div>

            <div class="card col-md-3 m-2">
                <img src="${pageContext.request.contextPath}/upload/z5402380303123_ac37a5c776c26769d9e5f7bdd9f19426.jpg" class="card-img-top event-img" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Event 3 test xuong dong</h5>
                    <p class="card-text">Start: DD/MM/YY </p>
                    <p class="card-text">End: DD/MM/YY </p>

                    <a href="#" class="btn btn-primary w-100 mt-3">Interest</a>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-6">
                <button id="showFormBtn" class="btn btn-success">Add Event</button>
            </div>
            <div class="col-md-6">
                <a href="updateEvent" class="btn btn-primary">Update Event</a>
            </div>
        </div>

        <div id="eventForm" class="row mt-3" style="display: none;">
            <div class="col-md-12">
                <h2>Add Event</h2>
                <form action="addEvent" method="POST" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                    <label for="startDate">Start Date</label>
                    <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                </div>
                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                </div>
                    <div class="form-group">
                        <label for="image">Image</label>
                        <input type="file" class="form-control-file" id="image" name="image" required>
                    </div>
                    <button type="submit" class="btn btn-success">Submit</button>
                </form>
            </div>
        </div>

        <script>
            document.getElementById('showFormBtn').addEventListener('click', function () {
                document.getElementById('eventForm').style.display = 'block';
            });
        </script>


        <c:if test="${not empty message}">
            <div class="alert alert-info" role="alert">
                <c:out value="${message}" />
            </div>
        </c:if>
    </div>
</div>
</div>
</body>
<%@ include file="../include/footer.jsp" %>


