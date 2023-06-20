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
        <button type="button" class="btn btn-success  m-2" data-bs-toggle="modal" data-bs-target="#rent_modal">
       rent
         </button>
         </div>
        <table class="table" id="rentTable">

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

            
  <div class="modal fade" id="rent_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">rent</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="rentform">
        <input type="hidden" name="update_id" id="update_id">
        <div class="row">
           
        


      
        <div class="col-sm-12">
                <div class="form-group">
                <label for="">customer_id</label>
                <select name="customer_id" id="customer_id" class="form-control">
                
                </select>
                </div>

            </div>

            <div class="col-sm-12">
                <div class="form-group">
                <label for="">car_id</label>
                <select name="car_id" id="car_id" class="form-control">
                
                </select>
                </div>

            </div>

            <div class="col-sm-12 mt-3">
                <div class="form-group">
                <label for="">quantity</label>
                <input type="number" class="form-control" name="quantity" id="quantity">
                </div>

            </div>
            <div class="col-sm-12 mt-3">
                <div class="form-group">
                <label for="">taken_date</label>
                <input type="date" class="form-control" name="taken_date" id="taken_date">
                </div>

            </div>

            <div class="col-sm-12 mt-3">
                <div class="form-group">
                <label for="">return_date</label>
                <input type="date" class="form-control" name="return_date" id="return_date">
                </div>

            </div>

           

            <!-- <div class="col-sm-12">
                <div class="form-group">
                <label for="">rent_price</label>
                <input type="text" name="rent_price" id="rent_price" class="form-control" required>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="form-group">
                <label for="">penalty</label>
                <input type="text" name="penalty" id="penalty" class="form-control" required>
                </div>
            </div> -->

      


            <!-- <div class="col-sm-12 mt-3">
                <div class="form-group">
                <label for="">level</label>
               <input type="text" name="level_id" id="level_id" class="form-control mt-2" readonly>
                </div>

            </div> -->
         
         

             
      


            

           
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