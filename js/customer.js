btnAction = "Insert";
get_customer_info();
loadcustomer();
Delete_customer();


// function fillrating() {

//   let sendingData = {
//     "action": "read_all_rating"
//   }

//   $.ajax({
//     method: "POST",
//     dataType: "JSON",
//     url: "Api/customer.php",
//     data: sendingData,

//     success: function (data) {
//       let status = data.status;
//       let response = data.data;
//       let html = '';
//       let tr = '';

//       if (status) {
//         response.forEach(res => {
//           html += `<option value="${res['rating_id']}">${res['rating_name']}</option>`;

//         })

//         $("#rating_id").append(html);


//       } else {
//         displaymessage("error", response);
//       }

//     },
//     error: function (data) {

//     }

//   })
// }

$("#customerform").on("submit", function (event) {

  event.preventDefault();


  let customer_id = $("#customer_id").val();
  let fristname = $("#fristname").val();
  let lastname = $("#lastname").val();
  let phone = $("#phone").val();
  let city = $("#city").val();
  let state = $("#state").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "customer_id": customer_id,
      "fristname": fristname,
      "lastname": lastname,
      "phone": phone,
      "city": city,
      "state": state,
      "action": "register_customer"
    }

  } else {
    sendingData = {
      "customer_id": customer_id,
      "fristname": fristname,
      "lastname": lastname,
      "phone": phone,
      "city": city,
      "state": state,
      "action": "update_customer"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/customer.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#customerform")[0].reset();
        loadcustomer();


      } else {
        employemessage("error", response);
      }

    },
    error: function (data) {
      employemessage("error", data.responseText);

    }

  })

})


// function loadcustomer() {
//   $("#customerTable tbody").html('');
//   $("#customerTable thead").html('');

//   let sendingData = {
//     "action": "read_all_customer"
//   }

//   $.ajax({
//     method: "POST",
//     dataType: "JSON",
//     url: "Api/customer.php",
//     data: sendingData,

//     success: function (data) {
//       let status = data.status;
//       let response = data.data;
//       let html = '';
//       let tr = '';
//       let th = '';

//       if (status) {
//         response.forEach(res=>{
//           tr += "<tr>";
//           th = "<tr>";
//           for(let r in res){
//             th += `<th>${r}</th>`;

//          if(r == "rating_name"){
//           if(res[r] == "Excellent"){
//             tr += `<td><span class="badge bg-success text-white">${res[r]}</span></td>`;
//           }else if (res[r] == "Good"){
//             tr += `<td><span class="badge bg-primary text-white">${res[r]}</span></td>`;
//           }

//           else if (res[r] == "Fair"){
//             tr += `<td><span class="badge bg-warning text-white">${res[r]}</span></td>`;
//           }
//           else if (res[r] == "Very Poor"){
//             tr += `<td><span class="badge bg-danger text-white">${res[r]}</span></td>`;
//           }

//           else{
//             tr += `<td><span class="badge bg-dark text-white">${res[r]}</span></td>`;
//           }



          
//          }else{
//           tr += `<td>${res[r]}</td>`;
//          }

//           }

 
        
//       })
//         $("#customerTable thead").append(th);
//         $("#customerTable tbody").append(tr);
//       }

//     },
//     error: function (data) {

//     }

//   })
// }

function loadcustomer() {
  $("#customerTable tbody").html('');
  $("#customerTable thead").html('');

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

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['customer_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['customer_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
          tr += "</tr>"

        })
        $("#customerTable thead").append(th);
        $("#customerTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}


function get_customer_info(customer_id) {

  let sendingData = {
    "action": "get_customer_info",
    "customer_id": customer_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/customer.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['customer_id']);
        $("#fristname").val(response['fristname']);
        $("#lastname").val(response['lastname']);
        $("#phone").val(response['phone']);
        $("#city").val(response['city']);
        $("#state").val(response['state']);
        
        $("#customermodal").modal('show');




      } else {
        customermessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}


function Delete_customer(customer_id) {

  let sendingData = {
    "action": "Delete_customer",
    "customer_id": customer_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/customer.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loadcustomer();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#customerTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_customer_info(id)
})


$("#customerTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_customer(id)

  }

})