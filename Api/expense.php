<?php
session_start();
header("Content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];
function register_expense($conn){


    extract($_POST);

    $data = array();

    // buliding the query and cAll the stored procedures
    $query = "CALL register_expense_sp('','$amount','$type','$description','$users_id', '$Account_id')";

    // Excecution

    $result = $conn->query($query);

    // chck if there is an error or not
    if ($result) {

        $row = $result->fetch_assoc();

        if ($row['Message'] == 'Deny') {
            $data = array("status" => false, "data" => "Insuficient Balance😊😊😎");
        } elseif ($row['Message'] == 'Registered') {
            $data = array("status" => true, "data" => "Transaction Successfully");
        }
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}


function get_user_transaction($conn)
{

    $data = array();
    $array_data = array();
    $query = "SELECT e.id,e.amount,e.type,e.description,e.user_id,a.bank_name,e.date FROM expense e JOIN account a ON a.account_id=e.Account_id";
    $result = $conn->query($query);

    if ($result) {

        while ($row = $result->fetch_assoc()) {
            $array_data[] = $row;
        }

        $data = array("status" => true, "data" => $array_data);
    } else {

        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

if (isset($_POST['action'])) {
    $action = $_POST['action'];
    $action($conn);
} else {
    echo json_encode(array("status" => false, "data" => "Action Required..."));
}
