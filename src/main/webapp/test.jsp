<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Demo Modal ?ánh Giá</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha384-ZvpUoO/+PpQQUH9rn+2VbQj+Na+aP3pDlpiQ/9u7mtV/fJcF5D1mc0tDgg9rPmk8" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq7tBKTz0E3MG77j5aa8x0DJtjwZFRVf4JGzFJfPBACR68X0hD" crossorigin="anonymous"></script>
        <script>
            function openRatingModal(orderID) {
                // ??t giá tr? cho tr??ng orderId trong form
                $('#ratingOrderId').val(orderID);

                // M? modal s? d?ng Bootstrap jQuery
                $('#ratingModal').modal('show');
            }
        </script>
    </head>
    <body>

        <div class="container mt-4">
            <h1>Demo Modal ?ánh Giá</h1>
            <button type="button" class="btn btn-success btn-sm" onclick="openRatingModal(123)">
                ?ánh giá ??n hàng
            </button>
        </div>

        <!-- Rating Modal -->
        <div class="modal fade" id="ratingModal" tabindex="-1" aria-labelledby="ratingModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ratingModalLabel">?ánh giá ??n hàng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="process-rating.php" method="post" id="ratingForm">
                            <input type="hidden" name="orderId" id="ratingOrderId">
                            <div class="form-group">
                                <label for="orderRate">?ánh giá ??n hàng</label>
                                <select class="form-control" id="orderRate" name="orderRate" required>
                                    <option value="">Ch?n ?ánh giá</option>
                                    <option value="1">1 - R?t t?</option>
                                    <option value="2">2 - T?</option>
                                    <option value="3">3 - Trung bình</option>
                                    <option value="4">4 - T?t</option>
                                    <option value="5">5 - Xu?t s?c</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">G?i ?ánh giá</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
<%@include file="include/footer.jsp" %>
