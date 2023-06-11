loadpayment();
fill_amount();
fill_customer();
fill_payment_method();
btnAction = "Insert";
function fill_customer() {

  let sendingData = {
    "action": "read_all_customer_name"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/payment.php",
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

        $("#Customer_id").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fill_payment_method() {

  let sendingData = {
    "action": "read_all_payment_method"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/payment.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['payment_method_id']}">${res['method_name']}</option>`;


        })

        $("#payment_method_id").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

$("#paymentform").on("submit", function (event) {

  event.preventDefault();


  let Customer_id = $("#Customer_id").val();
  let amount = $("#amount").val();
  let payment_method_id = $("#payment_method_id").val();
  let account_id = $("#account_id").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "Customer_id": Customer_id,
      "amount": amount,
      "payment_method_id": payment_method_id,
      "account_id": account_id,
      "action": "register_payment"
    }

  } else {
    sendingData = {
      "payment_id": id,
      "Customer_id": Customer_id,
      "amount": amount,
      "payment_method_id": payment_method_id,
      "account_id": account_id,
      "action": "update_payment"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/payment.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#paymentform")[0].reset();
        loadpayment();

      } else {
        swal("Good job!", response, "error");
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadpayment() {
  $("#paymentTable tbody").html('');
  $("#paymentTable thead").html('');

  let sendingData = {
    "action": "read_all_payment"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/payment.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';
      let th = '';

      if (status) {
        response.forEach(res => {
          th = "<tr>";
          for (let r in res) {
            th += `<th>${r}</th>`;
          }





          tr += "<tr>";
          for (let r in res) {


            tr += `<td>${res[r]}</td>`;


          }

          tr += "</tr>"

        })
        $("#paymentTable thead").append(th);
        $("#paymentTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}

$("#Customer_id").on("change", function(){
 if($("#Customer_id").val()== 0){
  $("#amount").val("");
 }else{
  console.log("kkkkk");
 }
  console.log(customers);

  fill_amount(customers);
})


$("#paymentform").on("change", "select.customers", function(){

  let customers=$(this).val();

  console.log(customers);

  fill_amount(customers);
})

 function fill_amount(customer_id){

  let sendingData={
    "action": "fill_amount",
    "customer_id": customer_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/payment.php",
    data: sendingData,

    success: function(data){
      let status=data.status;
      let response=data.data;

      if(status){
        response.forEach(res =>{
          $("#amount").val(res['Total_amount']);

        })

      }else{
        swal("Now", response,"error");
      }

      
    }

     
  })
}
   
  