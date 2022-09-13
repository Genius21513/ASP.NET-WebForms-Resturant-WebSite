$(document).ready(function () {
    $.ajax({
        type: "POST",
        url: "Settings.aspx/GetData",
        //data: "{'address':'" + address.toString() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "JSON",

        success: function (output) {

        }
    })
})