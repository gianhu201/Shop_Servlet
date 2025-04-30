// Xử lý phản hồi từ Google Sign-In
function handleCredentialResponse(response) {
    // Lấy token từ phản hồi
    console.log("Encoded JWT ID token: " + response.credential);

    // Gửi token này lên server để xác thực và lấy thông tin người dùng
    fetch('/ClothingShop_war_exploded/oauth2callback', {
        method: 'POST',
        body: JSON.stringify({ credential: response.credential }),
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                // Điều hướng người dùng đến trang chủ sau khi đăng nhập thành công
                window.location.href = "/views/welcome.jsp";
            } else {
                console.error("Login failed", data.message);
            }
        })
        .catch(err => console.error("Error during login:", err));
}
