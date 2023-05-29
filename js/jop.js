loadjop();
btnAction = "Insert";

$("#jopform").on("submit", function (event) {

  event.preventDefault();


  let position = $("#position").val();
  let salary = $("#salary").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "position": position,
      "salary": salary,
      "action": "register_jops"
    }

  } else {
    sendingData = {
      "title_id": id,
      "position": position,
      "salary": salary,
      "action": "update_jops"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/jop.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#jopform")[0].reset();
        loadjop();





      } else {
        displymessage("error", response);
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadjop() {
  $("#jopTable tbody").html('');
  $("#jopTable thead").html('');

  let sendingData = {
    "action": "read_all_jops"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/jop.php",
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

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['title_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['title_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`
          tr += "</tr>"

        })
        $("#jopTable thead").append(th);
        $("#jopTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}

function get_jops(title_id) {

  let sendingData = {
    "action": "get_jops",
    "title_id": title_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/jop.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['title_id']);
        $("#position").val(response['position']);
        $("#salary").val(response['salary']);
        $("#jopmodal").jop('show');




      } else {
        displymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function Delete_jop(title_id) {

  let sendingData = {
    "action": "Delete_jops",
    "title_id": title_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/jop.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loadjop();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#jopTable").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_jops(id)
})

$("#jopTable").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_jop(id)

  }

})