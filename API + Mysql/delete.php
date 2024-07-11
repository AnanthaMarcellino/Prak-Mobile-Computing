<?php
$connection = new
mysqli("localhost","mobw7774_anantha","Linelock120303","mobw7774_api_anantha");
$id = $_POST['id'];
$result = mysqli_query($connection, "delete from notes where
id=".$id);
if($result){
echo json_encode([
'message' => 'Notes berhasil di hapus'
]);
}else{
echo json_encode([
'message' => 'Notes gagal di hapus'
]);
}
