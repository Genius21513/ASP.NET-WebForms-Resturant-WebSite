<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication.Home" %>
<%@ Register TagPrefix="WebApp" TagName="Upload" Src="~/Control/Upload.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        * {
            font-family: "OpenSans", sans-serif;
        }

        .imgcoll:after {
            font-family: "Glyphicons Halflings";
            content: "\e080";
            float: left;
            margin-left: 15px;
        }
        /* Icon when the collapsible content is hidden */
        .imgcoll.collapsed:after {
            content: "\e114";
        }


        .product-item {
            align-items: center;
            justify-content: space-between;
            display: inline-flex;
            width: 100%;
            cursor: pointer;
        }

        .item-space {
            align-items: center;
            justify-content: space-between;
            display: inline-flex;
            width: 100%;
        }

        .buttons {
            background-color: var(--pos-secondary-color);
            border-radius: 6px;
            box-shadow: 0 0 3px 0 rgba(0,0,0,.15);
            display: grid;
            margin: 0 10% 15px;
            padding: 10px;
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
        .key {
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
            cursor: pointer;
            font-weight: 600;
            padding: 20px 10px;
            text-align: center;
            box-shadow: 0 0 1px 1px var(--pos-layout-primary-color);
            color: var(--pos-layout-primary-color);
            transition: .2s ease;
            width: 90px;
        }
    </style>
    <script>                
        $(document).ready(function () {
            $("#pay").hide();
            $("#onPay").prop("disabled", true);
            $("#myTable").on('input', '.txtCal', function () {
                calc();
            });
        });

        function filter(categorie, id) {
            let filterText = categorie ?? $("#" + id).val().toLowerCase();

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

        function print() {
            let divToPrint = document.getElementById('cart');

            let newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);
        }

        function onModal(html) {
            document.getElementById("myModal").style.display = "block";
            $('.model-item').remove();
            $("#modalConteudo").append('<div class="model-item">' + html + '</div>');
        }

        function modalPay(order) {
            let html = `<div> 
                            <div>
                                <h3>Print Receipt</h3>
                                <p>Order #${order} is Completed.</p>                            
                            </div>
                            <div>
                                <input value='Print' onclick="print()" type='button'/>
                                <input onclick='closeModal()' value='Cancel' type='button'/>
                            </div>
                        </div > `
            onModal(html)
        }

        function modalCupom() {
            let html = `<div> 
                            <div>
                                <h3>Apply Coupon</h3>
                                <input type='text'/>
                            </div>
                            <div>
                                <input value='Add' type='button'/>
                                <input onclick='closeModal()' value='Cancel' type='button'/>
                            </div>
                        </div > `
            onModal(html)
        }

        function modalDiscount() {
            let html = `<div> 
                            <div>
                                <h3>Apply Discount</h3>
                                <input value='Fixed' type='button'/><input value='Percetage' type='button'/>
                            </div>
                            <div><input type='text'/></div>
                                <div>
                                    <input value='Add' type='button'/>
                                    <input onclick='closeModal()' value='Cancel' type='button'/>
                                </div>
                        </div > `
            onModal(html)
        }
        function setTable(tableId) {
            WebApplication.Home.SetTable(tableId, closeModal);
        }

        function goTable() {
            location.href = "/Tables.aspx";
        }

        function selectMode() {
            let html = `<div> 
                            <div>
                                <h3>Select Mode</h3>                                
                            </div>
                            <div>
                                <button onclick="setTable(0)">
                                    <img id="btnBarcode" class="btnicon" src="Content/Image/mesa.png" style="height: 30px;" />
                                    <p>
                                    Dine in
                                    </p>
                                </button>
                                <button onclick="goTable()">
                                    <img id="btnBarcode" class="btnicon" src="Content/Image/ordersicon.png" style="height: 30px;" />
                                    <p>Take Away
                                    </p>
                                </button>                                                              
                            </div>
                        </div > `
            onModal(html)
        }

        function newProduct() {
            document.getElementById("myModal2").style.display = "block";            
        }

        function closeNewProduct() {
            document.getElementById("myModal2").style.display = "none";
        }

        function SaveProduct() {
            debugger
            let product = new Object();
            product.Description = $("#modal_description").val()
            product.Price = $("#modal_price").val()
            product.CategoryId = $("#modal_category").val()  
            let formdata = new FormData();
            let file = $('#model_fileId')[0].files[0]
            formdata.append('file', file);
            WebApplication.Home.AddProduct(product, formdata, teste);
        }

        function teste(input) {
            debugger
        }

        function closeModal() {
            document.getElementById("myModal").style.display = "none";
            location.href = location.href;
        }
        function reset() {
            cart.Reset();
        }

        function processPayFinish() {
            cart.processPayFinish();
        }

        function calc() {
            $("#onPay").prop("disabled", true);
            let calculated_total_sum = 0;
            $("#myTable .txtCal").each(function () {
                let get_textbox_value = $(this).val();
                if ($.isNumeric(get_textbox_value)) {
                    calculated_total_sum += parseFloat(get_textbox_value);
                }
            });

            $("#hidTotalPay").val(calculated_total_sum);
            $("#lbTotalPay").text(calculated_total_sum);

            let left = $("#hidTotalDue").val() - calculated_total_sum;

            if (left <= 0) {
                $("#hidPayLeft").val(0);
                $("#lbPayLeft").text(0);

                $("#hidChange").val(left * -1);
                $("#lbChange").text(left * -1);

                $("#onPay").prop("disabled", false);
            } else {
                $("#hidPayLeft").val(left);
                $("#lbPayLeft").text(left);

                $("#hidChange").val(0);
                $("#lbChange").text(0);
            }
        }

        function processPay() {
            $("#pay").show();
            $('#listProduct').hide();
        }

        function AddCart(id) {
            cart.AddCart(id);
        }

        function Delete(id) {
            cart.Delete(id);
        }

        function Update(id) {
            cart.Update(id);
        }

        function AddHoldOrder() {
            cart.AddHoldOrder();
        }

        function updateTextbox(value) {
            document.getElementById("screen").value += value;
            calc();
        }

        const cart = {
            Start: () => {
                WebApplication.Home.Start(cart.onCharge_CallBack);
            },
            onCharge_CallBack: (data) => {
                let cart = data.value;
                $("#subtotal").text(cart.SubTotalString);
                $("#tax").text(cart.TaxString);
                $("#coupom").text(cart.AppliedCoupons);
                $("#discount").text(cart.DiscountString);
                $("#proceedtoPay").text(cart.ProceedtoPayString);
                $("#proceedtoPayQuant").text(cart.ProceedtoPayQuant);
                $('.cart-itens-product').remove();
                $("#cart-itens").append(cart.CartItensHtml);

                $("#hidTotalDue").val(cart.ProceedtoPay);
                $("#option1pay").val(cart.ProceedtoPay);
                $("#option2pay").val(Math.round(cart.ProceedtoPay));
                $("#option3pay").val(cart.ProceedtoPay);
                $("#option4pay").val(cart.ProceedtoPay);
                

                $("#lbTotalDue").text(cart.ProceedtoPayString);

                $("#hidPayLeft").val(cart.ProceedtoPay);
                $("#lbPayLeft").text(cart.ProceedtoPayString);

                calc();
            },
            AddCart: (id) => {
                WebApplication.Home.AddCart(id, cart.onCharge_CallBack);
            },
            AddCart_callBack: (data) => {
                $("#cart-itens").append(data.value);
            },
            Update: (id) => {
                let quant = $('#quantity-' + id).val();
                let price = $('#price-' + id).val();
                WebApplication.Home.Update(id, quant, price, cart.onCharge_CallBack);
            },
            Delete: (id) => {
                WebApplication.Home.Delete(id, cart.onCharge_CallBack);
            },
            processPayFinish: () => {
                debugger;
                let amount = $("#screen").val();
                WebApplication.Home.Pay(amount, cart.processPayFinish_CallBack);
            },
            processPayFinish_CallBack: (data) => {
                $("#pay").hide();
                $('#listProduct').show();
                let cart = data.value;
                modalPay(cart.Order)
                cart.onCharge_CallBack(data)
            },
            AddHoldOrder: () => {
                WebApplication.Home.AddHoldOrder(cart.onCharge_CallBack);
            }
            ,
            Reset: () => {
                WebApplication.Home.Reset(cart.onCharge_CallBack);
            }
        }

        cart.Start();
    </script>
    <table style="width: 99%;">
        <tr style="background-color: #f8f8f8; width: 100%;">
            <td id="listProduct" style="width:60%">
                <h2 id="labelSelectCate" runat="server">Select Category</h2>
                <table id="category" runat="server">
                    <tr>                        
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image5" runat="server" ImageUrl="~/Content/Image/database.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>All</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a onclick="filter('Clothing', 'Text1')" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image2" runat="server" ImageUrl="~/Content/Image/clothing-category.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>Clothing</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a onclick="filter('Hoodies', 'Text1')" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image3" runat="server" ImageUrl="~/Content/Image/hoodies-category.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>Hoodies</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a onclick="filter('Tshirts', 'Text1')" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image4" runat="server" ImageUrl="~/Content/Image/tshirt-category.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>Tshirts</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a onclick="filter('Acessories', 'Text1')" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image6" runat="server" ImageUrl="~/Content/Image/accessories-category.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>Acessories</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a onclick="filter('Music', 'Text1')" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image7" runat="server" ImageUrl="~/Content/Image/music-category.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>Music</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                        <td>
                            <div style="display: grid; place-items: center; padding-top: 20px;">
                                <a onclick="filter('Posters', 'Text1')" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                        <div>
                                            <asp:Image ID="Image8" runat="server" ImageUrl="~/Content/Image/posters.png" Style="height: 30px;" ImageAlign="Middle" />
                                        </div>
                                        <div style="align-items: center;">
                                            <label>Posters</label>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </td>
                    </tr>
                </table>                
                <h2>Products</h2>
                <table style="width: 90%">
                    <tr>
                        <td>
                            <WebApp:Upload ID="upload" runat="server" />
                            <div>
                                <input id="Text1" type="search" onchange="filter(null, 'Text1')" class="bar-search" />
                                <img id="btnBarcode" class="btnicon" src="Content/Image/search_icon.png" style="height: 30px;" />
                                <button type="button" onclick="newProduct()">
                                    <img class="btnicon" src="Content/Image/plus.png" style="height: 30px;">
                                </button>
                            </div>                            
                            <%--<asp:ImageButton ID="btnBarcode" ImageUrl="~/Content/Image/barcode.png" Style="height: 30px;" runat="server" />--%>                            
                            <asp:Panel ID="panel1" runat="server" Height="400px" Width="100%" ScrollBars="Vertical">
                                <asp:GridView ID="grdDados"
                                    runat="server"
                                    AutoGenerateColumns="false"
                                    Height="100%"
                                    Width="100%"
                                    GridLines="None">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <%#FormateProuct(Eval("Id").ToString(),Eval("Description").ToString(), Eval("Price").ToString(), Eval("UrlImg").ToString())%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>

            </td>
            <td id="pay" style="width:60%">
                <div>
                    <table style="width: 98%">
                        <tr>
                            <td>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                                            <div class="card-body">
                                                <div style="display: grid; place-items: center; padding-top: 8px;">
                                                    <label style="font-family: sans-serif; font-size: 1.17em;">Total Due</label>
                                                    <label id="lbTotalDue" style="color: red;">$0.00</label>
                                                    <input id="hidTotalDue" value="0" type="number" style="display: none" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                                            <div class="card-body">
                                                <div style="display: grid; place-items: center; padding-top: 8px;">
                                                    <label style="font-family: sans-serif; font-size: 1.17em;">Total Paying</label>
                                                    <label id="lbTotalPay" style="color: limegreen">$0.00</label>
                                                    <input id="hidTotalPay" value="0" type="number" style="display: none" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                                            <div class="card-body">
                                                <div style="display: grid; place-items: center; padding-top: 8px;">
                                                    <label style="font-family: sans-serif; font-size: 1.17em;">Pay Left</label>
                                                    <label id="lbPayLeft" style="color: midnightblue">$0.00</label>
                                                    <input id="hidPayLeft" value="0" type="number" style="display: none" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="card" style="background-color: #fff; border: 1px solid #cfcfcf; border-radius: 1em;">
                                            <div class="card-body">
                                                <div style="display: grid; place-items: center; padding-top: 8px;">
                                                    <label style="font-family: sans-serif; font-size: 1.17em;">Change</label>
                                                    <label id="lbChange" style="color: darkorange">$0.00</label>
                                                    <input id="hidChange" value="0" type="number" style="display: none" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row buttons">
                                    <table id="myTable">
                                        <tr>
                                            <td>Amount</td>
                                            <td>Method</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input id="screen" class="txtCal" type="number" /></td>
                                            <td>
                                                <select>
                                                    <option>Cash on Delivery</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input style="width: 100%; display:none" type="button" value="Add Another Payment Method" />
                                            </td>

                                        </tr>
                                    </table>
                                </div>

                                <div class="row buttons">
                                    <textarea></textarea>
                                </div>
                                <div class="row buttons">
                                    <div>
                                        <input id="option1pay" class="key" value="0" type="button" onclick="updateTextbox(this.value)"/>
                                        <input id="option2pay" class="key" value="0" type="button" onclick="updateTextbox(this.value)"/>
                                        <input id="option3pay" class="key" value="0" type="button" onclick="updateTextbox(this.value)"/>
                                        <input id="option4pay" class="key" value="0" type="button" onclick="updateTextbox(this.value)"/>
                                    </div>
                                    <div>
                                        <input class="key" value="1" type="button" onclick="updateTextbox(this.value)" />
                                        <input class="key" value="2" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="3" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="clear" type="button" />
                                    </div>
                                    <div>
                                        <input class="key" value="4" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="5" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="6" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="back" type="button" />
                                    </div>
                                    <div>
                                        <input class="key" value="7" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="8" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="9" type="button" onclick="updateTextbox(this.value)"/>
                                        <input id="onPay" onclick="processPayFinish()" class="key" value="Pay" type="button" />
                                    </div>
                                    <div>
                                        <input class="key" value="0" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="." type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="00" type="button" onclick="updateTextbox(this.value)"/>
                                        <input class="key" value="Cancel" type="button" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 40%; padding-top: 10px;">
                <div style="">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 20px;">
                                <div style="display: grid; place-items: center;">
                                    <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                                        <div class="btnicon" style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 40px; border-radius: 1em;">
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Image/wifi.png" Style="height: 20px;" ImageAlign="Middle" />
                                        </div>
                                    </a>
                                </div>
                            </td>
                            <td style="width: 20px;">
                                <div style="display: grid; place-items: center;">
                                    <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                                        <div class="btnicon" style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 40px; border-radius: 1em;">
                                            <asp:Image ID="Image9" runat="server" ImageUrl="~/Content/Image/sync.png" Style="height: 20px;" ImageAlign="Middle" />
                                        </div>
                                    </a>
                                </div>
                            </td>
                            <td style="width: 50%; padding-right: 10px; ">
                                <a href="Customers.aspx" style="padding: 0px; height: 30px; margin: 0px; z-index: 10;">
                                    <div style="display: grid; place-items: center; background-color: #027491; border-radius: 1em;">
                                        <div style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 200px; border-radius: 1em;">
                                            <table>
                                                <tr>                                                    
                                                    <td style="padding-left: 5px;">
                                                        <label runat="server" id="customerName" style="color: white; padding-top: 5px; height: 20px;">Gavin Belson</label>                                                        
                                                    </td>
                                                    <td>
                                                        <asp:Image ID="Image11" runat="server" ImageUrl="~/Content/Image/edit.png" Style="padding-left: 5px; height: 20px;" ImageAlign="Middle" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </a>

                            </td> 
                            <td style="width: 50%;">
                                <a onclick="selectMode()" style="padding: 0px; margin: 0px; height: 30px; z-index: 10;">
                                    <div style="display: grid; place-items: center; background-color: #027491; border-radius: 1em;">
                                        <div style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 200px; border-radius: 1em;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Image ID="Image110" runat="server" ImageUrl="~/Content/Image/mesa.png" Style="height: 20px; padding-right: 5px;" ImageAlign="Middle" />
                                                    </td>
                                                    <td style="padding-left: 5px;">
                                                        <label id="lbTable" runat="server"   style="color: white; padding-top: 5px;"> <%=LabelTable%></label>
                                                    </td>
                                                    <td>
                                                        <asp:Image ID="Image111" runat="server" ImageUrl="~/Content/Image/edit.png" Style="padding-left: 5px; height: 20px;" ImageAlign="Middle" />
                                                    </td>
                                                </tr>
                                            </table>

                                        </div>
                                    </div>
                                </a>

                            </td>
                        </tr>
                    </table>
                </div>
                <hr />

                <div style="margin-top: 0px;">
                    <table>
                        <tr>
                            <td>

                                <asp:Image ID="Image13" runat="server" ImageUrl="~/Content/Image/shoppingcart_120371.png" Style="height: 20px; padding-right: 6px; padding-left: 6px;" ImageAlign="Middle" />


                            </td>
                            <td>
                                <h2 style="padding-top: 0px; padding-bottom: 0px; margin-top: 0px; margin-bottom: 0px;">Cart Items</h2>
                            </td>
                            <td style="width: 60%"></td>
                            <td>
                                <a href="Home.aspx" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="height: 25px">
                                        <asp:Image ID="Image15" runat="server" ImageUrl="~/Content/Image/pause.png" Style="height: 20px; padding-top: 2px; padding-right: 2px; padding-left: 2px; padding-bottom: 2px;"
                                            ImageAlign="Middle" />
                                    </div>
                                </a>
                            </td>
                            <td>
                                <a onclick="reset()" style="padding: 0px; margin: 0px;">
                                    <div class="btnicon" style="height: 25px">
                                        <asp:Image ID="Image17" runat="server" ImageUrl="~/Content/Image/redo.png" Style="height: 20px; padding-top: 2px; padding-right: 2px; padding-left: 2px; padding-bottom: 2px;"
                                            ImageAlign="Middle" />
                                    </div>
                                </a>
                            </td>

                        </tr>
                    </table>
                    <div style="overflow-y: auto; max-height: 300px; min-height: 27rem;">
                        <table id="cart" style="min-width: 100%;">
                            <tbody id="cart-itens"></tbody>
                        </table>
                    </div>
                </div>
                <hr />
                <div style="min-height: 100px; padding-left: 5px;">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 80%;">
                                <label>Subtotal</label></td>
                            <td style="width: 20%;">
                                <label id="subtotal">$91.00</label></td>
                        </tr>
                        <tr>
                            <td style="width: 80%;">
                                <label>Tax</label></td>
                            <td style="width: 20%;">
                                <label id="tax">$9.10</label></td>
                        </tr>

                        <tr>
                            <td style="width: 80%;">
                                <label>Discount</label></td>
                            <td style="width: 20%;">
                                <label id="discount">$0.00</label></td>
                        </tr>
                        <tr>
                            <td style="width: 80%;">
                                <label>Applied Coupon(s)</label></td>
                            <td style="width: 20%;">
                                <label id="coupom">N/A</label></td>
                        </tr>

                    </table>
                </div>
                <div style="min-height: 100px; padding-left: 5px;">
                    <div class="col-xs-12" style="margin-left: 0px; height: 100px; padding-left: 0px;">
                        <div class="form-group">


                            <div class="col-xs-4" style="padding-left: 2px; height: 100px; padding-right: 2px;">
                                <div class="menu" style="display: grid; place-items: center; padding-top: 10px; background-color: #f1eeee; border-radius: 1em;">
                                    <a onclick="modalCupom()" style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                            <div>
                                                <asp:Image ID="Image12" runat="server" ImageUrl="~/Content/Image/pricetag_5103.png" Style="height: 30px;" ImageAlign="Middle" />
                                            </div>
                                            <div style="align-items: center;">
                                                <label>Coupon</label>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xs-4" style="padding-left: 2px; height: 100px; padding-right: 2px;">
                                <div class="menu" style="display: grid; place-items: center; padding-top: 10px; background-color: #f1eeee; border-radius: 1em;">
                                    <a onclick="modalDiscount()" style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                            <div>
                                                <asp:Image ID="Image14" runat="server" ImageUrl="~/Content/Image/percentage_3155.png" Style="height: 30px;" ImageAlign="Middle" />
                                            </div>
                                            <div style="align-items: center;">
                                                <label>Discount</label>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="col-xs-4" style="padding-left: 2px; height: 100px; padding-right: 2px;">
                                <div class="menu" style="display: grid; place-items: center; padding-top: 10px; background-color: #f1eeee; border-radius: 1em;">
                                    <a onclick="AddHoldOrder()" style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; padding-top: 8px; width: 80px; border-radius: 1em;">
                                            <div>
                                                <asp:Image ID="Image16" runat="server" ImageUrl="~/Content/Image/pause.png" Style="height: 30px;" ImageAlign="Middle" />
                                            </div>
                                            <div style="align-items: center;">
                                                <label>Hold Order</label>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>


                </div>
                <div onclick="processPay()" class="button-pay" style="cursor: pointer; min-height: 50px; padding-left: 5px;">
                    <div style="padding: 0px; margin: 0px;">
                        <div class="col-xs-12" style="margin-left: 0px; height: 80px; padding-left: 0px; border-radius: 1em; background-color: #027494;">
                            <div class="form-group">
                                <div class="col-xs-8" style="padding-left: 2px; height: 200px; padding-right: 2px;">
                                    <div class="menu" style="display: grid; padding-left: 5px; padding-top: 10px;">
                                        <div style="display: grid; padding-top: 8px; margin-left: 0px;">
                                            <div style="align-items: start;">
                                                <label style="color: white;">Proceed to Pay</label>
                                            </div>
                                            <div style="align-items: start;">
                                                <label id="proceedtoPayQuant" style="color: white;">3</label>
                                                <label style="color: white;">Items</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div  class="col-xs-4" style=" padding-left: 2px; height: 100px; padding-right: 2px;">
                                    <div style="display: grid; place-items: center; padding-top: 10px; color: white">
                                        <div class="col-xs-12" style="display: grid; padding-top: 8px;">
                                            <div class="form-group" style="min-width: 100%;">
                                                <div class="col-xs-4" style="padding-left: 2px; height: 100px; padding-right: 60px; padding-top: 5px; }">
                                                    <label id="proceedtoPay">$100.00 </label>
                                                </div>
                                                <div class="col-xs-4" style="padding-left: 2px; height: 100px; padding-right: 2px;">
                                                    <asp:Image ID="Image129" runat="server" ImageUrl="~/Content/Image/double-arrow.png" Style="height: 30px;" ImageAlign="Middle" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>