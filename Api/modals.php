<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];



function register_modals($conn){
    extract($_POST);
    $data = array();
    $query = "INSERT INTO modal(modal_name)
     values('$modal_name')";

    $result = $conn->query($query);


    if($result){

       
            $data = array("status" => true, "data" => "successfully Registered 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_modals($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT * from modal";
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

function get_modals($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT *FROM modal where modal_id= '$modal_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_modals($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE modal set modal_name = '$modal_name' WHERE modal_id = '$modal_id'";
     

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function Delete_modals($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM modal where modal_id= '$modal_id'";
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