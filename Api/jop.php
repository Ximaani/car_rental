<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];



function register_jops($conn){
    extract($_POST);
    $data = array();
    $query = "INSERT INTO jop_title(position,salary) values('$position','$salary')";

    $result = $conn->query($query);


    if($result){

       
            $data = array("status" => true, "data" => "successfully Registered 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_jops($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT * from jop_title";
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

function get_jops($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT *FROM jop_title where title_id= '$title_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_jops($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE jop_title set position = '$position',salary = '$salary' WHERE title_id = '$title_id'";
     

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function Delete_jops($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM jop_title where title_id= '$title_id'";
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