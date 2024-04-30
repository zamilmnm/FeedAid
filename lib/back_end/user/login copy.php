<?php
include '../connection.php';

if (!$con) {
    print('connection lost');
}

$email = trim($_POST['email']);
$password = trim($_POST['password']);
$userType = trim($_POST['userType']);

$user = '';
$u_id = '';
$u_name = '';
$U_email = '';
$U_password = '';

$field = 0;

if ($email == '' || $email == null) {
    $field++;
} else if ($password == '' || $password == null) {
    $field++;
} else if ($userType == '' || $userType == null) {
    $field++;
}

if ($field == 0) {
    switch ($userType) {
        case 'Donor':
            $u_id = 'Dr_id';
            $u_name = 'Dr_name';
            $user = 'donar';
            $U_email = 'Dr_email';
            $U_password = 'Dr_password';
            break;
        case 'Beneficiary':
            $u_id = 'B_id';
            $u_name = 'B_name';
            $user = 'beneficiary';
            $U_email = 'B_email';
            $U_password = 'B_password';
            break;
    }

    $sql = "SELECT * FROM $user WHERE $U_email = '$email'";
    $query = mysqli_query($con, $sql);

    if ($query) {
        $sql1 = "SELECT * FROM $user WHERE $U_email = '$email' AND $U_password = '$password'";
        $query1 = mysqli_query($con, $sql1);
        if ($query1) {
            $response = array();

            while ($row = mysqli_fetch_assoc($query1)) {
                array_push($response, ['uId' => $row[$u_id], 'username' => $row[$u_name], 'userType' => $userType]);
            }

            echo json_encode($response);
        } else {
            echo json_encode("Password Error");
        }
    } else {
        echo json_encode("Email Error");
    }
} else {
    echo json_encode("not complete");
}
?>