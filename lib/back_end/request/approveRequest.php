<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}
$D_id = trim($_POST['dID']);
$R_id = trim($_POST['rID']);
$V_id = trim($_POST['volunteer']);
$date = date('Y-m-d');

$sql = "UPDATE request SET R_status = 'Approved' WHERE R_id = '$R_id'";

$query = mysqli_query($con, $sql);

if ($query) {
    $sql1 = "INSERT INTO handling (H_date, H_R_id_fk, H_V_id_fk, H_D_id_fk) VALUES ('$date','$R_id','$V_id','$D_id')";
    $query1 = mysqli_query($con, $sql1);
    if ($query1) {
        $sql2 = "SELECT R_F_id_fk, R_food_count FROM request WHERE R_id = '$R_id'";
        $query2 = mysqli_query($con, $sql2);

        $f_id = '';
        $f_count = 0;

        while ($row = mysqli_fetch_assoc($query2)) {
            $f_id = $row['R_F_id_fk'];
            $f_count = $row['R_food_count'];
        }

        $sql3 = "UPDATE food SET F_count = F_count - $f_count WHERE F_id = $f_id";
        $query3 = mysqli_query($con, $sql3);
        if ($query3) {
            echo json_encode("Success");
        }
    }
} else {
    echo json_encode("Error");
}
?>