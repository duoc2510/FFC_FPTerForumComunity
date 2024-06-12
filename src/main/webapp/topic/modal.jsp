<!-- Add Topic Modal -->
<div class="modal fade" id="addTopicModal" tabindex="-1" aria-labelledby="addTopicModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addTopicModalLabel">Add New Topic</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="home" method="post">
                    <input type="hidden" name="action" value="addtopic">
                    <div class="mb-3">
                        <label for="topicName" class="form-label">Topic Name</label>
                        <input type="text" class="form-control" id="topicName" name="topicName" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <input type="text" class="form-control" id="description" name="description" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Add Topic</button>
                </form>
            </div>
        </div>
    </div>
</div>