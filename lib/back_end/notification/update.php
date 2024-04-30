<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$sql = "UPDATE notification SET N_status = 'seen' WHERE N_status = 'not seen'";
$query = mysqli_query($con, $sql);

if ($query) {
    echo json_encode("Success");
}else {
    echo json_encode("Error");
}
?>