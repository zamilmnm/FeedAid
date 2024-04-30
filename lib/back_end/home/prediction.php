<?php
include '../connection.php';

if (!$con) {
    print("connection lost");
}

$today = date('Y-m-d');
$Date = date('Ym', strtotime($today . ' - 1 months'));
$stDate = date('Ym', strtotime($Date . ' - 5 months'));

$sql = "SELECT lpad(COUNT(R_id),2,'0') AS requests from request WHERE EXTRACT(YEAR_MONTH FROM R_date) = '$Date'";
$query = mysqli_query($con, $sql);

$response = array();

if ($query) {
    while ($row = mysqli_fetch_assoc($query)) {
        $last_request = $row['requests'];
    }

    $sql1 = "SELECT lpad(COUNT(R_id),2,'0') AS requests from request WHERE EXTRACT(YEAR_MONTH FROM R_date) BETWEEN '$stDate' AND '$Date'";
    $query1 = mysqli_query($con, $sql1);

    if ($query1) {
        while ($row = mysqli_fetch_assoc($query1)) {
            $past_request = $row['requests'];
        }
        $ave_request = sprintf('%02d', round($past_request / 5));
        $exp_request = sprintf('%02d', round(($ave_request + $last_request) / 2));

        if ($ave_request == $exp_request) {
            $req_result = "$exp_request";
        } elseif ($ave_request > $last_request) {
            $req_result = "$exp_request to $ave_request";
        } else {
            $req_result = "$ave_request to $exp_request";
        }
    }

    $sql2 = "SELECT lpad(SUM(D_foodCount),2,'0') AS foods from donation WHERE EXTRACT(YEAR_MONTH FROM D_date) = '$Date'";
    $query2 = mysqli_query($con, $sql2);

    if ($query2) {
        while ($row = mysqli_fetch_assoc($query2)) {
            $last_foods = $row['foods'];
        }

        $sql3 = "SELECT lpad(SUM(D_foodCount),2,'0') AS foods from donation WHERE EXTRACT(YEAR_MONTH FROM D_date) BETWEEN '$stDate' AND '$Date'";
        $query3 = mysqli_query($con, $sql3);

        if ($query3) {
            while ($row = mysqli_fetch_assoc($query3)) {
                $past_foods = $row['foods'];
            }

            $ave_foods = sprintf('%02d', round($past_foods / 5));
            $exp_foods = sprintf('%02d', round(($ave_foods + $last_foods) / 2));

            if ($ave_foods == $exp_foods) {
                $req_foods = $exp_request;
            } else if ($ave_foods > $last_foods) {
                $req_foods = "$exp_request to $ave_foods";
            } else {
                $req_foods = "$ave_foods to $exp_foods";
            }

            $sql4 = "SELECT F.F_name AS food, lpad(SUM(R.R_food_count),2,'0') AS fCount from request R 
                    INNER JOIN food F ON F.F_id = R.R_F_id_fk WHERE EXTRACT(YEAR_MONTH FROM R_date) BETWEEN '$stDate' AND '$Date' 
                    GROUP BY R.R_F_id_fk";
            $query4 = mysqli_query($con, $sql4);

            $inc_food = array();
            $dec_food = array();

            if ($query4) {
                while ($rowR = mysqli_fetch_assoc($query4)) {
                    $r_food = $rowR['food'];
                    $r_count = round($rowR['fCount'] / 5);

                    $sql5 = "SELECT F.F_name AS food, lpad(SUM(D.D_foodCount),2,'0') AS fCount from donation D 
                    INNER JOIN food F ON F.F_id = D.D_F_id_fk WHERE EXTRACT(YEAR_MONTH FROM D.D_date) = '$Date' AND F.F_name = '$r_food'";
                    $query5 = mysqli_query($con, $sql5);

                    if ($query5) {
                        while ($rowD = mysqli_fetch_assoc($query5)) {
                            $d_food = $rowD['food'];
                            $d_count = $rowD['fCount'];

                            if ($d_count != 0) {
                                if ($r_count + 5 > $d_count) {
                                    array_push($inc_food, $r_food);
                                    if (!in_array($r_food, $inc_food)) {
                                        array_push($inc_food, $r_food);
                                    }
                                } else {
                                    array_push($dec_food, $r_food);
                                    if (!in_array($r_food, $dec_food)) {
                                        array_push($dec_food, $r_food);
                                    }
                                }
                            } elseif ($r_count > 0) {
                                $sql6 = "SELECT * from food WHERE F_name = '$r_food'";
                                $query6 = mysqli_query($con, $sql6);

                                if ($query6) {
                                    if (!in_array($r_food, $inc_food)) {
                                        array_push($inc_food, $r_food);
                                    }
                                } else {
                                    echo json_encode("Error");
                                }
                            }
                        }
                    }
                }
            }

            $sql7 = "SELECT F.F_name AS food, lpad(SUM(D.D_foodCount),2,'0') AS fCount from donation D 
            INNER JOIN food F ON F.F_id = D.D_F_id_fk WHERE EXTRACT(YEAR_MONTH FROM D.D_date) = '$Date' GROUP BY D.D_F_id_fk";
            $query7 = mysqli_query($con, $sql7);

            if ($query7) {
                while ($rowDD = mysqli_fetch_assoc($query7)) {
                    $dd_food = $rowDD['food'];
                    $dd_count = $rowDD['fCount'];

                    $sql8 = "SELECT F.F_name AS food, lpad(SUM(R.R_food_count),2,'0') AS fCount from request R 
                    INNER JOIN food F ON F.F_id = R.R_F_id_fk WHERE EXTRACT(YEAR_MONTH FROM R_date) BETWEEN '$stDate' AND '$Date' 
                    AND F.F_name = '$dd_food'";
                    $query8 = mysqli_query($con, $sql8);

                    if ($query8) {
                        while ($rowRR = mysqli_fetch_assoc($query8)) {
                            $rr_food = $rowRR['food'];
                            $rr_count = round($rowRR['fCount'] / 5);

                            if ($rr_count != 0) {
                                if ($rr_count + 5 > $dd_count) {
                                    if (!in_array($dd_food, $inc_food)) {
                                        array_push($inc_food, $dd_food);
                                    }
                                } else {
                                    if (!in_array($dd_food, $dec_food)) {
                                        array_push($dec_food, $dd_food);
                                    }
                                }
                            } else {
                                $sql9 = "SELECT * from food WHERE F_name = '$dd_food'";
                                $query9 = mysqli_query($con, $sql9);

                                if ($query9) {
                                    if (!in_array($dd_food, $dec_food)) {
                                        array_push($dec_food, $dd_food);
                                    }
                                } else {
                                    echo json_encode("Error");
                                }
                            }
                        }
                    }
                }
            }

            array_push($response, ['request' => $req_result, 'food' => $req_foods, 'increse' => $inc_food, 'decrese' => $dec_food]);

            echo json_encode($response);
        } else {
            echo json_encode("Error");
        }
    }
}
?>