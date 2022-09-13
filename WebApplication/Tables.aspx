<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tables.aspx.cs" Inherits="WebApplication.Tables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
      
    </style>
    <script>
        function Save() {
            let table = new Object()
            table.Id = $("#number").val()
            table.Seats = $("#seats").val()

            WebApplication.Tables.Save(table, closeModal)
        }

        function setTable(tableId) {
            WebApplication.Tables.SetTable(tableId, () => {
                location.href = location.href;
            })
        }

        function onModal(html) {
            document.getElementById("myModal").style.display = "block";
            $('.model-item').remove();
            $("#modalConteudo").append('<div class="model-item">' + html + '</div>')
        }

        function AddTable() {
            let html = `<div>
                            <div>
                                <h3>New Table</h3>                    
                            </div>
                            <div>
                                <input id="number" type='text' placeholder="Number"/>                    
                                <input id="seats" type='text' placeholder="Seats"/>
                            </div>
                            <div>
                                <input value='Save' onclick="Save()" type='button' />
                                <input onclick='closeModal()' value='Cancel' type='button' />
                            </div>
                        </div>
        `
            onModal(html)
        }

        function closeModal() {
            document.getElementById("myModal").style.display = "none";
            location.href = location.href;
        }
    </script>
    <table style="margin-bottom: 20px;">
        <tr>
            <td>
                <div style="display: grid; place-items: center; padding-top: 20px; margin-right: 10px;">
                    <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                        <div class="btnicon" style="display: grid; place-items: center; background-color: cadetblue; padding-top: 8px; width: 80px; border-radius: 1em;">

                            <div style="align-items: center;">
                                <label style="color: white">All</label>
                            </div>
                        </div>
                    </a>
                </div>
            </td>
            <td>
                <div style="display: grid; place-items: center; padding-top: 20px; margin-right: 10px;">
                    <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                        <div class="btnicon" style="display: grid; place-items: center; background-color: cadetblue; padding-top: 8px; width: 80px; border-radius: 1em;">

                            <div style="align-items: center;">
                                <label style="color: white">Occupied</label>
                            </div>
                        </div>
                    </a>
                </div>
            </td>
            <td>
                <div style="display: grid; place-items: center; padding-top: 20px;">
                    <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                        <div class="btnicon" style="display: grid; place-items: center; background-color: cadetblue; padding-top: 8px; width: 80px; border-radius: 1em;">

                            <div style="align-items: center;">
                                <label style="color: white">Vacant</label>
                            </div>
                        </div>
                    </a>
                </div>
            </td>

        </tr>
    </table>
    <div class="form-group">

        <div class="col-xs-10" style="padding-left: 0px; width: 300px;">
            <input class="bar-search" id="Text1" type="text" style="width: 400px;" />
        </div>
        <img id="btnBarcode" class="btnicon" src="Content/Image/search_icon.png" style="height: 30px;" />
        <input type="button" value="Add" onclick="AddTable()" />
    </div>
    <table>
        <tr class="">
            <%=Body() %>
        </tr>
    </table>
</asp:Content>
