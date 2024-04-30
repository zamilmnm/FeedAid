<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$sql = "SELECT R.R_id AS ID, R.R_reuiredDate AS rDate, R.R_food_count AS count, 
        R.R_reuiredDate AS date, f.F_name AS food, B.B_name AS beneficiary FROM request R 
        INNER JOIN beneficiary B ON R.R_B_id_fk = B.B_id INNER JOIN food F ON R.R_F_id_fk = F.F_id 
        WHERE R_status = 'Active'";

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
