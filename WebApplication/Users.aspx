<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="WebApplication.Users" %>

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
            margin-left: 10px;
        }
    </style>
    <script>
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

        function Save() {
            let user = new Object();

            user.Id = $("#hidId").val();
            user.UserName = $("#txtUserName").val();
            user.FirstName = $("#txtFirstName").val();
            user.LastName = $("#txtLastName").val();
            user.Email = $("#txtEmail").val();
            user.HasPw = $("#txtHasPw").val();

            WebApplication.Users.Save(user, () => {
                location.href = location.href;
            });
        }

        function Edit(id) {
            WebApplication.Users.Get(id, Edit_CallBack);
        }

        function Edit_CallBack(data) {
            let user = data.value;

            $("#hidId").val(user.Id);
            $("#txtFirstName").val(user.FirstName);
            $("#txtLastName").val(user.LastName);
            $("#txtEmail").val(user.Email);
            $("#txtUserName").val(user.UserName);
        }

        function Delete(id) {
            alert('Are you sure you want to delete this customer?')
            WebApplication.Users.Delete(id, Delete_CallBack);
        }

        function Delete_CallBack() {
            location.href = location.href;
        }

        function SetCustomer(event, id) {
            $('.customer').val('Set Customer');
            event.value = 'Current Customer';
            WebApplication.Users.SetCustomer(id);
        }

    </script>
    <table style="width: 100%;">
        <tr style="margin-top: 0px;">
            <td style="background-color: #f8f8f8; width: 50%;">
                <div>

                    <h2>Users</h2>
                    <table style="min-width: 100%">
                        <tr>
                            <td style="width: 100%;">
                                <div class="form-horizontal">
                                    <div class="col-xs-12" style="margin-left: 0px; padding-left: 0px; min-width: 100%">
                                        <div class="form-group">

                                            <div class="col-xs-10" style="padding-left: 0px;">
                                                <input class="bar-search" id="Text1" onchange="filter('1', 'Text1')" type="text" style="width: 100%; min-width: 100%;" />
                                            </div>
                                            <img id="btnBarcode" class="btnicon" src="Content/Image/search_icon.png" style="height: 30px;" />
                                        </div>
                                        <div style="overflow-y: auto; max-height: 480px">
                                            <asp:GridView ID="grdDados" runat="server" AutoGenerateColumns="false" Height="100%" Width="100%" GridLines="None">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <%#FormateLine(Eval("Id").ToString(), 
                                                                           Eval("FirstName").ToString(), 
                                                                           Eval("Email").ToString())%>
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
                <h2>Add New User</h2>
                <table style="min-width: 100%;">
                    <tr>
                        <td style="display: none">
                            <div class="form-group">
                                <input type="number" value="0" id="hidId" />
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>First Name</label>
                                <input type="text" class="form-control" id="txtFirstName" name="txtFirstName" placeholder="Enter First Name">
                            </div>
                        </td>
                        <td>
                            <div class="form-group">
                                <label>Last Name</label>
                                <input type="text" class="form-control" id="txtLastName" name="txtLastName" placeholder="Enter Last Name">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" class="form-control" id="txtEmail" style="min-width: 100%;" name="txtEmail" placeholder="Enter Email">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="text" class="form-control" style="min-width: 100%;" id="txtHasPw" name="txtHasPw" placeholder="Enter Phone Number">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-group">
                                <label>Confirm Password</label>
                                <input type="password" class="form-control" style="min-width: 100%;" id="txtConfirmPassword" name="txtConfirmPassword" placeholder="Enter Confirm Password">
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-group">
                                <label>User Name</label>
                                <input type="text" class="form-control" style="min-width: 100%;" id="txtUserName" name="txtUserName" placeholder="Enter Address Line 2">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" style="padding-bottom: 10px;">
                            <button onclick="Save()" style="padding: 0px; margin: 0px; z-index: 10;">
                                <div style="display: grid; place-items: center; background-color: #027491; border-radius: 1em;">
                                    <div style="display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 200px; border-radius: 1em;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Image ID="Image10" runat="server" ImageUrl="~/Content/Image/save.png" Style="height: 20px; padding-right: 5px;" ImageAlign="Middle" />
                                                </td>
                                                <td style="padding-left: 5px;">
                                                    <label style="color: white; padding-top: 5px;">Save</label>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>
                            </button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
