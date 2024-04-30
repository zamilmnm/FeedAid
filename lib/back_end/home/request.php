<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$sql = "SELECT R.R_id AS ID, R.R_reuiredDate AS date, lpad(R.R_food_count,2,'0') AS rCount, F.F_name, F.F_image FROM request R 
        INNER JOIN food F ON F.F_id = R.R_F_id_fk WHERE R.R_status != 'Delivered'";

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