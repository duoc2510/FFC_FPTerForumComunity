
<!-- Modal -->
<div class="modal fade" id="createGroupModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Create Group</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/group" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="createGroup">
                    <div class="form-group">
                        <label for="groupName">Group Name</label>
                        <input type="text" class="form-control" id="groupName" name="groupName" placeholder="Enter your group" required>
                    </div>
                    <div class="form-group">
                        <label for="groupDescription">Description</label>
                        <textarea class="form-control" id="groupDescription" rows="3" name="groupDescription" placeholder="Enter your group description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="groupAvatar">Group Avatar</label>
                        <input type="file" class="form-control-file" id="groupAvatar" name="groupAvatar" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Modal for editing comment -->
<div class="modal fade" id="editCommentModal" tabindex="-1" aria-labelledby="editCommentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCommentModalLabel">Edit Comment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editCommentForm" action="${pageContext.request.contextPath}/comment" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="editComment">
                    <input type="hidden" id="editCommentId" name="commentId">
                    <div class="form-group">
                        <label for="editCommentContent">Content:</label>
                        <textarea class="form-control" id="editCommentContent" name="newContent" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Post Modal -->
<div class="modal fade" id="editPostModal" tabindex="-1" aria-labelledby="editPostModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPostModalLabel">Edit Post</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editPostForm" action="${pageContext.request.contextPath}/post" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <input type="hidden" name="action" value="editPost">
                    <input type="hidden" id="editPostId" name="postId">
                    <input type="hidden" id="existingUploadPath" name="existingUploadPath">
                    <div class="form-group">
                        <label for="editPostContent">Content:</label>
                        <textarea class="form-control" id="editPostContent" name="newContent" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editPostStatus">Status:</label>
                        <select class="form-control" id="editPostStatus" name="newStatus">
                            <option value="Public" selected>Public</option>
                            <option value="Friends">Friends</option>
                            <option value="Only me">Only me</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editPostImage">Upload Image:</label>
                        <input type="file" class="form-control rounded mx-auto d-block" id="editPostImage" name="newUploadPath" accept="image/*" style="max-width: 100%; height: auto;">
                        <div class="img-preview" id="editImgPreview">
                            <div class="form-group">
                                <label>Current Image:</label>
                                <img id="currentUploadPath" src="" class="rounded mx-auto d-block" alt="Current post image" style="max-width: 100%; height: auto;">
                            </div>                        
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
