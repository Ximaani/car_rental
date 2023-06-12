fillemployee();
load_bill();
fill_amount_bill();
btnAction = "Insert";


function fillemployee() {

  let sendingData = {
    "action": "read_all_employeeee"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/bill.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['emp_id']}">${res['employename']}</option>`;

        })

        $("#empol_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}


$("#billform").on("submit", function (event) {

  event.preventDefault();


  let empol_id = $("#empol_id").val();
  let amount = $("#amount").val();
  let users = $("#users").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "empol_id": empol_id,
      "amount": amount,
      "users": users,
      "action": "register_bill"
    }

  
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/bill.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#billform")[0].reset();
        load_bill();





      } else {
        swal("NOW!", response, "error");
      }

    },
    error: function (data) {
      swal("NOW!", response, "error");

    }

  })

})

function load_bill() {
  $("#billTable tbody").html('');
  $("#billTable thead").html('');

  let sendingData = {
    "action": "read_all_bill"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/bill.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';
      let th = '';

      if (status) {
        response.forEach(res => {
          tr += "<tr>";
          th = "<tr>";
          for(let r in res){
            th += `<th>${r}</th>`;

         if(r == "amount"){
          tr += `<td> $${res[r]}</td>`;
   
         }else{
          tr += `<td>${res[r]}</td>`;
         }

          }
        //   th += "<td>Action</td></tr>";

        //  tr += `<td> <button class="btn btn-info update_info btn-primary btn-sm"  update_id=${res['invoice_id']}><i class="fas fa-edit" style="color: #fff" ></i></button>
        //  `
          tr+= "</tr>"

        })
        $("#billTable thead").append(th);
        $("#billTable tbody").append(tr);
      }

    },

  })
}

$("#empol_id").on("change", function(){
  if($("#empol_id").val()== 0){
   $("#amount").val("");
  }else{
   console.log("kkkkk");
  }
   console.log(customers);
 
   fill_amount(customers);
 })
 
 
 $("#billform").on("change", "select.employees", function(){
 
   let employees=$(this).val();
 
   console.log(employees);
 
   fill_amount_bill(employees);
 })
 
  function fill_amount_bill(empol_id){
 
   let sendingData={
     "action": "fill_amount_bill",
     "empol_id": empol_id
   }
 
   $.ajax({
     method: "POST",
     dataType: "JSON",
     url: "Api/bill.php",
     data: sendingData,
 
     success: function(data){
       let status=data.status;
       let response=data.data;
 
       if(status){
         response.forEach(res =>{
           $("#amount").val(res['salary']);
 
         })
 
       }else{
         swal("Now", response,"error");
       }
 
       
     }
 
      
   })
 }
    

