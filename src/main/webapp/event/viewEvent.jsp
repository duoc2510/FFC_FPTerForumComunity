<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Date" %>
<%@ include file="../include/header.jsp" %>
<!-- Include Bootstrap CSS and JS -->
<!--<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>-->

<body>
    <style>
        /* CSS style for the page */
        .event-image img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            overflow: hidden;
        }

        .event-header {
            background: #ececec;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            position: relative;
        }


        iframe{
            border:1px solid white;
            border-radius: 1.5em;
        }

        .num-interested-users {
            font-size: 18px;
            margin-bottom: 5px;
        }

        .interest-button {
            margin-left: auto;
        }

        .interest-button button {
            padding: 8px 16px;
            font-size: 14px;
        }

        .description-box {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .event-info p {
            margin-bottom: 10px;
        }
    </style>

    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <%@ include file="../include/slidebar.jsp" %>
        <div class="body-wrapper">
            <%@ include file="../include/navbar.jsp" %>
            <div class="container-fluid">
                <div class=" justify-content-center">
                    <div class="container rounded shadow">
                        <div class="row">
                            <div class="event-image">
                                <img class="rounded-top" src="${pageContext.request.contextPath}/${event.uploadPath}" alt="Event Image">
                            </div>
                            <div class="event-header p-3">
                                <h2 class="event-title m-0">${event.title}</h2>
                                <div class="member-info" data-toggle="modal" data-target="#interestedMembersModal">
                                    <div class="px-4">People going to join: <span class="num-interested-users">${numInterestedUsers}</span></div>

                                </div>
                                <div class="interest-button">
                                    <c:choose>
                                        <c:when test="${event.isInterest}">
                                            <form action="${pageContext.request.contextPath}/interested" method="post">
                                                <input type="hidden" name="eventId" value="${event.eventId}">
                                                <input type="hidden" name="action" value="cancel">
                                                <button type="submit" class="btn rounded btn-danger">Not Interest</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/interested" method="post">
                                                <input type="hidden" name="eventId" value="${event.eventId}">
                                                <input type="hidden" name="action" value="add">
                                                <button type="submit" class="btn rounded btn-primary">Interest</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12 col-md-6 pt-2 px-4">
                                <!-- Set the current time -->
                                <c:set var="now" value="<%= new java.util.Date() %>" />

                                <!-- Check Event Status -->
                                <c:choose>
                                    <c:when test="${event.endDate.time <= now.time}">
                                        <p class="text-danger"><strong>Ended</strong></p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-success"><strong>On Going</strong></p>
                                    </c:otherwise>
                                </c:choose>


                                <div class="event-info">
                                    <h4 class="mt-2">Details:</h4>
                                    <p>${event.description}</p>
                                    <hr>
                                    <p><strong>Start Date:</strong> ${event.startDate}</p>
                                    <p><strong>End Date:</strong> ${event.endDate}</p>
                                    <p><strong>Location:</strong> ${event.location}</p>
                                    <p><strong>Place:</strong> ${event.place}</p>
                                    <p><strong>Created At:</strong> ${event.createdAt}</p>
                                </div>
                            </div>


                            <!-- Google Maps iframe based on location -->
                            <div class="col-12 col-md-6 py-2 px-3">
                                <c:choose>
                                    <c:when test="${event.location == 'Đại học FPT Hà Nội'}">
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5063419425255!2d105.52271427508036!3d21.012416680632775!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1718765381994!5m2!1svi!2s" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </c:when>
                                        <c:when test="${event.location == 'Đại học FPT HCM'}">
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15674.440041588125!2d106.809883!3d10.8411276!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752731176b07b1%3A0xb752b24b379bae5e!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgVFAuIEhDTQ!5e0!3m2!1svi!2s!4v1718765231862!5m2!1svi!2s" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </c:when>
                                        <c:when test="${event.location == 'Đại học FPT Đà Nẵng'}">
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15343.424671312003!2d108.2608913!3d15.9688859!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142116949840599%3A0x365b35580f52e8d5!2zxJDhuqFpIGjhu41jIEZQVCDEkMOgIE7hurVuZw!5e0!3m2!1svi!2s!4v1718764574863!5m2!1svi!2s" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </c:when>
                                        <c:when test="${event.location == 'Đại học FPT Cần Thơ'}">
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15716.213416548251!2d105.7324316!3d10.0124518!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2sFPT%20University!5e0!3m2!1svi!2s!4v1718766046530!5m2!1svi!2s" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                        </c:when>

                                    <c:otherwise>
                                        <p class="text-warning"><strong>Location not available</strong></p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Interested Members -->
    <div class="modal fade" id="interestedMembersModal" tabindex="-1" role="dialog" aria-labelledby="interestedMembersModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="interestedMembersModalLabel">People going to join</h5>
                    <button type="button" class="close btn-close" data-dismiss="modal" aria-label="Close">
                       
                    </button>
                </div>
                <div class="modal-body">
                    <ul class="member-list">
                        <c:forEach var="member" items="${interestedUsers}">
                            <li>${member}</li>
                            </c:forEach>
                    </ul>
                </div>
               
            </div>
        </div>
    </div>
</body>
<%@ include file="../include/footer.jsp" %>
