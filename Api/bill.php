
<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];


function register_bill($conn){
    extract($_POST);
    $data = array();
    $query = "INSERT INTO bill (emp_id, amount, user)
     values('$empol_id', '$amount', '$users')";

    $result = $conn->query($query);


    if($result){

       
            $data = array("status" => true, "data" => "Transaction success");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_employeeee($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT Distinct e.emp_id,concat(e.emp_first_name, ' ', e.emp_last_name) as employename FROM charge ch JOIN employee e on ch.emp_id=e.emp_id
   WHERE ch.active=0";
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


function fill_amount_bill($conn){
    extract($_POST);
    $data = array();
    $array_data = array();

    $query = "call amount_pl('$empol_id')";

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


function read_all_bill($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM bill";
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