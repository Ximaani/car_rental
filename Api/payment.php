<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_payment($conn){
    extract($_POST);
    $data = array();
    $query = "insert into payment(customer_id, amount,payment_method_id,account_id)
    values('$Customer_id','$amount','$payment_method_id','$account_id')";
    $result = $conn->query($query);

    if($result){

      //  $row= $result->fetch_assoc();

            $data = array("status" => true, "data" => "Registered succesfully 😂😊😒😎");
        


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function read_all_payment($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT p.payment_id,concat(c.fristname, ' ', c.lastname) as customer_name, p.amount as Total_amount, pm.method_name, ac.bank_name FROM payment p JOIN customer c on p.customer_id=c.customer_id JOIN payment_method pm on p.payment_method_id=pm.payment_method_id
   JOIN account ac on p.account_id=ac.account_id";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function fill_amount($conn){
    extract($_POST);
    $data = array();
    $array_data = array();

    $query = "call read_rent_price('$customer_id')";

    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_payment_method($conn){
    $data = array();
    $array_data = array();
   $query ="select payment_method_id,method_name from payment_method";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_account($conn){
    $data = array();
    $array_data = array();
   $query ="select account_id,bank_name from account";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_customer_name($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT c.customer_id, concat(c.fristname, ' ', c.lastname) as customer_name from invoice i JOIN customer c on i.customer_id=c.customer_id";
    $result = $conn->query($query);


    if($result){
        while($row = $result->fetch_assoc()){
            $array_data[] = $row;
        }
        $data = array("status" => true, "data" => $array_data);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

if(isset($_POST['action'])){
    $action = $_POST['action'];
    $action($conn);
}else{
    echo json_encode(array("status" => false, "data"=> "Action Required....."));
}

?>