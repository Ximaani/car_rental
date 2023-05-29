loadmodal();
btnAction = "Insert";

$("#modalform").on("submit", function (event) {

  event.preventDefault();


  let modal_name = $("#modal_name").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "modal_name": modal_name,
      "action": "register_modals"
    }

  } else {
    sendingData = {
      "modal_id": id,
      "modal_name": modal_name,
      "action": "update_modals"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/modals.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#modalform")[0].reset();
        loadmodal();





      } else {
        displymessage("error", response);
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadmodal() {
  $("#modalTable tbody").html('');
  $("#modalTable thead").html('');

  let sendingData = {
    "action": "read_all_modals"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/modals.php",
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

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['modal_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['modal_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
          tr += "</tr>"

        })
        $("#modalTable thead").append(th);
        $("#modalTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}

function get_modals(modal_id) {

  let sendingData = {
    "action": "get_modals",
    "modal_id": modal_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/modals.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['modal_id']);
        $("#modal_name").val(response['modal_name']);
        $("#modalmodal").modal('show');




      } else {
        displymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function Delete_modal(modal_id) {

  let sendingData = {
    "action": "Delete_modals",
    "modal_id": modal_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/modals.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loadmodal();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#modalTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_modals(id)
})

$("#modalTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_modal(id)

  }

})