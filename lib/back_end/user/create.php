<?php
include '../connection.php';

if (!$con) {
    print "connection lost";
}

$name = trim($_POST['name']);
$address = trim($_POST['address']);
$contact = trim($_POST['contact']);
$email = trim($_POST['email']);
$newPassword = trim($_POST['newPassword']);
$password = trim($_POST['password']);
$userType = trim($_POST['userType']);

$field = 0;

if (!$name || $name == 'null') {
    $field++;
}else if (!$address || $address == 'null') {
    $field++;
}else if (!$contact || $contact == 'null') {
    $field++;
}else if (!$email || $email == 'null') {
    $field++;
}else if (!$password || $password == 'null') {
    $field++;
}else if (!$newPassword || $newPassword == 'null') {
    $field++;
}else if (!$userType || $userType == 'user') {
    $field++;
}

if ($field == 0) {
    if ($newPassword == $password) {
        switch ($userType) {
            case 'Donor':
                $sql = "INSERT INTO donar (Dr_name, Dr_address, Dr_contact, Dr_email, Dr_password) VALUES 
                ('$name','$address','$contact','$email','$password')";
                break;
        
            case 'Beneficiary':
                $sql = "INSERT INTO beneficiary (B_name, B_address, B_contact, B_email, B_password) VALUES 
                ('$name','$address','$contact','$email','$password')";
                break;
        }
        
        $query = mysqli_query($con, $sql);
        
        if ($query) {
            echo json_encode("Success");
        }
        else {
            echo json_encode("Error");
        }
    }
    else {
        echo json_encode("No match");
    }
}else {
    echo json_encode("not complete");
}

?>