<?php
$connection = new
mysqli("localhost","mobw7774_anantha","Linelock120303","mobw7774_api_anantha");
$judul = $_POST['judul'];
$content = $_POST['content'];
$id = $_POST['id'];
$result = mysqli_query($connection, "update notes set judul='$judul',
content='$content' where id='$id'");
if($result){
echo json_encode([
'message' => 'Notes berhasil di update'
]);
}else{
echo json_encode([
'message' => 'Notes gagal di update'
]);
}
