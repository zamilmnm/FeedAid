<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$sql = "SELECT B.B_name AS beneficiary, F.F_name AS food, R.R_food_count AS fCount, r.R_reuiredDate AS date FROM notification N 
        INNER JOIN request R ON N.N_R_id_fk = R.R_id INNER JOIN beneficiary B ON R.R_B_id_fk = B.B_id 
        INNER JOIN food F ON R.R_F_id_fk = F.F_id WHERE N_status = 'not seen'";

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