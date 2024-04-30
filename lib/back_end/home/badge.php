<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$food = 0;
$donor = 0;
$recipient = 0;
$request = 0;

$sql = "SELECT lpad(SUM(F_count),2,'0') AS food from food";
$query = mysqli_query($con, $sql);

$response = array();

if ($query) {
    while ($row = mysqli_fetch_assoc($query)) {
        $food = $row['food'];
    }

    $sql1 = "SELECT lpad(COUNT(Dr_id),2,'0') AS donor from donar";
    $query1 = mysqli_query($con, $sql1);

    if ($query1) {
        while ($row = mysqli_fetch_assoc($query1)) {
            $donor = $row['donor'];
        }

        $sql2 = "SELECT lpad(COUNT(B_id),2,'0') AS beneficiary from beneficiary";
        $query2 = mysqli_query($con, $sql2);

        if ($query2) {
            while ($row = mysqli_fetch_assoc($query2)) {
                $recipient = $row['beneficiary'];
            }

            $sql3 = "SELECT lpad(COUNT(R_id),2,'0') AS request from request WHERE MONTH(R_date) = MONTH(CURRENT_TIMESTAMP)";
            $query3 = mysqli_query($con, $sql3);

            if ($query3) {
                while ($row = mysqli_fetch_assoc($query3)) {
                    $request = $row['request'];
                }

                array_push($response, ['food' => $food, 'donor' => $donor, 'recipient' => $recipient, 'request' => $request]);

                if ($query3) {
                    echo json_encode($response);
                } else {
                    echo json_encode("Error");
                }
            }
        }
    }
}
?>