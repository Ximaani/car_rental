// load_car2();
fillemodal();
// fillecars();
fillefuel();
fillcondition();
filltransmission();
load_car();
btnAction = "Insert";


function fillemodal() {

  let sendingData = {
    "action": "read_all_modal"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['modal_id']}">${res['modal_name']}</option>`;

        })

        $("#modal_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fillefuel() {

  let sendingData = {
    "action": "read_all_type_fuel"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['type_fuel_id']}">${res['fuel_name']}</option>`;

        })

        $("#type_fuel_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fillcondition() {

  let sendingData = {
    "action": "read_all_condition"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['conditions_id']}">${res['conditions_name']}</option>`;

        })

        $("#conditions").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

// function fillecars() {

//   let sendingData = {
//     "action": "read_all_car"
//   }

//   $.ajax({
//     method: "POST",
//     dataType: "JSON",
//     url: "Api/car.php",
//     data: sendingData,

//     success: function (data) {
//       let status = data.status;
//       let response = data.data;
//       let html = '';
//       let tr = '';

//       if (status) {
//         response.forEach(res => {
//           html += `<option value="${res['car_id']}">${res['car_names']}</option>`;

//         })

//         $("#car_id").append(html);


//       } else {
//         displaymessage("error", response);
//       }

//     },
//     error: function (data) {

//     }

//   })
// }

function filltransmission() {

  let sendingData = {
    "action": "read_all_transmission"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['transmission_id']}">${res['transmission_name']}</option>`;

        })

        $("#transmission_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function get_car_info(car_id) {

  let sendingData = {
    "action": "get_car_info",
    "car_id": car_id 
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['car_id']);
        $("#car_names").val(response['car_names']);
        $("#car_number").val(response['car_number']);
        $("#modal_id").val(response['modal_id']);
        $("#transmission_id").val(response['transmission_id']);
        $("#type_fuel_id").val(response['type_fuel_id']);
        $("#rental_price").val(response['rental_price']);
        $("#conditions").val(response['conditions']);
        $("#quantity").val(response['quantity']);
        $("#car_modal").modal('show');




      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

$("#carform").on("submit", function (event) {

  event.preventDefault();


  let car_names = $("#car_names").val();
  let car_number = $("#car_number").val();
  let modal_id = $("#modal_id").val();
  let transmission_id = $("#transmission_id").val();
  let type_fuel_id = $("#type_fuel_id").val();
  let rental_price = $("#rental_price").val();
  let conditions = $("#conditions").val();
  let quantity = $("#quantity").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "car_names": car_names,
      "car_number": car_number,
      "modal_id": modal_id,
      "transmission_id": transmission_id,
      "type_fuel_id": type_fuel_id,
      "rental_price": rental_price,
      "conditions": conditions,
      "quantity": quantity,
      "action": "register_car"
    }

  } else {
    sendingData = {
      "car_id": id,
      "car_names": car_names,
      "car_number": car_number,
      "modal_id": modal_id,
      "transmission_id": transmission_id,
      "type_fuel_id": type_fuel_id,
      "rental_price": rental_price,
      "conditions": conditions,
      "quantity": quantity,
      "action": "update_car"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#carform")[0].reset();
        load_car();





      } else {
        swal("NOW!", response, "error");
      }

    },
    error: function (data) {
      swal("NOW!", response, "error");

    }

  })

})






function load_car() {
  $("#carTable tbody").html('');
  $("#carTable thead").html('');

  let sendingData = {
    "action": "read_all_car"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
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
          for (let r in res) {
            th += `<th>${r}</th>`;

            if (r == "status") {
              if (res[r] == "Top") {
                tr += `<td><span class="badge bg-success">${res[r]}</span></td>`;
              } else {
                tr += `<td><span class="badge bg-danger">${res[r]}</span></td>`;
              }
            } else {
              tr += `<td>${res[r]}</td>`;
            }

          }
          th += "<td>Action</td></tr>";

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['car_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id =${res['car_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
          tr += "</tr>"

        })

        $("#carTable thead").append(th);
        $("#carTable tbody").append(tr);
      }



    },
    error: function (data) {

    }

  })
}


// function load_car2() {
//   $("#topcars tbody").html('');
//   $("#topcars thead").html('');

//   let sendingData = {
//     "action": "read_top_car"
//   }

//   $.ajax({
//     method: "POST",
//     dataType: "JSON",
//     url: "Api/car.php",
//     data: sendingData,

//     success: function (data) {
//       let status = data.status;
//       let response = data.data;
//       let html = '';
//       let tr = '';
//       let th = '';


//       if (status) {
//         response.forEach(res => {
//           tr += "<tr>";
//           th = "<tr>";
//           for (let r in res) {
//             th += `<th>${r}</th>`;

//             if (r == "status") {
//               if (res[r] == "Top") {
//                 tr += `<td><span class="badge bg-success">${res[r]}</span></td>`;
//               } else {
//                 tr += `<td><span class="badge badge-danger">${res[r]}</span></td>`;
//               }
//             } else {
//               tr += `<td>${res[r]}</td>`;
//             }

//           }

//           tr += "</tr>"

//         })

//         $("#topcars thead").append(th);
//         $("#topcars tbody").append(tr);
//       }



//     },
//     error: function (data) {

//     }

//   })
// }


function Delete_car(car_id) {

  let sendingData = {
    "action": "Delete_car",
    "car_id": car_id 
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/car.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        load_car();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}





$("#carTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_car_info(id)
})

$("#carTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_car(id)

  }

})
