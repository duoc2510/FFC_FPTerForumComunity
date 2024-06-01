// scripts.js

function editComment(commentId, content) {
    document.getElementById('editCommentId').value = commentId;
    document.getElementById('editContent').value = content;
    var editCommentModal = new bootstrap.Modal(document.getElementById('editCommentModal'));
    editCommentModal.show();
}

function showMemberGroup() {
    document.getElementById('pendingRequest').style.display = 'none';
    document.getElementById('memberGroup').style.display = 'block';
}

function showPendingRequest() {
    document.getElementById('memberGroup').style.display = 'none';
    document.getElementById('pendingRequest').style.display = 'block';
}

document.getElementById('memberGroupBtn').addEventListener('click', showMemberGroup);
document.getElementById('pendingRequestBtn').addEventListener('click', showPendingRequest);

function confirmLeaveGroup(form) {
    return confirm('Are you sure you want to leave this group?');
}

document.getElementById('postImage').addEventListener('change', function (event) {
    const file = event.target.files[0];
    const previewContainer = document.getElementById('imgPreview');
    const previewImage = document.createElement('img');
    const previewDefaultText = previewContainer.querySelector('p');

    if (file) {
        const reader = new FileReader();
        previewDefaultText.style.display = 'none';
        previewImage.style.display = 'block';

        reader.addEventListener('load', function () {
            previewImage.setAttribute('src', this.result);
        });

        reader.readAsDataURL(file);
        previewContainer.appendChild(previewImage);
    } else {
        previewDefaultText.style.display = null;
        previewImage.style.display = null;
    }
});

document.getElementById("btnActive").addEventListener("click", function () {
    var activePosts = document.getElementsByClassName("post-active");
    var pendingPosts = document.getElementsByClassName("post-pending");

    for (var i = 0; i < activePosts.length; i++) {
        activePosts[i].style.display = "block";
    }
    for (var i = 0; i < pendingPosts.length; i++) {
        pendingPosts[i].style.display = "none";
    }
});

document.getElementById("btnPending").addEventListener("click", function () {
    var activePosts = document.getElementsByClassName("post-active");
    var pendingPosts = document.getElementsByClassName("post-pending");

    for (var i = 0; i < activePosts.length; i++) {
        activePosts[i].style.display = "none";
    }
    for (var i = 0; i < pendingPosts.length; i++) {
        pendingPosts[i].style.display = "block";
    }
});

// Initially display only active posts
document.getElementById("btnActive").click();
