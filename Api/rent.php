<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_rent($conn){
    extract($_POST);
    $data = array();
    $query = "call rent_cars('$customer_id','$car_id','$quantity','$taken_date','$return_date')";

    // $query = "insert into rent (customer_id, car_id,quantity,taken_date, return_date)
    // values('$customer_id','$car_id','$quantity','$taken_date','$return_date')";

    $result = $conn->query($query);


    if($result){

    
        $row= $result->fetch_assoc();

        if($row['massage']=='Deny'){
         $data = array("status" => false, "data" => "unavailible");
 
        }
 
        else if($row['massage']=='Registered'){
         $data = array("status" => true, "data" => "the rent has been registered done");
 
        } 
 

    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function read_all_rent($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT concat(c.fristname, ' ', c.lastname) as customer_name, ca.car_name,ca.rental_price as rental_per_day,r.taken_date,r.return_date,r.action from rent r JOIN customer c on r.customer_id=c.customer_id JOIN car ca on r.car_id=ca.car_id ";
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

function read_all_car($conn){
    $data = array();
    $array_data = array();
   $query ="select * from car";
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


function get_rent_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM rent where rent_id= '$rent_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_rent($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE rent set customer_id = '$customer_id', car_id = '$car_id', quantity = '$quantity',taken_date = '$taken_date', return_date = '$return_date'  WHERE rent_id= '$rent_id'";

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_rent($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM rent where rent_id= '$rent_id'";
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