<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];


function get_total_customer($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "select count(customer_id) as customer  from customer";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_total_balance($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "select sum(balance) as balances from account";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_all_employee($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "select count(emp_id) as employee  from employee";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_all_users($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "select count(id) as users  from users";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_all_income($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "SELECT SUM(amount) AS Income FROM expense WHERE type='Income'";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_all_expense($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "SELECT SUM(amount) AS Expense FROM expense WHERE type='Expense'";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_all_invoice($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "SELECT SUM(amount) AS Expense FROM expense WHERE type='Expense'";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}

function get_all_sum_pending($conn)
{
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "SELECT SUM(r.quantity) as total  FROM rent r JOIN car c ON r.car_id=c.car_id WHERE action='pending'";
    $result = $conn->query($query);


    if ($result) {
        $row = $result->fetch_assoc();

        $data = array("status" => true, "data" => $row);
    } else {
        $data = array("status" => false, "data" => $conn->error);
    }

    echo json_encode($data);
}






if (isset($_POST['action'])) {
    $action = $_POST['action'];
    $action($conn);
} else {
    echo json_encode(array("status" => false, "data" => "Action Required....."));
}



