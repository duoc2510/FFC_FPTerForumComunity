<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Group Form</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../include/slidebar.jsp" %>

    <div class="container">
        <%@ include file="../include/navbar.jsp" %>
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        <h4>Create Group</h4>
                    </div>
                    <div class="card-body">
                        <form action="addGroup" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="groupName">Group Name</label>
                                <input type="text" class="form-control" id="groupName" name="groupName" placeholder="Enter your group">
                            </div>
                            <div class="form-group">
                                <label for="groupDescription">Description</label>
                                <textarea class="form-control" id="groupDescription" rows="3" name="groupDescription" placeholder="Enter your group description"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="groupAvatar">Group Avatar</label>
                                <input type="file" class="form-control-file" id="groupAvatar" name="groupAvatar">
                            </div>
                            <c:if test="${not empty message}">
                                <div class="alert alert-info" role="alert">
                                    <c:out value="${message}" />
                                </div>
                            </c:if>
                            <button type="submit" class="btn btn-primary">Create</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="../include/right-slidebar.jsp" %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

<%@ include file="../include/footer.jsp" %>
