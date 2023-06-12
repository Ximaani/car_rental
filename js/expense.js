load_expense();
btnAction = "Insert";
fillaccoun();
function fillaccoun() {

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

            if (status) {
                response.forEach(res => {
                    html += `<option value="${res['account_id']}">${res['bank_name']}</option>`;

                })

                $("#Account_id").append(html);


            } else {
                displaymessage("error", response);
            }

        },
        error: function (data) {

        }

    })
}

$("#expenseForm").on("submit",function(event) {

    event.preventDefault();

    console.log("submit");
    let amount = $("#amount").val();
    let type = $("#type").val();
    let description = $("#description").val();
    let users_id = $("#users_id").val();
    let Account_id = $("#Account_id").val();
    let id = $("#update_id").val();

    let sendingData = {}

    if(btnAction == "Insert"){
        sendingData = {
            "amount" : amount,
            "type" : type,
            "description" : description,
            "users_id" : users_id,
            "Account_id" : Account_id,
            "action" : "register_expense"
            
        }
    
    }else{
          sendingData = {
            "id" : id,
            "amount" : amount,
            "type" : type,
            "description" : description,
            "users_id" : users_id,
            "Account_id" : Account_id,
            "action" : "update_expense"
            
        }
    
    }

    
  
    $.ajax( {
        method: "POST",
        dataType: "JSON",
        url : "Api/expense.php",
        data : sendingData,
        success: function(data){

            let status = data.status;
            let response = data.data;

            if(status){

                swal("Good job!", response, "success");
                btnAction = "Insert";
                $("#expenseForm")[0].reset();
                load_expense();
            }else{
                swal("NOW!", response, "error");
            }
           

        },
        error: function(data){

        }
    })

})

function load_expense(){

    $("#expenseTable tbody").html('');

    let sendingData = {
        "action" : "get_user_transaction"
    }

    $.ajax( {
        method: "POST",
        dataType: "JSON",
        url : "Api/expense.php",
        data : sendingData,
        success: function(data){

            let status = data.status;
            let response = data.data;
            let html = '';
            let tr = '';

            if(status){

                response.forEach( res => {

                    tr += "<tr>";
                    for(let r in res){

                        if(r=="amount"){
                            tr += `<td>$${res[r]}</td>`;
              
                          }

                        else if(r == "type"){
                            if(res[r] == "Income"){
                                tr += `<td><span class="btn btn-success btn-sm">${res[r]}</span></td>`;
                            }else{
                                tr += `<td><span class="btn btn-danger btn-sm">${res[r]}</span></td>`;
                            }
                        }else{
                            tr += `<td>${res[r]}</td>`;
                        }

                    }

               
                    tr += "</tr>"

                })

                $("#expenseTable tbody").append(tr);

            }else{
                displayMessage("error",response);
            }
           

        },
        error: function(data){

        }
    })

}



