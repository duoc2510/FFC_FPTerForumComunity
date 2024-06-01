<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <div class="row mt-3">
            <div class="col-md-6">
                <c:if test="${USER.userRole > 1}">
                    <button id="showFormBtn" class="btn btn-success">Add Event</button>
                </c:if>
            </div>
        </div>
        <div class="row" >
            <c:if test="${not empty eventList}">
                <c:forEach var="event" items="${eventList}">
                    <div class="card col-md-3 m-2">
                        <c:choose>
                            <c:when test="${not empty event.imagePaths}">
                                <c:set var="imagePath" value="${event.imagePaths[0]}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="imagePath" value="" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${pageContext.request.contextPath}/${imagePath}" class="card-img-top event-img" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href="viewEvent?eventId=${event.eventId}" class="event-link">
                                    ${event.title}
                                </a>
                            </h5>
                            <p class="card-text">${event.description}</p>
                            <p class="card-text">Start Date: ${event.startDate}</p>
                            <p class="card-text">End Date: ${event.endDate}</p>
                            <p class="card-text">Location: ${event.location}</p>
                            <p class="card-text">Created At: ${event.createdAt}</p>
                            <a href="#" class="btn btn-primary w-100 mt-3">Interest</a>

                            <a>
                                <c:if test="${USER.userRole > 1}">
                                    <button class="btn btn-primary w-100 mt-3 update-event-btn" data-event-id="${event.eventId}">Update Event</button>
                                </c:if>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
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
                        <input type="datetime-local" class="form-control" id="startDate" name="start_date" required>
                    </div>
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="datetime-local" class="form-control" id="endDate" name="end_date" required>
                    </div>
                    <div class="form-group">
                        <label for="location">Location</label>
                        <input type="text" class="form-control" id="location" name="location">
                    </div>
                    <div class="form-group">
                        <label for="image">Image</label>
                        <input type="file" class="form-control-file" id="image" name="upload_path" required>
                    </div>
                    <button type="submit" class="btn btn-success">Submit</button>
                </form>
            </div>
        </div>




        <div id="updateEventForm" style="display: none;">
            <h2>${event.eventId}</h2>
            <form action="updateEvent" method="POST" enctype="multipart/form-data">
                <input type="hidden" id="eventId" name="eventId" value="${event.eventId}">
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
                    <input type="datetime-local" class="form-control" id="startDate" name="start_date" required>
                </div>
                <div class="form-group">
                    <label for="endDate">End Date</label>
                    <input type="datetime-local" class="form-control" id="endDate" name="end_date" required>
                </div>
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" class="form-control" id="location" name="location">
                </div>
                <div class="form-group">
                    <label for="currentImage">Current Image</label>
                    <img id="currentImage" src="" alt="Current Event Image" style="display: block; max-width: 100px; max-height: 100px;">
                </div>
                <div class="form-group">
                    <label for="image">Image</label>
                    <input type="file" class="form-control-file" id="image" name="upload_path">
                </div>
                <button type="submit" class="btn btn-success">Submit</button>
            </form>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-info" role="alert">
                <c:out value="${message}" />
            </div>
        </c:if>
    </div>

</body>
<%@ include file="../include/footer.jsp" %>


