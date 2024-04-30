<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$food = trim($_POST['food']);
$count = trim($_POST['count']);
$donor = trim($_POST['donor']);
$date = date('Y-m-d');

$field = 0;

if (!$food || $food == 'null') {
    $field++;
} else if (!$count || $count == 'null' || $count == '0') {
    $field++;
} else if (!$donor || $donor == 'null') {
    $field++;
}

if ($field == 0) {
    $sql = "INSERT INTO donation (D_F_id_fk, D_foodCount, D_Dr_id_fk, D_date) 
        VALUES ('$food','$count','$donor','$date')";

    $query = mysqli_query($con, $sql);

    if ($query) {
        $sql1 = "UPDATE food SET F_count = F_count + $count WHERE F_id = $food";

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