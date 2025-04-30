document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('loginForm');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');

    form.addEventListener('submit', function (e) {
        let valid = true;
        const email = emailInput.value.trim();
        const password = passwordInput.value.trim();

        // Kiểm tra email
        if (email === '') {
            alert('Vui lòng nhập email.');
            emailInput.focus();
            valid = false;
        } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert('Email không hợp lệ.');
            emailInput.focus();
            valid = false;
        }

        // Kiểm tra mật khẩu
        else if (password === '') {
            alert('Vui lòng nhập mật khẩu.');
            passwordInput.focus();
            valid = false;
        }

        if (!valid) {
            e.preventDefault(); // Ngăn submit nếu không hợp lệ
        }
    });
});
