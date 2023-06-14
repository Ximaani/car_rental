loadaccount();
// get_account();
// fill_level();
btnAction = "Insert";



// function fill_level() {

//   let sendingData = {
//     "action": "read_all_levels"
//   }

//   $.ajax({
//     method: "POST",
//     dataType: "JSON",
//     url: "Api/levels.php",
//     data: sendingData,

//     success: function (data) {
//       let status = data.status;
//       let response = data.data;
//       let html = '';
//       let tr = '';

//       if (status) {
//         response.forEach(res => {
//           html += `<option value="${res['level_id']}">${res['level_name']}</option>`;


//         })

//         $("#level_id").append(html);


//       } else {
//         displaymssage("error", response);
//       }

//     },
//     error: function (data) {

//     }

//   })
// }

$("#account_form").on("submit", function (event) {

  event.preventDefault();


  let bank_name = $("#bank_name").val();
  let holder_name = $("#holder_name").val();
  let account_number = $("#account_number").val();
  let balance = $("#balance").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "bank_name": bank_name,
      "holder_name": holder_name,
      "account_number": account_number,
      "balance": balance,
      
      "action": "register_account"
    }

  } else {
    sendingData = {
      "account_id": id,
      "bank_name": bank_name,
      "holder_name": holder_name,
      "account_number": account_number,
      "balance": balance,
      "action": "update_account"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/account.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#account_form")[0].reset();
        loadaccount();





      } else {
        swal("Good job!", response, "error");
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadaccount() {
  $("#account_Table tbody").html('');
  $("#account_Table thead").html('');

  let sendingData = {
    "action": "read_all_account"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/account.php",
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

         if(r == "balance"){
          tr += `<td> $${res[r]}</td>`;
   
         }else{
          tr += `<td>${res[r]}</td>`;
         }

          }
          
         
          tr+= "</tr>"

        })
        $("#account_Table thead").append(th);
        $("#account_Table tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}

function get_account(account_id) {

  let sendingData = {
    "action": "get_account",
    "account_id": account_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/account.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        btnAction = "update";

        $("#update_id").val(response['account_id']);
        $("#bank_name").val(response['bank_name']);
        $("#holder_name").val(response['holder_name']);
        $("#account_number").val(response['account_number']);
        $("#balance").val(response['balance']);
        $("#account_modal").modal('show');




      } else {
        displayymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function Delete_account(account_id) {

  let sendingData = {
    "action": "Delete_account",
    "account_id": account_id
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/account.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;


      if (status) {

        swal("Good job!", response, "success");
        loadaccount();


      } else {
        swal(response);
      }

    },
    error: function (data) {

    }

  })
}



$("#account_Table").on('click', "a.update_info", function () {
  let id = $(this).attr("update_id");
  get_account(id)
})

$("#account_Table").on('click', "a.delete_info", function () {
  let id = $(this).attr("delete_id");
  if (confirm("Are you sure To Delete")) {
    Delete_account(id)

  }

})