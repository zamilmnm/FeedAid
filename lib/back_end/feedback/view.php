<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$sql = "SELECT F.Fe_id AS ID, F.Fe_summary AS summary, F.Fe_date as date, B.B_name AS beneficiary FROM feedback F 
        INNER JOIN handling H ON H.H_id = F.Fe_H_id_fk INNER JOIN request R ON R.R_id = H.H_R_id_fk INNER JOIN beneficiary B 
        ON B.B_id = R.R_B_id_fk";

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
