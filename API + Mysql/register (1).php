<?php
define('HOST', 'localhost');
define('USER', 'mobw7774_anantha');
define('PASS', 'Linelock120303');
define('DB', 'mobw7774_api_anantha');
$connect = mysqli_connect(HOST, USER, PASS, DB) or die('Not Connect');
$username = $_POST['username'];
$password = $_POST['password'];
if ($username != '' && $password != '') {
$result2 = mysqli_query($connect,
"INSERT INTO users
SET username='$username', password='$password'"
);
if ($result2) {
echo json_encode('success');
} else {
echo json_encode('error');
}
} else {
echo json_encode('data_not_complete');
}
?>