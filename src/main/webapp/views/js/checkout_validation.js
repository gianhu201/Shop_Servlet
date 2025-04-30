function validateForm() {
    let valid = true;

    // Clear previous error messages
    document.getElementById("firstNameError").innerHTML = "";
    document.getElementById("lastNameError").innerHTML = "";
    document.getElementById("addressError").innerHTML = "";
    document.getElementById("cityError").innerHTML = "";
    document.getElementById("phoneError").innerHTML = "";
    document.getElementById("emailError").innerHTML = "";
    document.getElementById("paymentMethodError").innerHTML = "";
    document.getElementById("countryError").innerHTML = "";

    // Check First Name
    const recipientName = document.getElementById("recipientName").value;
    if (recipientName === "") {
        valid = false;
        document.getElementById("recipientNameError").innerHTML = "Vui lòng nhập tên nguoi nhan!";
    }

    // Check Address
    const address = document.getElementById("address").value;
    if (address === "") {
        valid = false;
        document.getElementById("addressError").innerHTML = "Vui lòng nhập địa chỉ!";
    }

    // Check City
    const city = document.getElementById("city").value;
    if (city === "") {
        valid = false;
        document.getElementById("cityError").innerHTML = "Vui lòng nhập tỉnh/thành phố!";
    }

    // Check Phone (only numbers, length 10-11 digits)
    const phone = document.getElementById("phone").value;
    const phonePattern = /^[0-9]{10,11}$/;
    if (!phonePattern.test(phone)) {
        valid = false;
        document.getElementById("phoneError").innerHTML = "Số điện thoại không hợp lệ!";
    }

    // Check Email
    const email = document.getElementById("email").value;
    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailPattern.test(email)) {
        valid = false;
        document.getElementById("emailError").innerHTML = "Email không hợp lệ!";
    }

    // Check Payment Method
    const paymentMethod = document.getElementById("paymentMethod").value;
    if (paymentMethod === "") {
        valid = false;
        document.getElementById("paymentMethodError").innerHTML = "Vui lòng chọn phương thức thanh toán!";
    }

    // Validate reCAPTCHA
    const recaptchaResponse = grecaptcha.getResponse();
    if (recaptchaResponse.length === 0) {
        alert('Vui lòng xác nhận bạn không phải là robot');
        valid = false;
    }

    return valid;
}
