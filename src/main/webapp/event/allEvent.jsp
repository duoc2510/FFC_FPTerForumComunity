<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>

<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <c:if test="${USER.userRole > 1}">
            <div class="row mt-3 p-2">
                <div class="col-md-6">
                    <button id="showFormBtn" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addEventModal">Add Event</button>
                </div>
            </div>
        </c:if>

    </div>
    <h3>Event Calendar</h3>
    <div id="calendar"></div>
    <!-- Event Cards -->
    <div class="row">

        <c:if test="${not empty eventList}">
            <c:forEach var="event" items="${eventList}">
                <div class="col-sm-4">
                    <div class="card m-2">
                        <!-- Check if uploadPath exists -->
                        <c:choose>
                            <c:when test="${not empty event.uploadPath}">
                                <c:set var="uploadPath" value="${event.uploadPath}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="uploadPath" value="" />
                            </c:otherwise>
                        </c:choose>
                        <!-- Display Event Image -->
                        <img src="${pageContext.request.contextPath}/${uploadPath}" class="card-img-top event-img" alt="...">
                        <!-- Event Details -->
                        <div class="card-body">
                            <h5 class="card-title">
                                <!-- Event Title -->
                                <a href="${pageContext.request.contextPath}/viewEvent?eventId=${event.eventId}" class="event-link">
                                    ${event.title}
                                </a>
                                <!-- Three-dot menu for delete -->
                                <div class="dropdown float-end">
                                    <c:if test="${USER.userRole > 1}">
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton${event.eventId}" data-bs-toggle="dropdown" aria-expanded="false"></button>
                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton${event.eventId}">
                                                <li>
                                                    <a class="dropdown-item update-event-btn" 
                                                       onclick="editEvent('${event.eventId}', '${event.title}', '${event.description}', '${event.startDate}',
                                                                       '${event.endDate}', '${event.location}', '${event.place}', '${not empty event.uploadPath ? event.uploadPath : ''}')">
                                                        Edit
                                                    </a>
                                                </li>
                                                <li>
                                                    <a class="dropdown-item" href="#" onclick="deleteEvent('${event.eventId}')">Delete</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </h5>
                            <!-- Other Event Details -->
                            <p class="card-text">${event.description}</p>
                            <p class="card-text">Start Date: ${event.formattedStartDate}</p>
                            <p class="card-text">End Date: ${event.formattedEndDate}</p>
                            <p class="card-text">Location: ${event.location}</p>
                            <p class="card-text">Place: ${event.place}</p>
                            <p class="card-text">Created At: ${event.createdAt}"</p>

                            <!-- Check Event Status -->
                            <c:choose>
                                <c:when test="${event.endDate < now}">
                                    <p class="text-danger"><strong>This event has ended</strong></p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-success"><strong>This event is ongoing</strong></p>
                                </c:otherwise>
                            </c:choose>

                            <!-- Interest Button -->
                            <div class="interest-button">
                                <c:choose>
                                    <c:when test="${event.isInterest}">
                                        <form action="${pageContext.request.contextPath}/interested" method="post">
                                            <input type="hidden" name="eventId" value="${event.eventId}">
                                            <input type="hidden" name="action" value="cancel">
                                            <button type="submit" class="btn btn-secondary">Interested</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/interested" method="post">
                                            <input type="hidden" name="eventId" value="${event.eventId}">
                                            <input type="hidden" name="action" value="add">
                                            <button type="submit" class="btn btn-primary">Interest</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>

    <!-- Modal for editing event -->
    <div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content px-3 py-2">
                <div class="modal-header">
                    <h5 class="modal-title" id="editEventModalLabel">Edit Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editEventForm" action="${pageContext.request.contextPath}/updateEvent" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="editEvent">
                        <input type="hidden" id="editEventId" name="eventId">
                        <input type="hidden" id="existingEventUploadPath" name="existingUploadPath">

                        <div class="form-group my-2">
                            <label for="editEventTitle">Title:</label>
                            <input type="text" class="form-control" id="editEventTitle" name="title" required>
                        </div>

                        <div class="form-group my-2">
                            <label for="editEventDescription">Description:</label>
                            <textarea class="form-control" id="editEventDescription" name="description" rows="3" required></textarea>
                        </div>

                        <div class="form-group my-2">
                            <label for="editEventStartDate">Start Date:</label>
                            <input type="datetime-local" class="form-control" id="editEventStartDate" name="startDate" required>
                        </div>

                        <div class="form-group my-2">
                            <label for="editEventEndDate">End Date:</label>
                            <input type="datetime-local" class="form-control" id="editEventEndDate" name="endDate" required>
                        </div>

                        <div class="form-group my-2">
                            <label for="editEventLocation">Location:</label>
                            <select class="form-control" id="editEventLocation" name="location" required>
                                <option value="Đại học FPT Hà Nội" ${event.location == 'Đại học FPT Hà Nội' ? 'selected' : ''}>Đại học FPT Hà Nội</option>
                                <option value="Đại học FPT HCM" ${event.location == 'Đại học FPT HCM' ? 'selected' : ''}>Đại học FPT HCM</option>
                                <option value="Đại học FPT Đà Nẵng" ${event.location == 'Đại học FPT Đà Nẵng' ? 'selected' : ''}>Đại học FPT Đà Nẵng</option>
                                <option value="Đại học FPT Cần Thơ" ${event.location == 'Đại học FPT Cần Thơ' ? 'selected' : ''}>Đại học FPT Cần Thơ</option>
                            </select>
                        </div>

                        <div class="form-group my-2">
                            <label for="editEventPlace">Place:</label>
                            <input type="text" class="form-control" id="editEventPlace" name="place" required>
                        </div>

                        <div class="form-group my-2">
                            <label for="editEventUploadPath">Upload Image:</label>
                            <input type="file" class="form-control" id="editEventUploadPath" name="newUploadPath">
                        </div>

                        <div class="form-group my-2">
                            <label>Current Image:</label>
                            <img id="currentEventUploadPath" src="" alt="Current event image" style="max-width: 100%; height: auto;">
                        </div>
                    </div>
                    <div class="modal-footer my-2">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal for add new event -->
    <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content px-3 py-2">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Add new event</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="eventForm" class="row mt-3">
                        <div class="col-md-12">
                            <h2>Add Event</h2>
                            <form action="addEvent" method="POST" enctype="multipart/form-data">
                                <div class="form-group my-2">
                                    <label for="title">Title</label>
                                    <input type="text" class="form-control" id="title" name="title" required>
                                </div>
                                <div class="form-group my-2">
                                    <label for="description">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                                </div>
                                <div class="form-group my-2">
                                    <label for="startDate">Start Date</label>
                                    <input type="datetime-local" class="form-control" id="startDate" name="start_date" required>
                                </div>
                                <div class="form-group my-2">
                                    <label for="endDate">End Date</label>
                                    <input type="datetime-local" class="form-control" id="endDate" name="end_date" required>
                                </div>
                                <div class="form-group my-2">
                                    <label for="location">Location</label>
                                    <select class="form-control" id="location" name="location">
                                        <option value="Đại học FPT Hà Nội" ${event.location == 'Đại học FPT Hà Nội' ? 'selected' : ''}>Đại học FPT Hà Nội</option>
                                        <option value="Đại học FPT HCM" ${event.location == 'Đại học FPT HCM' ? 'selected' : ''}>Đại học FPT HCM</option>
                                        <option value="Đại học FPT Đà Nẵng" ${event.location == 'Đại học FPT Đà Nẵng' ? 'selected' : ''}>Đại học FPT Đà Nẵng</option>
                                        <option value="Đại học FPT Cần Thơ" ${event.location == 'Đại học FPT Cần Thơ' ? 'selected' : ''}>Đại học FPT Cần Thơ</option>
                                    </select>
                                </div>
                                <div class="form-group my-2">
                                    <label for="place">Place</label>
                                    <input type="text" class="form-control" id="place" name="place">
                                </div>
                                <div class="form-group my-2">
                                    <label for="image">Image</label>
                                    <input type="file" class="form-control-file" id="image" name="upload_path" required>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-success my-2">Submit</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>                                   
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');
        const events = [
            {
                title: 'Sự kiện 1',
                start: '2024-07-04'
            },
            {
                title: 'Sự kiện 2',
                start: '2024-07-05'
            },
    <c:forEach var="event" items="${eventList}">
            {
                title: '${event.title}',
                start: '${event.startDate}',
                url: '${pageContext.request.contextPath}/viewEvent?eventId=${event.eventId}'
                            },
    </c:forEach>
                        ];

                        const calendar = new FullCalendar.Calendar(calendarEl, {
                            initialView: 'dayGridMonth',
                            events: events,
                            eventClick: function (info) {
                                info.jsEvent.preventDefault(); // Prevents the browser from following the link
                                if (info.event.url) {
                                    window.location.href = info.event.url; // Redirects to the event detail page
                                }
                            }
                        });

                        calendar.render();
                    });
                    function formatDate(date) {
                        // Lấy ra các thành phần ngày tháng năm
                        const year = date.getFullYear();
                        let month = (1 + date.getMonth()).toString();
                        month = month.length > 1 ? month : '0' + month;
                        let day = date.getDate().toString();
                        day = day.length > 1 ? day : '0' + day;

                        // Trả về định dạng 'yyyy-MM-dd'
                        return year + '-' + month + '-' + day;
                    }
                    // Listen for click event on "Add Event" button
                    document.getElementById('showFormBtn').addEventListener('click', function () {
                        document.getElementById('eventForm').style.display = 'block';
                    });

                    document.getElementById('editEventForm').onsubmit = function () {
                        console.log('Form submitted with action:', document.getElementsByName('action')[0].value);
                    };

                    function editEvent(eventId, title, description, startDate, endDate, location, place, uploadPath) {
                        console.log("Edit Event called with:", {eventId, title, description, startDate, endDate, location, place, uploadPath});

                        document.getElementById('editEventId').value = eventId;
                        document.getElementById('editEventTitle').value = title;
                        document.getElementById('editEventDescription').value = description;
                        document.getElementById('editEventStartDate').value = startDate;
                        document.getElementById('editEventEndDate').value = endDate;
                        document.getElementById('editEventLocation').value = location;
                        document.getElementById('editEventPlace').value = place;
                        document.getElementById('existingEventUploadPath').value = uploadPath;

                        if (uploadPath && uploadPath !== 'null') {
                            document.getElementById('currentEventUploadPath').src = uploadPath;
                            document.getElementById('currentEventUploadPath').style.display = 'block';
                        } else {
                            document.getElementById('currentEventUploadPath').style.display = 'none';
                        }

                        var editEventModal = new bootstrap.Modal(document.getElementById('editEventModal'));
                        editEventModal.show();
                    }

                    function deleteEvent(eventId) {
                        if (confirm('Are you sure you want to delete this event?')) {
                            window.location.href = 'deleteEvent?eventId=' + eventId;
                        }
                    }

                    // Hide message after 3 seconds
                    setTimeout(function () {
                        document.getElementById('message').style.display = 'none';
                    }, 3000);

                    // Get current date and time
                    var now = new Date().toISOString().slice(0, 16);
</script>
</html>
