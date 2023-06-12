loadcharge();
// get_charge();
fill_user();
fill_month();
fillaccount();
btnAction = "Insert";



function fill_user() {

  let sendingData = {
    "action": "read_all_user"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/charge.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['id']}">${res['username']}</option>`;


        })

        $("#user_idd").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fill_month() {

  let sendingData = {
    "action": "read_all_month"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/charge.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['month_id']}">${res['month_name']}</option>`;


        })

        $("#month").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

function fillaccount() {

  let sendingData = {
    "action": "read_all_account"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/charge.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['account_id']}">${res['bank_name']}</option>`;


        })

        $("#accountt_id").append(html);


      } else {
        displaymssage("error", response);
      }

    },
    error: function (data) {

    }

  })
}

$("#chargeform").on("submit", function (event) {

  event.preventDefault();


  let month = $("#month").val();
  let year = $("#year").val();
  let desc = $("#desc").val();
  let user_idd = $("#user_idd").val();
  let accountt_id  = $("#accountt_id").val();
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "month": month,
      "year": year,
      "desc": desc,
      "user_idd": user_idd,
      "accountt_id": accountt_id,
      "action": "register_charge"
    }

  } else {
    sendingData = {
      "charge_id": id,
      "month": month,
      "year": year,
      "desc": desc,
      "user_idd": user_idd,
      "accountt_id ": accountt_id,
      "action": "update_charge"
    }
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/charge.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#chargeform")[0].reset();
        loadcharge();





      } else {
        swal("Unfortunately!", response, "error");
      }

    },
    error: function (data) {
      displaymessage("error", data.responseText);

    }

  })

})

function loadcharge() {
  $("#chargeTable tbody").html('');
  $("#chargeTable thead").html('');

  let sendingData = {
    "action": "read_all_charge"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/charge.php",
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

         if(r == "Amount"){
          tr += `<td> $${res[r]}</td>`;
   
         }else{
          tr += `<td>${res[r]}</td>`;
         }

          }

        })
        $("#chargeTable thead").append(th);
        $("#chargeTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}



