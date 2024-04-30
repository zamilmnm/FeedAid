<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$r_id = trim($_POST['rID']);
$h_id = trim($_POST['hID']);
$feedback = trim($_POST['feedback']);
$date = date('Y-m-d');

$sql = "UPDATE request SET R_status = 'Delivered' WHERE R_id = '$r_id'";

$query = mysqli_query($con, $sql);

if (!$feedback || $feedback != 'null') {
    if ($query) {
        $sql1 = "INSERT INTO feedback (Fe_H_id_fk, Fe_summary, Fe_date) VALUES ('$h_id','$feedback','$date')";
        $query1 = mysqli_query($con, $sql1);
        if ($query1) {
            $sql2 = "INSERT INTO delivery (D_date, D_H_id_fk) VALUES ('$date','$h_id')";
            $query2 = mysqli_query($con, $sql2);
            
            if ($query2) {
                echo json_encode("Success");
            }
        }
    }else {
        echo json_encode("Error");
    }
} else {
    echo json_encode("not complete");
}
?>
