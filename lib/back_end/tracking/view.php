<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$r_id = trim($_POST['rID']);
$b_id = trim($_POST['beneficiary']);

$sql = "SELECT R.R_id AS RID, R.R_status AS rStatus, H.H_id AS HID, D.Dr_name AS donar, V.V_name AS volunteer FROM request R 
        INNER JOIN handling H ON H.H_R_id_fk = R.R_id INNER JOIN donar D ON D.Dr_id = H.H_D_id_fk 
        INNER JOIN volunteer V ON V.V_id = H.H_V_id_fk WHERE R_B_id_fk = '$b_id' AND R_id = '$r_id'";

$query = mysqli_query($con, $sql);

$count = mysqli_affected_rows($con);


if ($count != 0) {
    $response = array();
    while ($row = mysqli_fetch_assoc($query)) {
        array_push($response, $row);
    }

    if ($query) {
        echo json_encode($response);
    } else {
        echo json_encode("Error");
    }
} else {
    $sql1 = "SELECT R.R_id AS RID, R_status AS rStatus FROM request R INNER JOIN beneficiary B ON B.B_id = R.R_B_id_fk 
    WHERE R.R_id = '$r_id' AND B.B_id = '$b_id'";

    $query1 = mysqli_query($con, $sql1);

    $response = array();
    while ($row = mysqli_fetch_assoc($query1)) {
        array_push($response, ['RID' => $row['RID'], 'rStatus' => $row['rStatus'], 'HID' => '0', 'donar' => 'donar', 'volunteer' => 'volunteer']);
    }

    if ($query1) {
        echo json_encode($response);
    } else {
        echo json_encode("Error");
    }
}
?>