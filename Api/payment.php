<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_payment($conn){
    extract($_POST);
    $data = array();
    $query = "insert into payment (customer_id, amount,payment_method_id, account_id)
    values('$customer_id','$amount','$payment_method_id','$account_id')";

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
   $query ="SELECT * FROM payment";
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
   $query ="SELECT c.customer_id, concat(c.fristname, ' ', c.lastname) as customer_name  from rent r JOIN customer c on r.customer_id=c.customer_id";
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


function get_payment_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM payment where payment_id= '$payment_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_payment($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE payment set customer_id = '$customer_id', amount = '$amount', payment_method_id = '$payment_method_id', account_id = '$account_id' WHERE payment_id= '$payment_id'";

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_payment($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM payment where payment_id= '$payment_id'";
    $result = $conn->query($query);


    if($result){
   
        
        $data = array("status" => true, "data" => "successfully Deleted😎");


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