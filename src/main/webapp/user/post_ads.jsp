<%-- 
    Document   : post_ads
    Created on : Jul 17, 2024, 9:10:55 PM
    Author     : mac
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12">
    <div class="w-100">

        <div class="py-4 px-4 bg-white shadow rounded mb-3">
            <a id="adsURL">
                <div class="pb-3 d-flex-inline row px-3">
                    <div class="col-1">
                        <a href="/FPTer/profile">
                            <img id="adUserAvatar" alt="" class="rounded-circle avatar-cover" style="width: 50px; height:50px">
                        </a>
                    </div>
                    <div class="col-10 d-flex ps-3" style="flex-direction: column;">
                        <h6 class="card-title fw-semibold d-inline" id="adsOrganizer"></h6>
                        <a href="javascript:void(0)" class="s-4" id="adsStartDate"></a>
                    </div>
                    <div class="dropdown col-1 px-2" style="text-align: right">
                        <a class="dropdown-toggle" href="#" role="button" dataAdsView-bs-toggle="dropdown" aria-expanded="false">
                            <span><i class="ti-more-alt"></i></span>   
                        </a>

                    </div>
                    <p class="card-text mt-2">Sponsored</p>
                </div>
                <div class="mt-1 px-1">
                    <p id="adsContent"></p>
                    <img id="adsImage" alt="Ads Image" class="post-image rounded mx-auto d-block">
                </div>
            </a>

        </div>
    </div>
</div>

<script>
    function loadAdView() {
        var comboTypeView = 'view'; // Example comboType
        var targetSexView = '${USER.userSex}'.toLowerCase();  // Replace with your dynamic value from server

        var urlView = '${pageContext.request.contextPath}/advertising/show?comboType=' + comboTypeView + '&targetSex=' + targetSexView;

        fetch(urlView)
                .then(response => response.json())
                .then(dataAdsView => {
                    console.log(dataAdsView);

                    if (dataAdsView.ad && dataAdsView.ad.adsId) { // Check if valid ad dataAdsView is returned
                        document.getElementById('adUserAvatar').src = '${pageContext.request.contextPath}/' + dataAdsView.user.userAvatar;
                        document.getElementById('adsImage').src = '${pageContext.request.contextPath}/' + dataAdsView.ad.image;
                        document.getElementById('adsImage').alt = dataAdsView.ad.title;

                        document.getElementById('adsContent').innerText = dataAdsView.ad.content;
                        document.getElementById('adsURL').href = dataAdsView.ad.uri;


                        document.getElementById('adsStartDate').innerText = dataAdsView.ad.startDate; // Assuming startDate is a valid date field
                        document.getElementById('adsOrganizer').innerText = dataAdsView.user.userFullName; // Use userFullName for the sponsor name
                    }
                })
                .catch(error => {
                    console.error('Error loading ad details:', error);

                });
    }

    // Call loadAdView() when the window loads
    window.onload = function () {
        loadAdTraffic();
        loadAdView();
    };
</script>



<!--                        <div class="modal fade" id="reportPostModal_6" tabindex="-1" aria-labelledby="reportPostModalLabel_6" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form id="reportPostForm_6" action="/FPTer/report" method="post">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="reportPostModalLabel_6">Report post</h5>
                                            <button type="button" class="btn-close" dataAdsView-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label for="reportPostReason_6" class="form-label">Reason</label>
                                                <textarea class="form-control" id="reportPostReason_6" name="reportReason" rows="3" required></textarea>
                                            </div>

                                            <input type="hidden" name="postId" value="6">
                                            <input type="hidden" name="userId" value="6">
                                            <input type="hidden" name="userRole" value="3">
                                            <input type="hidden" name="action" value="rpPost">
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" dataAdsView-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-primary">Submit report</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>-->

<!--                        <div class="modal fade" id="cancelReportModal_6" tabindex="-1" aria-labelledby="cancelReportModalLabel_6" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cancelReportModalLabel_6">Cancel Report</h5>
                <button type="button" class="btn-close" dataAdsView-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/FPTer/report" method="post">
                    <input type="hidden" name="postId" value="6">

                    <input type="hidden" name="action" value="cancelReportPost">
                    <p>Are you sure you want to revoke this report?</p>
                    <button type="submit" class="btn btn-danger">Cancel Report</button>
                    <button type="button" class="btn btn-secondary" dataAdsView-bs-dismiss="modal">Close</button>
                </form>
            </div>
        </div>
    </div>
</div>-->

<!--                        <div class="modal fade" id="editPostReportModal" tabindex="-1" aria-labelledby="editPostReportModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editPostReportModalLabel">Edit Post Report</h5>
                                        <button type="button" class="btn-close" dataAdsView-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="/FPTer/report" method="post">
                                            <input type="hidden" name="postId" value="6">

                                            <input type="hidden" name="action" value="editPostReport">
                                            <div class="mb-3">
                                                <label for="editReason" class="form-label">New Reason:</label>
                                                <textarea class="form-control" id="editReason" name="editReason" rows="3" required></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Save Changes</button>
                                            <button type="button" class="btn btn-secondary" dataAdsView-bs-dismiss="modal">Close</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>-->


<!--                        <div class="modal fade" id="banPostModal_6" tabindex="-1" aria-labelledby="banPostModalLabel_6" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="banPostModalLabel_6">Enter the reason for banning the post</h5>
                                        <button type="button" class="btn-close" dataAdsView-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="banPostFormReason_6" action="/FPTer/manager/report" method="post">
                                            <input type="hidden" name="postId" value="6">

                                            <input type="hidden" name="reportedId" value="6">
                                            <input type="hidden" name="postContent" value="123123">
                                            <input type="hidden" name="action" value="banPost">   
                                            <div class="mb-3">
                                                <label for="banReason_6" class="form-label">Reason for banning posts:</label>
                                                <textarea class="form-control" id="banReason_6" name="banReason" rows="3" required></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" dataAdsView-bs-dismiss="modal">Close</button>
                                        <button type="submit" form="banPostFormReason_6" class="btn btn-danger">Ban post</button>
                                    </div>
                                </div>
                            </div>
                        </div>-->


<!--                        <div class="modal fade" id="banPostModal3Time_6" tabindex="-1" aria-labelledby="banPostModalLabel_6" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="banPostModalLabel_6">Enter the reason for banning the post </h5>
                                        <button type="button" class="btn-close" dataAdsView-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="banPostFormReason3Time_6" action="/FPTer/manager/report" method="post">
                                            <input type="hidden" name="postId" value="6">

                                            <input type="hidden" name="reportedId" value="6">
                                            <input type="hidden" name="postContent" value="123123">
                                            <input type="hidden" name="action" value="banPostMore3Time">   
                                            <div class="mb-3">
                                                <label for="banReason_6" class="form-label">Reason for banning posts:</label>
                                                <textarea class="form-control" id="banReason_6" name="banReason" rows="3" required></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" dataAdsView-bs-dismiss="modal">Close</button>
                                        <button type="submit" form="banPostFormReason3Time_6" class="btn btn-danger">Ban post</button>
                                    </div>
                                </div>
                            </div>
                        </div>-->


<!--                <div class="row py-3 px-3">
                           Like button (Th? <a>), hi?n th? khi ch?a like 
                          <p id="like-count-6"> 0 like</p>
      
                           Nút Like 
                          <a href="#" id="like-btn-6" class="col nav-link nav-icon-hover" style="" onclick="handleLike(event, 6, 'like')" dataAdsView-postid="6" dataAdsView-action="like">
                              <span><i class="ti ti-heart" style="color: green;"></i></span>
                              <span class="hide-menu" style="color: green;">Like</span>
                          </a>
      
                           Nút Unlike 
                          <a href="#" id="unlike-btn-6" class="col nav-link nav-icon-hover" style="display:none;" onclick="handleLike(event, 6, 'unlike')" dataAdsView-postid="6" dataAdsView-action="unlike">
                              <span><i class="ti ti-heart-broken" style="color: red;"></i></span>
                              <span class="hide-menu" style="color: red;">Unlike</span>
                          </a>
      
                          <a class="col nav-link nav-icon-hover">
                              <span><i class="ti ti-message-plus"></i></span>
                              <span class="hide-menu">Comment</span>
                          </a>
                      </div>-->

<!--                <form action="/FPTer/comment" method="post" class="input-group">
<input type="hidden" name="action" value="addComment">
<input type="hidden" name="postId" value="6">
<input type="hidden" name="userId" value="">
<input type="text" class="form-control rounded " name="content" placeholder="Write a comment" required>
<button type="submit" class="btn btn-primary rounded ms-3"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
<path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
</svg> </button>
</form>-->

<!--                <div class="comments mt-3">

</div>-->