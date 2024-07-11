<?php
$connection = new
mysqli("localhost","mobw7774_anantha","Linelock120303","mobw7774_api_anantha");
$judul = $_POST['judul'];
$content = $_POST['content'];
$date = date('Y-m-d');
$result = mysqli_query($connection, "insert into notes set
judul='$judul', content='$content', date='$date'");
if($result){
echo json_encode([
'message' => 'Notes berhasil di input'
]);
}else{
echo json_encode([
'message' => 'Notes gagal di input'
]);
}
