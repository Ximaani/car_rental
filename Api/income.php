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




if (isset($_POST['action'])) {
    $action = $_POST['action'];
    $action($conn);
} else {
    echo json_encode(array("status" => false, "data" => "Action Required....."));
}


function read_top($conn)
{
    $data = array();
    $array_data = array();
    $query = "SELECT e.evaluation_id as ID,concat(s.fristname, ' ', s.lastname) as student_name, concat(i.fristname, ' ', i.lastname) as customer_name,e.Course,r.rating_name,r.points,e.EvaluationDate as Ev_date,e.Comments from evaluation e JOIN employee s on e.student_id=s.student_id JOIN customer i on e.customer_id=i.customer_id join rating r on e.rating_id=r.rating_id order by r.points desc limit 5; 
   ";
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
