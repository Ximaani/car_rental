<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_payment($conn){
    extract($_POST);
    $data = array();
    $query = "insert into payment(rent_id, amount,payment_method_id,account_id)
    values('$rentt_id','$amount','$payment_method_id','$account_id')";
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

  // $query ="SELECT p.payment_id,concat(c.fristname, ' ', c.lastname) as customer_name, p.amount as Total_amount, pm.method_name, ac.bank_name FROM payment p JOIN customer c on p.customer_id=c.customer_id JOIN payment_method pm on p.payment_method_id=pm.payment_method_id
  // JOIN account ac on p.account_id=ac.account_id";

   $query ="SELECT p.payment_id,concat(c.fristname,' ',c.lastname) as 'Customer najme',p.amount,m.method_name,a.bank_name FROM payment p JOIN rent r on p.rent_id=r.rent_id
   JOIN customer c on r.customer_id=c.customer_id
   JOIN payment_method m on p.payment_method_id=m.payment_method_id
   JOIN account a on p.account_id=a.account_id";

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

function read_all_top_payment($conn){
    $data = array();
    $array_data = array();

  // $query ="SELECT p.payment_id,concat(c.fristname, ' ', c.lastname) as customer_name, p.amount as Total_amount, pm.method_name, ac.bank_name FROM payment p JOIN customer c on p.customer_id=c.customer_id JOIN payment_method pm on p.payment_method_id=pm.payment_method_id
  // JOIN account ac on p.account_id=ac.account_id";

   $query ="SELECT rent_id,amount from payment limit 3";

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

// function read_all__payment($conn){
//     $data = array();
//     $array_data = array();

//   // $query ="SELECT p.payment_id,concat(c.fristname, ' ', c.lastname) as customer_name, p.amount as Total_amount, pm.method_name, ac.bank_name FROM payment p JOIN customer c on p.customer_id=c.customer_id JOIN payment_method pm on p.payment_method_id=pm.payment_method_id
//   // JOIN account ac on p.account_id=ac.account_id";

//    $query ="SELECT concat(cu.fristname,' ',cu.lastname) as customer_name,p.amount from payment p JOIN customer cu ON p.customer_id=cu.customer_id JOIN account a ON p.account_id=a.account_id  order by amount DESC limit 3";

//     $result = $conn->query($query);


//     if($result){
//         while($row = $result->fetch_assoc()){
//             $array_data[] = $row;
//         }
//         $data = array("status" => true, "data" => $array_data);


//     }else{
//         $data = array("status" => false, "data"=> $conn->error);
             
//     }

//     echo json_encode($data);
// }


function fill_amount($conn){
    extract($_POST);
    $data = array();
    $array_data = array();

    $query = "call read_rent_price('$rent_id')";

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
   $query ="SELECT r.rent_id,concat(c.fristname,c.lastname) as 'customer_name' FROM invoice i JOIN  rent r ON i.rent_id=r.rent_id
   JOIN customer c ON r.customer_id=c.customer_id WHERE r.action='Invoiced'";
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