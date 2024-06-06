<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="col-lg-12 w-100">
    <style>
        .card .avatar img {
            width: 100%;
            object-fit: cover;
            aspect-ratio: 1 / 1;
        }
        .card-content img {
            height: 300px;
            object-fit: cover;
        }
    </style>
    <div class="row">
        <div class="card">
            <div class="card-body p-4 row">
                <div class="col-sm-2 px-2 text-center" style="padding-right: 1rem">
                    <div class="avatar">
                        <img class="rounded-circle" src="https://media.pitchfork.com/photos/654c5978b75d13ed9ad0eeca/16:9/w_1776,h_999,c_limit/frank-ocean.jpg" loading="lazy">
                    </div>
                    <h4>Christine Truong</h4>
                    <span class="badge w-100 text-center rounded-pill text-bg-warning">Platinum</span>
                </div>
                <div class="col-sm-10">
                    <div class="content p-sm-2">
                        <p class="date-time">3/2/21</p>
                        <p class="main-content">JPD123_Spring2024_ME_7_308715 02/02/2024 16h10</p>
                        <h2 class="my-4">Đính kèm </h2>
                        <div class="row mx-0">
                            <!--LOOP THIS FOR IMAGES-->
                            <div class="col-sm-4 px-sm-2">
                                <div class="card card-content">
                                    <img src="https://image.cnbcfm.com/api/v1/image/107418710-1716399488875-ROBERT_FRANK_EXTENDED.jpg?v=1716471027" class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <p class="card-text">Some quick example.</p>
                                    </div>
                                </div>
                            </div>
                            <!--LOOP THIS FOR IMAGES-->
                            <div class="col-sm-4 px-sm-2">
                                <div class="card card-content">
                                    <img src="https://nypost.com/wp-content/uploads/sites/2/2021/01/re-robert-frank.jpg?quality=75&strip=all&w=744" class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <p class="card-text">Some quick example.</p>
                                    </div>
                                </div>
                            </div>
                            <!--LOOP THIS FOR IMAGES-->
                            <div class="col-sm-4 px-sm-2">
                                <div class="card card-content">
                                    <img src="https://nypost.com/wp-content/uploads/sites/2/2021/01/re-robert-frank.jpg?quality=75&strip=all&w=744" class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <p class="card-text">Some quick example.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                function showDetail(src) {
                    Swal.fire({
                        html: `
                            <div class="card text-bg-dark">
                                <img src="${src}" class="card-img" alt="...">
                            </div>
                        `,
                        showCloseButton: true,
                    });
                }

                // Attach click event to all images with the class 'card-img-top'
                document.querySelectorAll('.card-img-top').forEach(img => {
                    img.addEventListener('click', function () {
                        showDetail(this.src);
                    });
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </div>
</div>