<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$sql = "SELECT * FROM food";

$query = mysqli_query($con, $sql);

$response = array();
while ($row = mysqli_fetch_assoc($query)) {
    array_push($response, $row);
}

if ($query) {
    echo json_encode($response);
}else {
    echo json_encode("Error");
}

?>
