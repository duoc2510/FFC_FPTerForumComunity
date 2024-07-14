function setCookie(name, value, days) {
    const d = new Date();
    d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
    const expires = "expires=" + d.toUTCString();
    document.cookie = name + "=" + (value || "") + ";" + expires + ";path=/";
}

function getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ')
            c = c.substring(1);
        if (c.indexOf(nameEQ) === 0)
            return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function applyDarkMode() {
    const darkMode = getCookie("darkMode");
    if (darkMode === "true") {
        document.body.classList.add("dark");
        checkbox.checked = true;
    } else {
        document.body.classList.remove("dark");
        checkbox.checked = false;
    }
}

checkbox.addEventListener("change", () => {
    const isChecked = checkbox.checked;
    if (isChecked) {
        document.body.classList.add("dark");
    } else {
        document.body.classList.remove("dark");
    }
    setCookie("darkMode", isChecked, 7); // Save the preference for 7 days
});

applyDarkMode();