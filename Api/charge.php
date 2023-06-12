<?php
header("content-type: application/json");
include '../config/conn.php';
// $action = $_POST['action'];

function register_charge($conn){
    extract($_POST);
    $data = array();
    $query = "call get_charging('$month','$year','$desc','$accountt_id','$user_idd')";

    $result = $conn->query($query);


    if($result){

       $row= $result->fetch_assoc();

       if($row['msg']=='Deny'){
        $data = array("status" => false, "data" => "insuficance balance 😂😊😒😎");

       }

       else if($row['msg']=='Registered'){
        $data = array("status" => true, "data" => "Trunsaction successfully😂😊😒😎");

       } else if($row['msg']=='Not'){

        $data = array("status" => false, "data" => "lacagta bishaan horey ayaa loo dalacay");

       }


        


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}



function read_all_charge($conn){
    $data = array();
    $array_data = array();
   $query ="SELECT ch.charge_id,concat(e.emp_first_name,' ',e.emp_last_name) AS employee_name,j.position,ch.Amount,m.month_name,ch.year,ch.description,a.bank_name,ch.user_id as user,ch.active FROM charge ch JOIN employee e ON e.emp_id=ch.emp_id JOIN jop_title j ON j.title_id=ch.title_id JOIN month m ON m.month_id=ch.month_id JOIN account a ON a.account_id=ch.account_id order by ch.charge_id";
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





function read_all_user($conn){
    $data = array();
    $array_data = array();
   $query ="select id, username from users";
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

function read_all_month($conn){
    $data = array();
    $array_data = array();
   $query ="select month_id, month_name from month";
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
   $query ="select account_id, bank_name from account";
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


// function read_instructor_name($conn){
//     $data = array();
//     $array_data = array();
//    $query ="SELECT i.instructor_id,concat(i.fristname, ' ', i.lastname) as instructor_name from instructor i";
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


function get_charge_info($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="SELECT * FROM charge where charge_id= '$charge_id'";
    $result = $conn->query($query);


    if($result){
        $row = $result->fetch_assoc();
        
        $data = array("status" => true, "data" => $row);


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}


function update_charge($conn){
    extract($_POST);

    $data = array();

    $query = "UPDATE charge set title_id = '$title_id', amount = '$amount' WHERE charge_id= '$charge_id'";

    $result = $conn->query($query);


    if($result){

            $data = array("status" => true, "data" => "successfully updated 😂😊😒😎");


    }else{
        $data = array("status" => false, "data"=> $conn->error);
             
    }

    echo json_encode($data);
}

function Delete_charge($conn){
    extract($_POST);
    $data = array();
    $array_data = array();
   $query ="DELETE FROM charge where charge_id= '$charge_id'";
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