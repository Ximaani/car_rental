loadrent();
// get_rent();
fill_customer();
fill_car();
load_car_rent_pending();
btnAction = "Insert";

function fill_customer() {

  let sendingData = {
    "action": "read_all_customer"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/customer.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['customer_id']}">${res['fristname']}</option>`;


        })

        $("#customer_id").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fill_car() {

  let sendingData = {
    "action": "read_all_car"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/rent.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['car_id']}">${res['car_name']}</option>`;


        })

        $("#car_id").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

$("#rentform").on("submit", function (event) {

  event.preventDefault();


  let customer_id = $("#customer_id").val();
  let car_id = $("#car_id").val();
  let quantity = $("#quantity").val();
  let taken_date = $("#taken_date").val();
  let return_date = $("#return_date").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "customer_id": customer_id,
      "car_id": car_id,
      "quantity": quantity,
      "taken_date": taken_date,
      "return_date": return_date,
      "action": "register_rent"
    }

  } else {
    sendingData = {
      "rent_id": id,
      "customer_id": customer_id,
      "car_id": car_id,
      "quantity": quantity,
      "taken_date": taken_date,
      "return_date": return_date,
      "action": "update_rent"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/rent.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("SORRY!", response, "success");
        btnAction = "Insert";
        $("#rentform")[0].reset();
        loadrent();

      } else {
        swal("Good job!", response, "error");
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadrent() {
  $("#rentTable tbody").html('');
  $("#rentTable thead").html('');

  let sendingData = {
    "action": "read_all_rent"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/rent.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';
      let th = '';

      if(status){
        response.forEach(res=>{
            tr += "<tr>";
            th = "<tr>";
            for(let r in res){
              th += `<th>${r}</th>`;

           if(r == "action"){
            if(res[r] == "pending"){
              tr += `<td><span class="badge bg-danger text-white ">${res[r]}</span></td>`;
            }else if(res[r] == "Invoiced"){
              tr += `<td><span class="badge bg-warning text-white ">${res[r]}</span></td>`;
            }
            else if(res[r] == "Returned"){
              tr += `<td><span class="badge bg-primary text-white ">${res[r]}</span></td>`;
            }
            else if(res[r] == "Paid"){
              tr += `<td><span class="badge bg-success text-white ">${res[r]}</span></td>`;
            }
          
            else{
              tr += `<td><span class="badge bg-warning text-white">${res[r]}</span></td>`;
            }
           }else{
            tr += `<td>${res[r]}</td>`;
           }

            }
            th += "<td>Action</td></tr>";

            tr += `<td> <a class="btn btn-info update_info"  update_id=${res['rent_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['rent_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
            tr+= "</tr>"
          
        })

        $("#rentTable thead").append(th);
        $("#rentTable tbody").append(tr);
    }

    },
    error: function (data) {

    }

  })
}

function load_car_rent_pending() {
  $("#top_car_pending tbody").html('');
  $("#top_car_pending thead").html('');

  let sendingData = {
    "action": "read_all_rent_car_pending"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/rent.php",
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
        $("#top_car_pending thead").append(th);
        $("#top_car_pending tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}

function get_rent_info(rent_id) {

  let sendingData = {
    "action": "get_rent_info",
    "rent_id": rent_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/rent.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['rent_id']);
        $("#customer_id").val(response['customer_id']);
        $("#car_id").val(response['car_id']);
        $("#quantity").val(response['quantity']);
        $("#taken_date").val(response['taken_date']);
        $("#return_date").val(response['return_date']);
        $("#rent_price").val(response['rent_price']);
        $("#penalty").val(response['penalty']);
        $("#status").val(response['status']);
        $("#rent_modal").modal('show');




      } else {
        displayymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function Delete_rent(rent_id) {

  let sendingData = {
    "action": "Delete_rent",
    "rent_id": rent_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/rent.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loadrent();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#rentTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_rent_info(id)
})

$("#rentTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_rent(id)

  }

})