<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebApplication.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        WebApplication.Settings.GetData(GetData_callback);

        function GetData_callback(data) {
            $('#selCategoryCars').val(data.value.DisplayCategoryCards ? 'Enabled' : 'Disabled');
            $('#selSounds').val(data.value.EnableSounds ? 'Enabled' : 'Disabled');
            $('#txtPageHeight').val(data.value.PageHeight);
            $('#txtPageWidth').val(data.value.PageWidth);
            $('#txtPageMargin').val(data.value.PageMargin);

            $('#txtFirstName').val(data.value.User.FirstName);
            $('#txtLastName').val(data.value.User.LastName);
            $('#txtEmail').val(data.value.User.Email);
        }
    </script>
    <table style="width: 100%;">
        <tr style="margin-top: 0px;">
            <td style="background-color: #f8f8f8; width: 50%; padding-right: 15px;">
                <div style="margin-top: 0px; background-color: #fff; padding-top: 10px; padding-right: 10px; padding-left: 10px; padding-bottom: 10px;">
                    <h2>Outlet Settings</h2>
                    <table style="min-width: 100%; margin-top: 0px;">
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>Display Category Cards</label>
                                    <select class="form-control" style="min-width: 100%;" id="selCategoryCars">
                                        <option>Enabled</option>
                                        <option>Disabled</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>Enable Sounds</label>
                                    <select class="form-control" style="min-width: 100%;" id="selSounds">
                                        <option>Enabled</option>
                                        <option>Disabled</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>Page Width (in mm)</label>
                                    <input type="text" class="form-control" id="txtPageWidth" style="min-width: 100%;" name="txtPageWidth">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>Page Height (in mm)</label>
                                    <input type="text" class="form-control" style="min-width: 100%;" id="txtPageHeight" name="txtPageHeight">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>Page Margin (in mm)</label>
                                    <input type="text" class="form-control" style="min-width: 100%;" id="txtPageMargin" name="txtPageMargin">
                                </div>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                                <div class="form-group">
                                    <label>Reset Outlet Data</label>

                                </div>
                            </td>
                            <td>


                                <div class="btnicon" style="padding: 0px; margin: 0px; border-radius: 1em; border-radius: 25px; height: 36px; border: 1px solid black;">
                                    <a style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; border-radius: 1em;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/Content/Image/redo.png" Style="height: 14px; padding-right: 5px;" ImageAlign="Middle" />
                                                    </td>
                                                    <td style="padding-left: 5px; padding-top: 5px;">
                                                        <label>Reset</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <label>Switch Outlet</label>

                                </div>
                            </td>
                            <td>
                                <div class="btnicon" style="padding: 0px; margin: 0px; border-radius: 1em; border-radius: 25px; height: 36px; border: 1px solid black;">
                                    <a style="padding: 0px; margin: 0px;">
                                        <div style="display: grid; place-items: center; border-radius: 1em;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Image/swap.png" Style="height: 14px; padding-right: 5px;" ImageAlign="Middle" />
                                                    </td>
                                                    <td style="padding-left: 5px; padding-top: 5px;">
                                                        <label>Switch</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </a>
                                </div>
                            </td>
                        </tr>--%>

                    </table>
                </div>
            </td>
            <td style="background-color: #f8f8f8; width: 50%; padding-top: 10px; padding-left: 15px;">
                <div style="margin-top: 0px; background-color: #fff; padding-top: 10px; padding-right: 10px; padding-left: 10px; padding-bottom: 10px;">
                    <h2>Account Settings</h2>
                    <table style="min-width: 100%;">
                        <tr>
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
                                    <input type="text" readonly class="form-control" id="txtEmail" style="min-width: 100%;" name="txtEmail" placeholder="Enter Email">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>Current Password</label>
                                    <input type="password" class="form-control" style="min-width: 100%;" id="txtPassword" name="txtPassword1" placeholder="Enter Current Password">
                                </div>
                            </td>
                        </tr>                       
                        <tr>
                            <td colspan="2">
                                <div class="form-group">
                                    <label>New Password</label>
                                    <input type="password" class="form-control" style="min-width: 100%;" id="txtNewPassword" name="txtNewPassword" placeholder="Enter New Password">
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
                            <td colspan="2" style="padding-bottom: 10px;">
                                <a href="Customers.aspx" style="padding: 0px; margin: 0px; z-index: 10;">
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
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
