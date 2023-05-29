$("#booking_id").attr("disabled", true);

$("#type").on("change", function () {
  if ($("#type").val() == 0) {
    $("#booking_id").attr("disabled", true);

  } else {
    $("#booking_id").attr("disabled", false);
  }
})


$("#printt_statement").on("click", function () {
  let printarea = document.querySelector("#printt_Area");


  let newwindow = window.open("");
  newwindow.document.write(`<html><head><title></title>`);
  newwindow.document.write(`<style media="print">
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200&display=swap');
    body{
        font-family: 'Poppins', sans-serif;
    }

    table{
      width:100%;
  }

    th{
        background-color : #40E0D0 !important;
        color: white !important;
       
    }
      
    th , td{
        padding:10px !important;
        text-align: left !important;

    }

    th , td{
        
        border-bottom : 1px solid #ddd !important;
    }
    
    
    </style>`);
  newwindow.document.write(`</head><body>`);
  newwindow.document.write(printarea.innerHTML);
  newwindow.document.write(`</body></html>`);
  newwindow.print();
  newwindow.close();


})



$("#exportt_statement").on("click", function () {
  let file = new Blob([$('#printt_Area').html()], { type: "application/vnd.ms-excel" });
  let url = URL.createObjectURL(file);
  let a = $("<a />", {
    href: url,
    download: "print_statement.xls"
  }).appendTo("body").get(0).click();
  e.preventDefault();

});



$("#bookinggform").on("submit", function (event) {

  event.preventDefault();
  $("#bokingTable tr").html("");


  let booking_id = $("#booking_id").val();



  let sendingData = {

    "booking_id": booking_id,

    "action": "read_alll_booking",

  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/booking.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      let tr = '';
      let th = '';

      if (status) {
        response.forEach(res => {

          th = "<tr>";
          for (let r in res) {
            th += `<th>${r}</th>`;
          }

          th += "</tr>";


          tr += "<tr>";
          for (let r in res) {

            if (r == "status") {
              if (res[r] == "paid") {
                tr += `<td><span class="badge bg-success">${res[r]}</span></td>`;
              } else {
                tr += `<td><span class="badge bg-danger">${res[r]}</span></td>`;
              }
            } else {
              tr += `<td>${res[r]}</td>`;
            }

          }

          tr += "</tr>"

        })

        $("#bokingTable thead").append(th);
        $("#bokingTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })

})

function displaymessage(type, message) {
  let success = document.querySelector(".alert-success");
  let error = document.querySelector(".alert-danger");
  if (type == "success") {
    error.classList = "alert alert-danger d-none";
    success.classList = "alert alert-success";
    success.innerHTML = message;

    setTimeout(function () {
      //   $("#expensemodal").modal("hide");
      success.classList = "alert alert-success d-none";
      $("#bookinggform")[0].reset();

    }, 3000);
  } else {
    error.classList = "alert alert-danger";
    error.innerHTML = message;
  }
}


function loadData() {
  $("#bokingTable tbody").html('');

  let sendingData = {
    "action": "get_booking_info"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/booking.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {

          th = "<tr>";
          for (let r in res) {
            th += `<th>${r}</th>`;
          }

          th += "</tr>";


          tr += "<tr>";
          for (let r in res) {

            if (r == "status") {
              if (res[r] == "paid") {
                tr += `<td><span class="badge badge-success">${res[r]}</span></td>`;
              } else {
                tr += `<td><span class="badge badge-danger">${res[r]}</span></td>`;
              }
            } else {
              tr += `<td>${res[r]}</td>`;
            }

          }

          tr += "</tr>"

        })

        $("#bokingTable thead").append(th);
        $("#bokingTable tbody").append(tr);
      }

    },
    error: function (data) {

    }

  })
}



