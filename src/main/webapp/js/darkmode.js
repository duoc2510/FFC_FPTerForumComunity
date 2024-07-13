 document.addEventListener("DOMContentLoaded", function () {
        var darkModeToggle = document.getElementById("darkModeToggle");
        var body = document.body;

        // Check the saved preference and apply it
        var isDarkMode = localStorage.getItem("_onDark") === "true";
        updateDarkMode(isDarkMode);

        // Toggle dark mode on button click
        darkModeToggle.addEventListener("click", function () {
            isDarkMode = !isDarkMode;
            updateDarkMode(isDarkMode);
            localStorage.setItem("_onDark", isDarkMode);
        });

        function updateDarkMode(isDarkMode) {
            if (isDarkMode) {
                enableDarkMode();
            } else {
                disableDarkMode();
            }
        }

        function enableDarkMode() {
            body.classList.add("darkmode");
            darkModeToggle.classList.add("active");
            darkModeToggle.textContent = "Light mode";
        }

        function disableDarkMode() {
            body.classList.remove("darkmode");
            darkModeToggle.classList.remove("active");
            darkModeToggle.textContent = "Dark mode";
        }
    });