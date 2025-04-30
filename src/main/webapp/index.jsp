<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            overflow: hidden;
        }
        .container {
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            background: url('views/images/welcome.jpg') no-repeat center center/cover;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 48%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            clip-path: polygon(0 0, 70% 0, 100% 100%, 0 100%);
        }
        .content {
            position: relative;
            z-index: 1;
            padding: 50px;
            color: #333;
        }
        .logo {
            position: absolute;
            top: 20px;
            left: 20px;
            width: 50px;
            height: 50px;
            background: #6a5acd;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        h1 {
            font-size: 3em;
            color: #4b0082;
            margin: 0;
        }
        p {
            font-size: 1.2em;
            color: #666;
            margin: 10px 0 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #6a5acd;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #483d8b;
        }
        .pagination {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
        }
        .dot {
            width: 10px;
            height: 10px;
            background: #ccc;
            border-radius: 50%;
        }
        .dot.active {
            background: #6a5acd;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logo">LOGO</div>
    <div class="overlay"></div>
    <div class="content">
        <h1>WELCOME TO SHOP</h1>
        <p>Hey there! Welcome to our shop – your next favorite outfit is waiting!</p>
        <a href="${pageContext.request.contextPath}/product" class="btn">GET STARTED</a>
    </div>
    <div class="pagination">
        <div class="dot active"></div>
        <div class="dot"></div>
        <div class="dot"></div>
    </div>
</div>
</body>
</html>