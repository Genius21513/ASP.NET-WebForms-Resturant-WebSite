<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="WebApplication.Statistics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .customer-item {
            align-items: center;
            justify-content: space-between;
            display: inline-flex;
            width: 100%;
            padding: 7px;
            margin: 5px;
            background: floralwhite;
        }
    </style>
    <script>                
        function onModal(html) {
            document.getElementById("myModal").style.display = "block";
            $('.model-item').remove();
            $("#modalConteudo").append('<div class="model-item">' + html + '</div>');
        }

        function setValue(id, value) {
            $("#" + id).val(value);
        }

        function manualTransaction() {
            let amount = $("#amount").val();            
            let transactionType = $("#transactionType").val();
            let reference = $("#reference").val()

            WebApplication.Statistics.Manual(amount, transactionType, reference, closeModal);
        }

        function modalManualTransaction() {
            let html = `<div> 
                            <div>
                                <h3>Manual Transaction</h3>
                                <span>Select Transaction Type</span>
                                <input onclick="setValue('transactionType', 1)" value='In' type='button'/>
                                <input onclick="setValue('transactionType', 0)" value='Out' type='button'/>
                                <input id="transactionType" value='0' type='hidden'/>
                            </div>
                            <div>
                                <input id='amount' type="number" min="0.01" step="0.01" placeholder="Enter Amount">
                                <input id ='reference' type="text" placeholder="Enter Reason (Optional)"></div>
                            <div>
                                <input onclick='manualTransaction()' value='Add' type='button'/>
                                <input onclick='closeModal()' value='Cancel' type='button'/>
                            </div>
                        </div > `
            onModal(html)
        }

        function clickOpenCashDrawerAmount() {
            WebApplication.Statistics.OpenCashDrawerAmount($('#amount').val(), closeModal)
        }

        function modalOpenCashDrawerAmount(result) {
            debugger
            if (result.value) {
                let html = `<div> 
                                <div>
                                    <h3>Open Cash DrawerAmount</h3>                                                                
                                </div>
                                <div>
                                    <input id='amount' type="number" min="0.01" step="0.01" placeholder="Enter Amount">                                
                                </div>
                                <div>
                                    <input onclick='clickOpenCashDrawerAmount()' value='Add' type='button'/>
                                    <input onclick='closeModal()' value='Cancel' type='button'/>
                                </div>
                            </div > `
                onModal(html)
            }
        }

        function closeModal() {
            document.getElementById("myModal").style.display = "none";
            location.href = location.href;
        }

        WebApplication.Statistics.IsOpenCashDrawerAmount(modalOpenCashDrawerAmount);
    </script>
    
    <div class="row" style="margin-top: 40px;">
        <div class="col-sm-3">
            <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                <div class="card-body">
                    <div style="display: grid; place-items: center; padding-top: 8px;">
                        <label style="font-family: sans-serif; font-size: 1.17em;">Open Cash Drawer Amount</label>
                        <label style="color: red;">$<%=OpenCash.ToString() %></label>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-3">
            <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                <div class="card-body">
                    <div style="display: grid; place-items: center; padding-top: 8px;">
                        <label style="font-family: sans-serif; font-size: 1.17em;">Today's Cash Sale</label>
                        <label style="color: limegreen">$<%=CashSale.ToString() %></label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                <div class="card-body">
                    <div style="display: grid; place-items: center; padding-top: 8px;">
                        <label style="font-family: sans-serif; font-size: 1.17em;">Today's Total Sale</label>
                        <label style="color: midnightblue">$<%=TotalSale.ToString() %></label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                <div class="card-body">
                    <div style="display: grid; place-items: center; padding-top: 8px;">
                        <label style="font-family: sans-serif; font-size: 1.17em;">Expected Drawer Amount</label>
                        <label style="color: darkorange">$<%=DrawerAmount.ToString() %></label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h2>Today's Transactions</h2>

    <div class="col-xs-12" style="margin-left: 0px; padding-left: 0px; min-width: 100%">
        <div class="form-group">

            <div class="col-xs-10" style="padding-left: 0px;">
                <input id="Text1" placeholder="Search Transaction..." type="text" style="width: 100%; min-width: 100%;" />
            </div>
            <asp:ImageButton ID="btnPesquisar" ImageUrl="~/Content/Image/search_icon.png" class="btnicon" Style="height: 30px;" runat="server" />
            <span style="cursor:pointer" onclick="modalManualTransaction()">
                <img id="btnAdd" class="btnicon" src="Content/Image/plus.png" style="height: 30px;" />                
            </span>
        </div>
        <div style="overflow-y: auto; max-height: 480px">
            <asp:GridView ID="grdDados" runat="server" AutoGenerateColumns="false" Height="100%" Width="100%" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Transaction ID"
                        InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="OrdemId" HeaderText="Order ID"
                        InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                    <asp:TemplateField HeaderText="In">
                        <ItemTemplate>
                            <%#In(Eval("In").ToString())%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Out">
                        <ItemTemplate>
                            <%#Out(Eval("Out").ToString())%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="MethodId" HeaderText="Method"
                        InsertVisible="False" ReadOnly="True" SortExpression="MethodId" />
                    <asp:BoundField DataField="Reference" HeaderText="Reference"
                        InsertVisible="False" ReadOnly="True" SortExpression="Reference" />
                    <asp:BoundField DataField="At" HeaderText="Date"
                        InsertVisible="False" ReadOnly="True" SortExpression="At" />
                </Columns>
            </asp:GridView>
        </div>
    </div>


</asp:Content>
