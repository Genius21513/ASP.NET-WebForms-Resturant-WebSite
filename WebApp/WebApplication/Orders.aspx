<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="WebApplication.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .customer-item {
            align-items: center;
            justify-content: space-between;
            display: inline-flex;
            width: 100%;            
            padding: 7px;
            cursor: pointer;
            margin: 5px;
            background: floralwhite;
        }

        .bar-search {
            --pos-layout-primary-color: #027491;
            --pos-layout-secondary-color: #2190ac;
            --pos-layout-font-color: #fff;
            --pos-font-color: #555;
            --pos-secondary-color: #fff;
            --pos-grey-background: #f8f8f8;
            --pos-layout-font-size: 14px;
            --pos-height: 100vh;
            box-sizing: border-box;
            margin: 0;
            font-family: "OpenSans", sans-serif;
            background-color: var(--pos-secondary-color);
            border: 0;
            border-radius: 6px;
            box-shadow: 0 0 3px 0 rgba(0,0,0,.15);
            font-size: var(--pos-layout-font-size);
            outline: 0;
            padding: 12px;
            width: 100%;
            margin-left:10px;
        }
    </style>

    <script type="text/javascript">
        function filter(columnIndex, id) {
            let filterText = $("#" + id).val().toLowerCase();

            $("#<%=grdDados.ClientID%> tr:has(td)").each(function () {
                debugger;
                let result = this.innerText.toLowerCase().indexOf(filterText)


                if (result == -1) {
                    $(this).css('display', 'none');
                }
                else {
                    $(this).css('display', '');
                }
            });
        }
        function select(event, id) {
            let email = event.childNodes[1].childNodes[8].textContent;
            let order = event.childNodes[1].childNodes[1].textContent;
            $("#orderCode").text(order);
            $("#customerEmail").text(email);     
            orderList.Select(id);
        }

        function print() {
            let divToPrint = document.getElementById('list-ordem');

            let newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);
        }

        //function print(id) {
        //    orderList.Print(id);
        //}

        function refund(id) {
            orderList.Refund(id);
        }

        const orderList = {
            OrderCode: '<%= OrderCode%>',
            Email: '<%= CustomerEmail%>',
            Select: (id) => {
                WebApplication.Orders.Select(id, orderList.onCharge_CallBack);
            },
            Print: (id) => {
                WebApplication.Orders.Print(id, orderList.onCharge_CallBack);
            },
            Refund: (id) => {
                WebApplication.Orders.Refund(id, orderList.onCharge_CallBack);
            },
            onCharge_CallBack: (data) => {                                
                $('.list-item').remove();
                $("#list-ordem").append('<div class="list-item">' + data.value + '</div>');

                $("#lbSubTotal").text('$'+$("#_Subtotal").val())
                $("#lbTax").text('$' +$("#_Tax").val())
                $("#lbDiscount").text('$' +$("#_Discount").val())
                $("#lbApplied").text('$' +$("#_Applied").val())
                $("#lbTotal").text('$' +$("#_Total").val())
                $("#lbRefunded").text('$' +$("#_Refunded").val())
                $("#lbCashonDelivery").text('$' +$("#_CashonDelivery").val())
                $("#lbChange").text('$' +$("#_Change").val())
            },
            Start: () => {                
                $("#orderCode").text(orderList.OrderCode);
                $("#customerEmail").text(orderList.Email);                
                
                WebApplication.Orders.Start('<%= OrderId%>', orderList.onCharge_CallBack);
            }
        }

        orderList.Start();
    </script>
    <table style="width: 100%;">
        <tr style="margin-top: 0px;">
            <td style="background-color: #f8f8f8; width: 50%;">
                <div>

                    <table style="margin-top: 5px;">
                        <tr>
                            <td>
                                <div class="btnbackgroundcolor" style="padding: 0px; margin: 0px; border-radius: 1em; border-radius: 25px; height: 36px; border: 1px solid black;">
                                    <a href="Statistics.aspx" style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">

                                            <div style="align-items: center;">
                                                <label>Online</label>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </td>
                            <%--<td style="padding-left: 5px; padding-right: 5px;">
                                <div class="btnbackgroundcolor" style="padding: 0px; margin: 0px; border-radius: 1em; border-radius: 25px; height: 36px; border: 1px solid black;">
                                    <a href="Statistics.aspx" style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">

                                            <div style="align-items: center;">
                                                <label>Offline</label>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </td>
                            <td>
                                <div class="btnbackgroundcolor" style="padding: 0px; margin: 0px; border-radius: 1em; border-radius: 25px; height: 36px; border: 1px solid black;">
                                    <a href="Statistics.aspx" style="padding: 0px; margin: 0px; border-radius: 1em;">
                                        <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">

                                            <div style="align-items: center;">
                                                <label>Hold</label>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </td>--%>
                        </tr>
                    </table>
                    <hr />
                    <table style="min-width: 100%">
                        <tr>
                            <td style="width: 80%;">
                                <div class="form-horizontal">
                                    <div class="col-xs-12" style="margin-left: 0px; padding-left: 0px; width: 100%">
                                        <div class="form-group">
                                            <div class="col-xs-10" style="padding-left: 0px;">
                                                <input id="Text1"  onchange="filter('1', 'Text1')" placeholder="Search Order..." type="search" class="bar-search" />
                                                <img id="btnBarcode" class="btnicon" src="Content/Image/search_icon.png" style="height: 30px;" />
                                            </div>
                                        </div>
                                        <div style="overflow-y: auto; max-height: 480px">
                                            <asp:GridView ID="grdDados" runat="server" AutoGenerateColumns="false" Height="100%" Width="100%" GridLines="None">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <%#FormateLine(Eval("Id").ToString(),Eval("OrdemId").ToString(),Eval("At").ToString(), Eval("email").ToString(), Eval("total").ToString(), Eval("quant").ToString())%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="min-height: 100%;"></div>
            </td>
            <td style="width: 50%; padding-top: 10px; padding-left: 5px;">
                <table style="min-width: 100%">
                    <tr>
                        <td>
                            <div class="btnbackgroundcolor" style="background-color: #027494; width: 150px; height: 36px;">
                                <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                    <div style="align-items: center;">
                                        <label id="orderCode" name="lblOrder" style="color: white;"><%=OrderCode %></label>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td style="min-width: 100%"></td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image1" runat="server" Height="14px" ImageUrl="~/Content/Image/user.png" /></td>
                                    <td>
                                        <label id="customerEmail" name="lblEmail" style="color: black; padding-top: 4px; padding-left: 5px;"><%= CustomerEmail%></label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <hr />
                <div style="height: 200px">
                    <div id ="list-ordem">

                    </div>
                </div>
                <hr />

                <div style="min-height: 100px; padding-left: 5px;">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 80%;">
                                <label>Subtotal</label></td>
                            <td style="width: 20%;">
                                <label id="lbSubTotal">$10,151.00</label></td>
                        </tr>
                        <tr>
                            <td style="width: 80%;">
                                <label>Tax</label></td>
                            <td style="width: 20%;">
                                <label id="lbTax">$1,015.10</label></td>
                        </tr>

                        <tr>
                            <td style="width: 80%;">
                                <label>Discount</label></td>
                            <td style="width: 20%;">
                                <label id="lbDiscount">$0.00</label></td>
                        </tr>
                        <tr>
                            <td style="width: 80%;">
                                <label>Applied Coupon(s)</label></td>
                            <td style="width: 20%;">
                                <label id="lbApplied" >N/A</label></td>
                        </tr>

                        <tr>
                            <td style="width: 80%;">
                                <label style="color: darkblue; font-size: large;">Total</label></td>
                            <td style="width: 20%;">
                                <label id="lbTotal" style="color: darkblue; font-size: large;">$11,166.10</label></td>
                        </tr>
                        <tr>
                            <td style="width: 80%;">
                                <label style="color: limegreen; font-size: medium;">Refunded</label></td>
                            <td style="width: 20%;">
                                <label id="lbRefunded" style="color: limegreen; font-size: large;">$0.00</label></td>
                        </tr>

                        <tr>
                            <td style="width: 80%;">
                                <label style="">Cash on Delivery</label></td>
                            <td style="width: 20%;">
                                <label id="lbCashonDelivery" style="font-size: large;">$11,166.10</label></td>
                        </tr>
                        <tr>
                            <td style="width: 80%;">
                                <label style="">Change</label></td>
                            <td style="width: 20%;">
                                <label id="lbChange" style="font-size: large;">$0.00</label></td>
                        </tr>
                    </table>
                </div>

                <div>
                    <a onclick="print()" style="padding: 0px; margin: 0px; z-index: 10;">
                        <div style="display: grid; place-items: center; background-color: #027491; border-radius: 1em;">
                            <div style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 200px; border-radius: 1em;">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Image ID="Image120" runat="server" ImageUrl="~/Content/Image/print.png" Style="height: 20px; padding-right: 5px;" ImageAlign="Middle" />
                                        </td>
                                        <td style="padding-left: 5px;">
                                            <label style="color: white; padding-top: 5px;">Print Invoice</label>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </a>
                </div>
                <%--<div style="margin-top: 5px;">
                    <a style="padding: 0px; margin: 0px; z-index: 10;">
                        <div style="display: grid; place-items: center; background-color: limegreen; border-radius: 1em;">
                            <div style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 200px; border-radius: 1em;">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Image ID="Image130" runat="server" ImageUrl="~/Content/Image/redo-2-64.png" Style="height: 20px; padding-right: 5px;" ImageAlign="Middle" />
                                        </td>
                                        <td style="padding-left: 5px;">
                                            <label style="color: white; padding-top: 5px;">Refund</label>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </a>
                </div>--%>

            </td>
        </tr>
    </table>
</asp:Content>
