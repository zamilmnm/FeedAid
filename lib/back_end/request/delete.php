<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$r_id = trim($_POST['rID']);

// $r_id = 6;

$sql = "DELETE FROM notification WHERE N_R_id_fk = '$r_id'";
$query = mysqli_query($con, $sql);

if ($query) {
    $sql1 = "DELETE FROM request WHERE R_id = '$r_id'";
    $query1 = mysqli_query($con, $sql1);

    if ($query1) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error");
    }
} else {
    echo json_encode("Error");
}
?>