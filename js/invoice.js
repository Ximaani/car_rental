loadinvoice();
fill_customers();
fill_price();
btnAction = "Insert";
function fill_customers() {

  let sendingData = {
    "action": "read_all_customers"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/invoice.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['customer_id']}">${res['customer_name']}</option>`;


        })

        $("#customers_id").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

$("#invoiceform").on("submit", function (event) {

  event.preventDefault();


  let customers_id = $("#customers_id").val();
  let cars_id = $("#cars_id").val();
  let rental_price = $("#rental_price").val();
  let taken_date = $("#taken_date").val();
  let return_date = $("#return_date").val();
  let total_amount = $("#total_amount").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "customers_id": customers_id,
      "cars_id": cars_id,
      "rental_price": rental_price,
      "taken_date": taken_date,
      "return_date": return_date,
      "total_amount": total_amount,
      "action": "register_invoice"
    }

  } else {
    sendingData = {
      "invoice_id": id,
      "customers_id": customers_id,
      "cars_id": cars_id,
      "rental_price": rental_price,
      "taken_date": taken_date,
      "return_date": return_date,
      "total_amount": total_amount,
      "action": "update_invoice"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/invoice.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#invoiceform")[0].reset();
        loadinvoice();

      } else {
        swal("Good job!", response, "error");
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadinvoice() {
  $("#invoiceTable tbody").html('');
  $("#invoiceTable thead").html('');

  let sendingData = {
    "action": "read_all_invoice"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/invoice.php",
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

         if(r == "rental_price"){
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
        $("#invoiceTable thead").append(th);
        $("#invoiceTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}

// $("#customers_id").on("change", function(){
//   if($("#customers_id").val()== 0){
//    $("#amount").val("");
//    $("#amount").val("");
//    $("#amount").val("");
//    $("#amount").val("");
//    $("#amount").val("");
//    $("#amount").val("");
//    $("#amount").val("");
//   }else{
//    console.log("kkkkk");
//   }
//    console.log(customers);
 
//    fill_amount(customers);
//  })
 
 
 $("#customers_id").on("change", function(){
 
   let customers_id=$(this).val();
  
   fill_price(customers_id);
 })

 function fill_price(customer_id){

  let sendingData={
    "action": "read_rent_price",
    "customer_id": customer_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/invoice.php",
    data: sendingData,

    success: function(data){
      let status=data.status;
      let response=data.data;

      if(status){
        response.forEach(res =>{

          $("#cars_id").val(res['car_name']);
          $("#rental_price").val(res['rental_price']);
          $("#taken_date").val(res['taken_date']);
          $("#return_date").val(res['return_date']);
          $("#total_amount").val(res['amount']);

        })

      }else{
        swal("Now", response,"error");
      }

      
    }

     
  })
}
   