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
        <button type="button" class="btn btn-success  m-2" data-bs-toggle="modal" data-bs-target="#invoice_modal">
       invoice
         </button>
         </div>
        <table class="table" id="invoiceTable">

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

            
  <div class="modal fade" id="invoice_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">invoice</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="invoiceform">
        <input type="hidden" name="update_id" id="update_id">
        <div class="row">
           
        


      
        <div class="col-sm-6">
                <div class="form-group">
                <label for="">customer_name</label>
                <select name="customers_id" id="customers_id" class="form-control customer_name">
                <option value="o">select customer_name</option>
                </select>
                </div>

            </div>

            <div class="col-sm-6">
                <div class="form-group">
                <label for="">car_name</label>
                <input type="text" name="cars_id" id="cars_id" class="form-control" readonly>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">rental_price</label>
                <input type="number" class="form-control" name="rental_price" id="rental_price" readonly>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">taken_date</label>
                <input type="text" class="form-control" name="taken_date" id="taken_date" readonly>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">return_date</label>
                <input type="text" class="form-control" name="return_date" id="return_date" readonly>
                </div>

            </div>

            <div class="col-sm-6 mt-3">
                <div class="form-group">
                <label for="">total_amount</label>
                <input type="number" class="form-control" name="total_amount" id="total_amount" readonly>
                </div>

            </div>

           

            <!-- <div class="col-sm-12">
                <div class="form-group">
                <label for="">invoice_price</label>
                <input type="text" name="invoice_price" id="invoice_price" class="form-control" required>
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