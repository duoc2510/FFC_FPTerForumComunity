const vietnamPhoneRegex = /^(0|\+84)(3|5|7|8|9)\d{8}$/;

// Example usage:
const inputElement = document.querySelector('input[name="phone"]');
inputElement.addEventListener('input', function() {
    if (vietnamPhoneRegex.test(inputElement.value)) {
        inputElement.setCustomValidity('');
    } else {
        inputElement.setCustomValidity('Invalid Vietnamese phone number');
    }
});
