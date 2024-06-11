<%-- 
    Document   : index
    Created on : May 25, 2024, 9:43:06 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
    .card-img-top{
        height:250px;
        object-fit: cover;
    }
    .card-text{
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 200px;
        overflow: hidden;
    }
    .imgs-grid{
        display: grid;
        grid-template-columns: repeat(27, 1fr);
        position: relative;
    }
    .imgs-grid .grid.grid-1 {
        -ms-grid-column: 1;
        -ms-grid-column-span: 18;
        grid-column: 1 / span 18;
        -ms-grid-row: 1;
        -ms-grid-row-span: 27;
        grid-row: 1 / span 27;
    }
    .imgs-grid .grid.grid-2 {
        -ms-grid-column: 19;
        -ms-grid-column-span: 27;
        grid-column: 19 / span 27;
        -ms-grid-row: 1;
        -ms-grid-row-span: 5;
        grid-row: 1 / span 5;
        padding-left: 20px;
    }
    .imgs-grid .grid.grid-3 {
        -ms-grid-column: 14;
        -ms-grid-column-span: 16;
        grid-column: 14 / span 16;
        -ms-grid-row: 6;
        -ms-grid-row-span: 27;
        grid-row: 6 / span 27;
        padding-top: 20px;
    }
    .imgs-grid .grid img {
        border-radius: 20px;
        max-width: 100%;
    }
</style>
<body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
         data-sidebar-position="fixed" data-header-position="fixed">
        <c:if test="${not empty sessionScope.USER}">
            <%@ include file="../include/slidebar.jsp" %>
        </c:if>
        <c:if test="${empty sessionScope.USER}">
            <%@ include file="../include/slidebar_guest.jsp" %>
        </c:if>
        <div class="body-wrapper">
            <c:if test="${not empty sessionScope.USER}">
                <%@ include file="../include/navbar.jsp" %>
            </c:if>
            <c:if test="${empty sessionScope.USER}">
                <%@ include file="../include/navbar_guest.jsp" %>
            </c:if>
            <div class="container-fluid">
                <!--Control panel-->
                <%@ include file="panel.jsp" %>


                <div class="col-lg-12">


                    <div class="w-100 row mt-5">
                        <div class="col-md-6 p-3 ">
                            <h3>Boost My Branding</h3>
                            <p>Growth your business with us, you can:</p>
                            <ul class="list-unstyled custom-list my-4">


                                <li>Giám sát tất cả các Trang, tài khoản và tài sản doanh nghiệp ở cùng một nơi.</li>
                                <li>Dễ dàng tạo và quản lý quảng cáo cho tất cả các tài khoản.</li>
                                <li>Theo dõi xem yếu tố nào hoạt động hiệu quả nhất bằng thông tin chi tiết về hiệu quả.</li>
                            </ul>
                            <button class="btn btn-primary mt-3">Join with us</button>
                        </div>
                        <div class="col-md-6 p-3">
                            <form method="POST">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Title</label>
                                    <input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Content</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Image</label>
                                    <input type="file" class="form-control">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">URI</label>
                                    <input type="text" class="form-control">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Budget per day</label>
                                    <input type="range" class="form-control" id="budgetRange" min="10000" max="1000000" step="10000">
                                    <div class="value-display">Value: <span id="budgetValue">10000</span> VND /day</div>
                                </div>

                                <script>
                                    const budgetRange = document.getElementById('budgetRange');
                                    const budgetValue = document.getElementById('budgetValue');

                                    budgetRange.addEventListener('input', () => {
                                        budgetValue.textContent = budgetRange.value;
                                    });

                                    // Initialize the display value
                                    budgetValue.textContent = budgetRange.value;
                                </script>


                                <button type="submit" class="btn btn-primary">Boost</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%@ include file="../include/footer.jsp" %>



