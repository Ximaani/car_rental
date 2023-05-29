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
        <button type="button" class="btn btn-success  m-2" data-bs-toggle="modal" data-bs-target="#charge_modal">
       charge
         </button>
         </div>
        <table class="table" id="chargeTable">

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

            
  <div class="modal fade" id="charge_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">charge</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="chargeform">
        <input type="hidden" name="update_id" id="update_id">
        <div class="row">
           
        


            <!-- <div class="col-sm-12">
                <div class="form-group">
                <label for="">Title_id</label>
                <select name="title_id" id="title_id" class="form-control">
                
                </select>
                </div>

            </div> -->

            <div class="col-sm-12">
                <div class="form-group">
                <label for="">Month</label>
                <select name="month" id="month" class="form-control">
                  <option value="select month">select month</option>
                </select>
                </div>

            </div>

            <div class="col-sm-12 mt-3">
              <div class="form-group">
                <label for="">Year</label>
                <select name="year" id="year">
                <?php
                  $start_year = 1900; // set the starting year
                  $current_year = date('Y'); // get the current year
                  for ($year = $current_year; $year >= $start_year; $year--) {
                    echo "<option value=\"$year\">$year</option>";
                  }
                ?>
                <!-- <input type="number" min="1900" max="2099" step="1" value="2023" name="year" id="year" class="form-control mt-2" require> -->
              </div>

              <div class="col-sm-12 mt-3">
              <div class="form-group">
                <label for="">description</label>
                <input type="text" name="desc" id="desc" class="form-control mt-2" require>
              </div>

            </div>

            <div class="col-sm-12">
                <div class="form-group">
                <label for="">User</label>
                <select name="user_idd" id="user_idd" class="form-control">
                  <option value="select user">select user</option>
                </select>
                </div>

            
            
            <div class="col-sm-12 mt-4">
                <div class="form-group">
                <label for="">account name</label>
                <select name="accountt_id" id="accountt_id" class="form-control">
                
                </select>
                </div>

            </div>
           


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