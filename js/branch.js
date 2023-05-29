loadbranch();
btnAction = "Insert";

$("#branchform").on("submit", function (event) {

  event.preventDefault();


  let branch_name = $("#branch_name").val();
  let address = $("#address").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "branch_name": branch_name,
      "address": address,
      "action": "register_branch"
    }

  } else {
    sendingData = {
      "branch_id": id,
      "branch_name": branch_name,
      "address": address,
      "action": "update_branch"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/branch.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#branchform")[0].reset();
        loadbranch();



      } else {
        swal("NOW!", response, "error");
      }

    },
    error: function (data) {
      swal("NOW!", response, "error");

    }

  })

})



function loadbranch() {
  $("#branchTable tbody").html('');
  $("#branchTable thead").html('');

  let sendingData = {
    "action": "read_all_branch"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/branch.php",
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

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['branch_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['branch_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
          tr += "</tr>"

        })
        $("#branchTable thead").append(th);
        $("#branchTable tbody").append(tr);
      }



    },
    error: function (data) {

    }

  })
}


function get_branch(branch_id) {

  let sendingData = {
    "action": "get_branch",
    "branch_id": branch_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/branch.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['branch_id']);
        $("#branch_name").val(response['branch_name']);
        $("#address").val(response['address']);
        $("#branchmodal").modal('show');




      } else {
        resultmessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}


function Delete_branch(branch_id) {

  let sendingData = {
    "action": "Delete_branch",
    "branch_id": branch_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/branch.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loadbranch();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#branchTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_branch(id)
})


$("#branchTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_branch(id)

  }

})