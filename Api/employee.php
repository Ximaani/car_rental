
<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];


function register_employee($conn){
    extract($_POST);
    $data = array();
    $query = "INSERT INTO employee (emp_first_name, emp_last_name, phone, address,title_id,branch_id)
     values('$emp_first_name', '$emp_last_name', '$phone', '$address','$title_id', '$branch_id')";

    $result = $conn->query($query);


    if($result){

       
            $data = array("status" => true, "data" => "successfully Registered 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function read_all_branch($conn){
    $data = array();
    $array_data = array();
   $query ="select * from branch";
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

function read_all_jop_title($conn){
    $data = array();
    $array_data = array();
   $query ="select * from jop_title";
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

function read_all_employe($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT e.emp_id,e.emp_first_name as first_name,e.emp_last_name as last_name,e.phone,e.address,j.position, b.branch_name,j.salary from employee e JOIN jop_title j on e.title_id=j.title_id JOIN branch b on e.branch_id=b.branch_id order by emp_id";
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



function get_employee_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT *FROM employee where emp_id= '$emp_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function update_employee($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE employee set emp_first_name = '$emp_first_name', emp_last_name = '$emp_last_name', phone = '$phone', address = '$address', title_id = '$title_id', branch_id = '$branch_id' WHERE emp_id = '$emp_id'";
     

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_employee($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM employee where emp_id= '$emp_id'";
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