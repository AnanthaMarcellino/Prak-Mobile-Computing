<?php
$connection = new
mysqli("localhost","mobw7774_anantha","Linelock120303","mobw7774_api_anantha");
$data = mysqli_query($connection, "select * from notes where
id=".$_GET['id']);
$data = mysqli_fetch_array($data, MYSQLI_ASSOC);
echo json_encode($data);