<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}
$enDate = date('Y-m-d');
$stDate = date('Y-m-d', strtotime($enDate . ' - 11 months'));

$sql = "SELECT EXTRACT(YEAR FROM R_date) AS year, MONTH(R_date) AS month, COUNT(*) AS requests FROM request 
        WHERE R_date BETWEEN '$stDate' AND '$enDate' GROUP BY EXTRACT(YEAR_MONTH FROM R_date) ORDER BY year";

$query = mysqli_query($con, $sql);

$response = array();
while ($row = mysqli_fetch_assoc($query)) {
    array_push($response, ['date' => [$row['month'].'/'.date('y', strtotime($row['year']))], 'count' => [intval($row['requests'])]]);
}

if ($query) {
    echo json_encode($response);
}else {
    echo json_encode("Error");
}

?>