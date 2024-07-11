<?php
define('HOST', 'localhost');
define('USER', 'mobw7774_anantha');
define('PASS', 'Linelock120303');
define('DB', 'mobw7774_api_anantha');
$connect = mysqli_connect(HOST, USER, PASS, DB) or die('Not Connect');
?>
<?php
//For Running
$username = $_POST['username'];
$password = $_POST['password'];
//For Testing
//$username = 'anantha123';
//$password = '123';
$queryResult=$connect->query("SELECT * FROM users WHERE username='".$username."'
and password='".$password."'");
$result=array();
while($fetchData=$queryResult->fetch_assoc()) {
$result[]=$fetchData;
}
//Send back data to Flutter
if($result){
echo json_encode($result);
}else{
echo json_encode('');
}
?>