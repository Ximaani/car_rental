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
   
  
  

  <div class="cl-xl-12">
        <div class="card">
            <div class="card-header">
                <h5>booking Table</h5>
                <span class="d-block m-t-5"> <code></code>   </span>
                <form id="bookinggform">

                <div class="row">
                    <div class="col-sm-4">
                    <select name="type" id="type" class="form-control">
                            <option value="0">All</option>
                            <option value="custom">custom</option>
                        </select>
                    </div>

                  

                    <div class="col-sm-5">
                        <input type="text" name="booking_id" id="booking_id" class="form-control">
                    </div>


                    <div class="col-sm-4">
                    <button type="submit" id="Adddnew" class="btn btn-info m-3">Add new transaction</button>
                    </div>
                </div>
                </form>

                <div class="row">
                    <div class="table-responsive" id="printt_Area">
                    <img width="30%";  height="130px" src="inter.png" class="mb-3">

                    <table class="table" id="bokingTable">
                              <thead>
                              
                              </thead>
                              <tbody>
                                       
  
                              </tbody>

                    </table>

                    </div>
                    <div class="col-sm-4">
                    <button id="printt_statement" class="btn btn-success ml-1"><i class="fa fa-print"></i>print</button>
                    <button id="exportt_statement" class="btn btn-info mr-4"><i class="fa fa-file"></i>Export</button>
                    </div>
                </div>
</div>
               
        </div>
     </div>
   <!-- End Page Title -->

   

  </main>
  
  
  <!-- End #main -->

 

 



<br>
<br>
<br>
<br>
<br>

  <?php
include 'include/footer.php';

?>