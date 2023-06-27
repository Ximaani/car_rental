
get_total_balance();
get_all_employee();
get_all_users();
get_all_Income();
get_all_sum_pending();
get_all_Expenses();
get_total_customer();


function get_total_customer() {

    let sendingData = {
        "action": "get_total_customer"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#total_customer").innerText = response['customer']


            } else {

            }

        },
        error: function (data) {

        }

    })
}


function get_total_balance() {

    let sendingData = {
        "action": "get_total_balance"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;
            if (status) {
                document.querySelector("#totalbalance").innerText = response['balances']

            } else {

            }
        },
        error: function (data) {

        }

    })
}


function get_all_employee() {

    let sendingData = {
        "action": "get_all_employee"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,
        async: false,
        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#employee").innerText = response['employee'];


            } else {

            }

        },
        error: function (data) {

        }

    })
}



function get_total_revenue() {



    document.querySelector("#Revenue").innerText = tempTotalincome - tempTotalexpense;



}



function get_all_users() {

    let sendingData = {
        "action": "get_all_users"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,

        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#users").innerText = response['users']


            } else {

            }

        },
        error: function (data) {

        }

    })
}

function get_all_Income() {

    let sendingData = {
        "action": "get_all_income"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,

        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#total_income").innerText = response['Income']


            } else {

            }

        },
        error: function (data) {

        }

    })
}
function get_all_Expenses() {

    let sendingData = {
        "action": "get_all_expense"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,

        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#total_expense").innerText = response['Expense']


            } else {

            }

        },
        error: function (data) {

        }

    })
}

function get_all_sum_pending() {

    let sendingData = {
        "action": "get_all_sum_pending"

    }

    $.ajax({
        method: "POST",
        dataType: "JSON",
        url: "Api/income.php",
        data: sendingData,

        success: function (data) {
            let status = data.status;
            let response = data.data;


            if (status) {


                document.querySelector("#total_sum_pending").innerText = response['total']


            } else {

            }

        },
        error: function (data) {

        }

    })
}



function loadtop() {
    $("#topcustomers tbody").html('');
    $("#topcustomers thead").html('');
  
    let sendingData = {
      "action": "read_top"
    }
  
    $.ajax({
      method: "POST",
      dataType: "JSON",
      url: "Api/income.php",
      data: sendingData,
  
      success: function (data) {
        let status = data.status;
        let response = data.data;
        let html = '';
        let tr = '';
        let th = '';
  
        if (status) {
          response.forEach(res=>{
            tr += "<tr>";
            th = "<tr>";
            for(let r in res){
              th += `<th>${r}</th>`;
  
           if(r == "rating_name"){
            if(res[r] == "Excellent"){
              tr += `<td><span class="badge bg-success text-white">${res[r]}</span></td>`;
            }else if (res[r] == "Good"){
              tr += `<td><span class="badge bg-primary text-white">${res[r]}</span></td>`;
            }
  
            else if (res[r] == "Fair"){
              tr += `<td><span class="badge bg-warning text-white">${res[r]}</span></td>`;
            }
            else if (res[r] == "Very Poor"){
              tr += `<td><span class="badge bg-danger text-white">${res[r]}</span></td>`;
            }
  
            else{
              tr += `<td><span class="badge bg-dark text-white">${res[r]}</span></td>`;
            }
  
  
  
            
           }else{
            tr += `<td>${res[r]}</td>`;
           }
  
            }
     
          
        })
          $("#topcustomers thead").append(th);
          $("#topcustomers tbody").append(tr);
        }
  
      },
      error: function (data) {
  
      }
  
    })
  }
  