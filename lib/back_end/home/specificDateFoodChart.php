<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}
$enDate = $_POST['enDate'];
$stDate = $_POST['stDate'];

$sql = "SELECT EXTRACT(YEAR FROM D_date) AS year, MONTH(D_date) AS month, SUM(D_foodCount) AS foods FROM donation 
        WHERE D_date BETWEEN '$stDate' AND '$enDate' GROUP BY EXTRACT(YEAR_MONTH FROM D_date) ORDER BY year";

$query = mysqli_query($con, $sql);

$response = array();
while ($row = mysqli_fetch_assoc($query)) {
    array_push($response, ['date' => [$row['month'].'/'.date('y', strtotime($row['year']))], 'count' => [intval($row['foods'])]]);
}

if ($query) {
    echo json_encode($response);
}else {
    echo json_encode("Error");
}

?>