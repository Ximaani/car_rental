load_employee();
filljobs();
fillemploye();
fillebranch();
btnAction = "Insert";

function fillebranch() {

  let sendingData = {
    "action": "read_all_branch"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/employee.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['branch_id']}">${res['branch_name']}</option>`;

        })

        $("#branch_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fillemploye() {

  let sendingData = {
    "action": "read_all_employe_name"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/user.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['emp_id']}">${res['employe_name']}</option>`;

        })

        $("#emp_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}


function filljobs() {

  let sendingData = {
    "action": "read_all_jop_title"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/employee.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['title_id']}">${res['position']}</option>`;

        })

        $("#title_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}



$("#employeeform").on("submit", function (event) {

  event.preventDefault();


  let emp_first_name = $("#emp_first_name").val();
  let emp_last_name = $("#emp_last_name").val();
  let phone = $("#phone").val();
  let address = $("#address").val();
  let title_id = $("#title_id").val();
  let branch_id = $("#branch_id").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "emp_first_name": emp_first_name,
      "emp_last_name": emp_last_name,
      "phone": phone,
      "address": address,
      "title_id": title_id,
      "branch_id": branch_id,
      "action": "register_employee"
    }

  } else {
    sendingData = {
      "emp_id": id,
      "emp_first_name": emp_first_name,
      "emp_last_name": emp_last_name,
      "phone": phone,
      "address": address,
      "title_id": title_id,
      "branch_id": branch_id,
      "action": "update_employee"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/employee.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#employeeform")[0].reset();
        $("employeemodal").modal("hide");
        load_employee();





      } else {
        swal("NOW!", response, "error");
      }

    },
    error: function (data) {
      swal("NOW!", response, "error");

    }

  })

})


function load_employee() {
  $("#employeeTable tbody").html('');
  $("#employeeTable thead").html('');

  let sendingData = {
    "action": "read_all_employe"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/employee.php",
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

           
            tr += `<td>${res[r]}</td>`;

          }
          th += "<td>Action</td></tr>";

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['emp_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['emp_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`

          tr += "</tr>"

        })

        $("#employeeTable thead").append(th);
        $("#employeeTable tbody").append(tr);
      }



    },
    error: function (data) {

    }

  })
}

function get_employee_info(emp_id) {

  let sendingData = {
    "action": "get_employee_info",
    "emp_id": emp_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/employee.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['emp_id']);
        $("#emp_first_name").val(response['emp_first_name']);
        $("#emp_last_name").val(response['emp_last_name']);
        $("#phone").val(response['phone']);
        $("#address").val(response['address']);
        $("#title_id").val(response['title_id']);
        $("#branch_id").val(response['branch_id']);
        $("#employeemodal").modal('show');




      } else {
        dispalaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}






function Delete_employee(emp_id) {

  let sendingData = {
    "action": "Delete_employee",
    "emp_id": emp_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/employee.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        load_employee();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}

$("#employeeTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_employee_info(id)
})


$("#employeeTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_employee(id)

  }

})