loadpayment();
// get_payment();
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


  let customer_id = $("#customer_id").val();
  let amount = $("#amount").val();
  let payment_method_id = $("#payment_method_id").val();
  let account_id = $("#account_id").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "customer_id": customer_id,
      "amount": amount,
      "payment_method_id": payment_method_id,
      "account_id": account_id,
      "action": "register_payment"
    }

  } else {
    sendingData = {
      "payment_id": id,
      "customer_id": customer_id,
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

          th += "<td>Action</td></tr>";




          tr += "<tr>";
          for (let r in res) {


            tr += `<td>${res[r]}</td>`;


          }

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['payment_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['payment_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
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

function get_payment_info(payment_id) {

  let sendingData = {
    "action": "get_payment_info",
    "payment_id": payment_id
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

        btnAction = "update";

        $("#update_id").val(response['payment_id']);
        $("#customer_id ").val(response['customer_id ']);
        $("#amount").val(response['amount']);
        $("#payment_method_id").val(response['payment_method_id']);
        $("#account_id").val(response['account_id']);
        // $("#status").val(response['status']);
        $("#payment_modal").modal('show');




      } else {
        displayymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function Delete_payment(payment_id) {

  let sendingData = {
    "action": "Delete_payment",
    "payment_id": payment_id
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
        loadpayment();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#paymentTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_payment_info(id)
})

$("#paymentTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_payment(id)

  }

})