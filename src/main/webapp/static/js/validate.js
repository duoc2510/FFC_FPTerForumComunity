$(document).ready(function() {
    // Function to check if the URI contains "https://"
    function validateURI() {
        var uri = $("input[name='URI']").val();
        if (!uri.startsWith("https://")) {
            alert("The URL must start with 'https://'");
        }
    }

    // Attach the blur event to the URI input field
    $("input[name='URI']").on('blur', function() {
        validateURI();
    });
});