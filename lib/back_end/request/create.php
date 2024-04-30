<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$food = trim($_POST['food']);
$count = trim($_POST['count']);
$reason = trim($_POST['reason']);
$requiredDate = trim($_POST['requiredDate']);
$beneficiary = trim($_POST['beneficiary']);
$location = trim($_POST['location']);
$date = date('Y-m-d');

$field = 0;

if (!$food || $food == 'null') {
    $field++;
}else if (!$count || $count == 'null') {
    $field++;
}else if (!$reason || $reason == 'null') {
    $field++;
}else if (!$requiredDate || $requiredDate == 'null') {
    $field++;
}else if (!$location || $location == 'null') {
    $field++;
}

if ($field == 0) {
    $sql = "INSERT INTO request(R_F_id_fk, R_food_count, R_reason, R_status, R_B_id_fk, R_date, R_reuiredDate, R_pickLocation) 
    VALUES ('$food','$count','$reason','Active','$beneficiary','$date','$requiredDate','$location')";

    $query = mysqli_query($con, $sql);

    if ($query) {
        $req_id = mysqli_insert_id($con);
        $sql1 = "INSERT INTO notification (N_R_id_fk, N_status) VALUES ('$req_id','not seen')";

        $query1 = mysqli_query($con, $sql1);
        if ($query1) {
            echo json_encode("Success");
        }
    } else {
        echo json_encode("Error");
    }
} else {
    echo json_encode("not complete");
}
?>
