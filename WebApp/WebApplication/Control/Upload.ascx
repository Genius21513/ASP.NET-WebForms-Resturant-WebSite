<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebApplication.Control.Upload" CodeBehind="Upload.ascx.cs" %>
<%@ Register TagPrefix="WebApp" Namespace="WebApplication.Control" Assembly="WebApplication" %>
<div id="myModal2" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div>
            <h3>New Product</h3>
        </div>
        <asp:Label ID="Label2" runat="server" Text="Description"></asp:Label>
        <asp:TextBox ID="Description" runat="server"></asp:TextBox>
        <div>
            <asp:Label ID="Label3" runat="server" Text="Price"></asp:Label>
            <asp:TextBox ID="Price" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:FileUpload ID="imgProduct" runat="server" />
        </div>
        <div>
            <asp:Label ID="Label1" runat="server" Text="Category"></asp:Label>
            <asp:DropDownList ID="Category" runat="server"></asp:DropDownList>
        </div>
        <div>
            <asp:Button ID="save" runat="server" Text="Save" OnClick="save_Click" />
            <input onclick="closeNewProduct()" id="Button1" type="button" value="Cancel" />
        </div>
    </div>
</div>
