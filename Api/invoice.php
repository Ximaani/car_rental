<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_invoice($conn){
    extract($_POST);
    $data = array();
    $new_id= generate2($conn);

    $query = "insert into invoice(invoice_id, customer_id, car_id,rental_price,taken_date, return_date,total_amount)
    values('$new_id','$customers_id','$cars_id','$rental_price','$taken_date','$return_date','$total_amount')";

    $result = $conn->query($query);


    if($result){

      //  $row= $result->fetch_assoc();

            $data = array("status" => true, "data" => "Registered succesfully 😂😊😒😎");
        


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function read_all_invoice($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT i.invoice_id,concat(cu.fristname, ' ', cu.lastname) as customer_name, i.car_id as car_name, ca.rental_price, r.taken_date,r.return_date,i.total_amount, i.date from invoice i JOIN rent  r on i.customer_id=r.customer_id JOIN car ca on r.car_id=ca.car_id JOIN customer cu on i.customer_id=cu.customer_id";
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



function read_rent_price($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
    $query = "call read_all_rent_per_day('$customer_id')";

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

function read_all_customers($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT c.customer_id,concat(c.fristname, ' ', c.lastname) as customer_name from rent r JOIN customer c on r.customer_id=c.customer_id";
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




function generate2($conn){
    $new_id= '';
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM `invoice` order by invoice.invoice_id DESC limit 1";
    $result = $conn->query($query);


    if($result){
        $num_rows= $result->num_rows;

        if($num_rows > 0){
            $row = $result->fetch_assoc();

            $new_id = ++$row['invoice_id'];

        }else{
              
            $new_id= "INV001";
        }
       
        


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

  return $new_id;
}



if(isset($_POST['action'])){
    $action = $_POST['action'];
    $action($conn);
}else{
    echo json_encode(array("status" => false, "data"=> "Action Required....."));
}


?>