<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$u_id = trim($_POST['uId']);
$userType = trim($_POST['userType']);
$response = array();

switch ($userType) {
    case 'Donor':
        $sql = "SELECT * FROM donar WHERE Dr_id = $u_id";
        $query = mysqli_query($con, $sql);
        while ($row = mysqli_fetch_assoc($query)) {
            array_push($response, ['uID' => $row['Dr_id'], 'uName' => $row['Dr_name'], 'uAddress' => $row['Dr_address'], 'uContact' => $row['Dr_contact'], 'uEmail' => $row['Dr_email'], 'uPassword' => $row['Dr_password']]);
        }
        break;

    case 'Beneficiary':
        $sql = "SELECT * FROM beneficiary WHERE B_id = $u_id";
        $query = mysqli_query($con, $sql);
        while ($row = mysqli_fetch_assoc($query)) {
            array_push($response, ['uID' => $row['B_id'], 'uName' => $row['B_name'], 'uAddress' => $row['B_address'], 'uContact' => $row['B_contact'], 'uEmail' => $row['B_email'], 'uPassword' => $row['B_password']]);
        }
        break;
}

if ($query) {
    echo json_encode($response);
} else {
    echo json_encode("Error");
}
?>