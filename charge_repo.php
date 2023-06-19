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
                <h5>Charge Report Table</h5>
                <span class="d-block m-t-5"> <code></code>   </span>
                <form id="charge_repo_form">

                <div class="row">
                    <!-- <div class="col-sm-4">
                    <select name="type" id="type" class="form-control">
                            <option value="0">All</option>
                            <option value="custom">custom</option>
                        </select>
                    </div> -->

                  

                    <div class="col-sm-5">
                        <input type="text" name="month_name" id="month_name" class="form-control">
                    </div>


                    <div class="col-sm-4">
                    <button type="submit" id="Adddnew" class="btn btn-info m-3">Add new transaction</button>
                    </div>
                </div>
                </form>

                <div class="row">
                    <div class="table-responsive" id="print_area">
                    <img width="30%";  height="130px" src="money.jpg" class="mb-3">

                    <table class="table" id="charge_repo_table">
                              <thead>
                              
                              </thead>
                              <tbody>
                                       
  
                              </tbody>

                    </table>

                    </div>
                    <div class="col-sm-4">
                    <button id="printstatement" class="btn btn-success ml-1"><i class="fa fa-print"></i>print</button>
                    <button id="exportstatement" class="btn btn-info mr-4"><i class="fa fa-file"></i>Export</button>
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
  