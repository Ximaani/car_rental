<?php

$conn = new mysqli("localhost", "root", "", "rentaldb");

if($conn->connect_error){
    echo $conn->error;
}