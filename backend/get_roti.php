<?php
$server = "localhost";
$user = "root";
$password = "";
$db = "sertifikasi_jmp";

$connect = new mysqli($server, $user, $password, $db);

if ($connect->connect_error) {
    die("Koneksi gagal: " . $connect->connect_error);
}

$result = $connect->query("SELECT * FROM roti");
$roti = array();

while ($row = $result->fetch_assoc()) {
    $roti[] = $row;
}

header('Content-Type: application/json');
echo json_encode($roti);
$connect->close();
?>
