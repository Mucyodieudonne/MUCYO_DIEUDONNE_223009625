<?php
session_start();
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header("Location: /hotel_website/login.html");
    exit();
}

$username = trim($_POST['username']);
$password = $_POST['password'];

$stmt = $conn->prepare("SELECT id, username, password, role FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        $_SESSION['user']    = $user['username'];
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role']    = $user['role'];

        // Redirect based on role
        if ($user['role'] === 'admin') {
            header("Location: /dashboard.php");
        } else {
            header("Location: /hotel_website/my_account.php");
        }
        exit();
    }
}

header("Location: /hotel_website/login.html?error=1");
exit();
?>