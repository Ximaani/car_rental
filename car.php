<?php
session_start();
if (!isset($_SESSION['username'])) {
  header('Location:login.php');
  die();
}

?>



<?php
include 'include/header.php';


?>
  <!-- ======= Header ======= -->
<?php
include 'include/nav.php';
?>
<!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <?php

 include 'include/sidebar.php';

?>




<!-- End Sidebar-->

  <main id="main" class="main">
   
  
  <div class="pagetitle">
      <h1>Dashboard</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item active">Dashboard</li>
        </ol>
      </nav>
    </div>

    <div class="container">
  <div class="row justify-content-center mt-4">
    <div class="col-sm-12">
      <div class="card">
        <div class="text-end">
        <button type="button" class="btn btn-success  m-2" data-bs-toggle="modal" data-bs-target="#car_modal">
       Add cars
         </button>
         </div>
        <table class="table" id="carTable">

        <thead>
       

            
        </thead>

        <tbody>
   
        <!-- <tr>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          
        </tr>
        <tr>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          
        </tr>
        <tr>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          
        </tr>
        <tr>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          <td>welcome</td>
          
        </tr> -->
        
     
        </tbody>
        </table>
        </div>
       </div>
    </div>
  </div>
   <!-- End Page Title -->

   

  </main>
  
  
  <!-- End #main -->

            
  <div class="modal fade" id="car_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">cars</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="carform">
        <input type="hidden" name="update_id" id="update_id">
        <div class="row">
            
       

         

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">car_name</label>
                <input type="text"  name="car_name" id="car_name" class="form-control" required>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">car_number</label>
                <input type="text"  name="car_number" id="car_number" class="form-control" required>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <select name="modal_id" id="modal_id" class="form-control">
                <option value="0">select model</option>
                </select>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <select name="transmission_id" id="transmission_id" class="form-control">
                <option value="0">select transmission</option>
                </select>
                </div>

            </div>


            <div class="col-sm-6 mt-3">
                <div class="form-group mt-3">
                <select name="type_fuel_id" id="type_fuel_id" class="form-control">
                <option value="0">select type fuel</option>
                </select>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">rent_per_day</label>
                <input type="int"  name="rental_price" id="rental_price" class="form-control" required>
                </div>

            </div>


           
        </div>
       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit"  name="insert" class="btn btn-primary">Save Info</button>
      </div>
     </form>
    </div>
  </div>
</div>

 

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

  <?php
include 'include/footer.php';

?>