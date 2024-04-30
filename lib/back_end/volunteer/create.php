<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}
$v_name = trim($_POST['name']);
$v_address = trim($_POST['address']);
$v_contact = trim($_POST['contact']);
$v_email = trim($_POST['email']);

$field = 0;

if (!$v_name || $v_name == 'null') {
    $field++;
} else if (!$v_address || $v_address == 'null') {
    $field++;
} else if (!$v_contact || $v_contact == 'null') {
    $field++;
} else if (!$v_email || $v_email == 'null') {
    $field++;
}

if ($field == 0) {
    $sql = "INSERT INTO volunteer (V_name, V_address, V_contact, V_email) VALUES ('$v_name','$v_address','$v_contact','$v_email')";
    $query = mysqli_query($con, $sql);

    if ($query) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error");
    }
} else {
    echo json_encode("not complete");
}
?>