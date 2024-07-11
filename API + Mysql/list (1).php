<?php
$connection = new
mysqli("localhost","mobw7774_anantha","Linelock120303","mobw7774_api_anantha");
$data = mysqli_query($connection, "select * from notes");
$data = mysqli_fetch_all($data, MYSQLI_ASSOC);
echo json_encode($data);