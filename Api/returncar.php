
<?php

header("content-type: application/json");
include '..//config/conn.php';
// $action = $_POST['action'];


function register_returncar($conn){
    extract($_POST);
    $data = array();
    
    $query = "call return_car_insert('$rent_id','$returncar', '$quantity', '$rtquantity', '$return_date')";

    $result = $conn->query($query);


    if($result){

        $row= $result->fetch_assoc();
 
        if($row['msg']=='Deny'){
         $data = array("status" => false, "data" => "rt_quantity is not greatertahan total quantity");
 
        }
 
        else if($row['msg']=='Registered'){
         $data = array("status" => true, "data" => "Regestered successfully😂😊😒😎");

     }else{
         $data = array("status" => false, "data"=> $conn->error);
              
     }
    }
 

    echo json_encode($data);
}

function read_all_Customar($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT r.rent_id, concat(c.fristname, ' ',c.lastname) AS Customers_name FROM rent r JOIN customer c ON r.customer_id=c.customer_id WHERE action='paid'";
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


function read_all_retur_ncar($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT re.returncar_id,concat(cu.fristname,' ',cu.lastname) AS customer_name,c.car_name,re.quantity,re.rt_quantity,re.return_date FROM returncar re JOIN car c ON re.car_id=c.car_id JOIN rent r ON re.rent_id=r.rent_id JOIN customer cu ON r.customer_id=cu.customer_id";
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


function read_all_returncar($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "call read_customer_rent_car('$rent_id')";
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



function get_returncar_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT *FROM returncar where returncar_id= '$returncar_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function update_returncar($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE returncar set customer_id = '$Customar_id', car_id = '$car_id', quantity = '$quantity', return_date = '$return_date' WHERE returncar_id = '$returncar_id'";
     

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_returncar($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM returncar where returncar_id= '$returncar_id'";
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