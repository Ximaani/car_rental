load_returncar();
fill_rent_car();
fillemploye();
fillCustomar();
btnAction = "Insert";

function fillCustomar() {

  let sendingData = {
    "action": "read_all_Customar"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/returncar.php",
    data: sendingData,

    success: function (data) {
      let status = data.status;
      let response = data.data;
      let html = '';
      let tr = '';

      if (status) {
        response.forEach(res => {
          html += `<option value="${res['rent_id']}">${res['Customers_name']}</option>`;

        })

        $("#rent_id").append(html);


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
    "action": "read_all_returncar_name"
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
          html += `<option value="${res['returncar_id']}">${res['employe_name']}</option>`;

        })

        $("#returncar_id").append(html);


      } else {
        displaymessage("error", response);
      }

    },
    error: function (data) {

    }

  })
}


$("#returncarform").on("submit", function (event) {

  event.preventDefault();
  let rent_id = $("#rent_id").val();
  let returncar = $("#returncar").val();
  let quantity = $("#quantity").val();
  let rtquantity = $("#rtquantity").val();
  let return_date = $("#return_date").val();
  
  let id = $("#update_id").val();

  let sendingData = {}

  if (btnAction == "Insert") {
    sendingData = {
      "rent_id": rent_id,
      "returncar": returncar,
      "quantity": quantity,
      "rtquantity": rtquantity,
      "return_date": return_date,
      "action": "register_returncar"
    }

 
  }



  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/returncar.php",
    data: sendingData,
    success: function (data) {
      let status = data.status;
      let response = data.data;

      if (status) {
        swal("Good job!", response, "success");
        btnAction = "Insert";
        $("#returncarform")[0].reset();
        $("returncarmodal").modal("hide");
        load_returncar();





      } else {
        swal("NOW!", response, "error");
      }

    },
    error: function (data) {
      swal("NOW!", response, "error");

    }

  })

})


$("#returncarform").on("change","select.rent", function(){
  let rent=$(this).val();
  fill_rent_car(rent);
})



$("#rent_id").on("change", function(){
  if($("#rent_id").val()== 0){
   $("#returncar").val("");
   $("#quantity").val("");
  }else{
  // console.log(customers);
  }
   console.log(customers);
 
   fill_amount(customers);
 })



function fill_rent_car(rent_id){
 let sendingData={
   "action": "read_all_returncar",
   "rent_id": rent_id
 }

 $.ajax({
   method: "POST",
   dataType: "JSON",
   url: "Api/returncar.php",
   data: sendingData,

   success: function(data){
     let status=data.status;
     let response=data.data;

     if(status){
       response.forEach(res =>{

         $("#returncar").val(res['car_id']);
         $("#quantity").val(res['quantity']);
         

       })

     }else{
       swal("Now", response,"error");
     }

     
   }

    
 })
}
 

function load_returncar() {
  $("#returncarTable tbody").html('');
  $("#returncarTable thead").html('');

  let sendingData = {
    "action": "read_all_retur_ncar"
  }

  $.ajax({
    method: "POST",
    dataType: "JSON",
    url: "Api/returncar.php",
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

          tr += `<td> <a class="btn btn-info update_info"  update_id=${res['returncar_id']}><i class="bi bi-pencil-square" style="color: #fff"></i></a>&nbsp;&nbsp <a class="btn btn-danger delete_info" delete_id=${res['returncar_id']}><i class="bi bi-trash" style="color: #fff"></i></a> </td>`

          tr += "</tr>"

        })

        $("#returncarTable thead").append(th);
        $("#returncarTable tbody").append(tr);
      }



    },
    error: function (data) {

    }

  })
}


