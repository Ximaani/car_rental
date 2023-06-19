
<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];


function register_car($conn){
    extract($_POST);
    $data = array();
    $query = "INSERT INTO car (car_name, car_number, modal_id, transmission_id,type_fuel_id,rental_price,conditions_id,quantity)
     values('$car_names', '$car_number', '$modal_id', '$transmission_id','$type_fuel_id', '$rental_price', '$conditions', '$quantity')";

    $result = $conn->query($query);


    if($result){

       
            $data = array("status" => true, "data" => "successfully Registered 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_modal($conn){
    $data = array();
    $array_data = array();
   $query ="select * from modal";
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

function read_all_transmission($conn){
    $data = array();
    $array_data = array();
   $query ="select * from transmission";
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

function read_all_condition($conn){
    $data = array();
    $array_data = array();
   $query ="select * from conditions";
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
   $query ="SELECT c.car_name,c.car_number,m.modal_name,t.transmission_name as Trans_name,tf.fuel_name,c.rental_price as rent_per_day,co.conditions_name,c.quantity,c.data from car c join modal m on c.modal_id=m.modal_id JOIN transmission t on c.transmission_id=t.transmission_id JOIN typefuel tf on c.type_fuel_id=tf.type_fuel_id JOIN conditions co ON c.conditions_id=co.conditions_id";
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

function read_all_type_fuel($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM typefuel";
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



function get_car_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT *FROM car where car_id= '$car_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function update_car($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE car set car_names = '$car_names', car_number = '$car_number', modal_id = '$modal_id', transmission_id = '$transmission_id', type_fuel_id = '$type_fuel_id', rental_price = '$rental_price', conditions = '$conditions', quantity = '$quantity' WHERE car_id = '$car_id'";
     

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_car($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM car where car_id= '$car_id'";
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