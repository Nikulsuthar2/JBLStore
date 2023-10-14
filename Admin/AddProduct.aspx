<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="JBLStore.Admin.AddProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
        <div class="productheader">
            <asp:Label ID="lblHeader" runat="server" Text="Add Product" Font-Bold="True" Font-Size="25px"></asp:Label>
            <asp:Button ID="btnBackProduct" runat="server" Text="Back to Product List" CausesValidation="False" OnClick="btnBackProduct_Click" CssClass="btnPrimary" />
        </div>
    <table align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="200px">
                <asp:Label ID="Label9" runat="server" Text="Type : "></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" CssClass="inputbox2" Width="90%">
                    <asp:ListItem>Speaker</asp:ListItem>
                    <asp:ListItem>Headset</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlType" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
            
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Model ID : "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtModelid" runat="server" CssClass="inputbox2" Width="90%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtModelid" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" Text="Model Name :  "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtName" runat="server" CssClass="inputbox2" Width="90%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Text="Price : "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" min="0" CssClass="inputbox2" Width="90%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPrice" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label5" runat="server" Text="Discount : "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtDiscount" runat="server" TextMode="Number" min="0" CssClass="inputbox2" Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label6" runat="server" Text="Descripton : "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="inputbox2" Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label8" runat="server" Text="Color : "></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlColor" runat="server" CssClass="inputbox2" Width="90%">
                    <asp:ListItem>Black</asp:ListItem>
                    <asp:ListItem>Blue</asp:ListItem>
                    <asp:ListItem>White</asp:ListItem>
                    <asp:ListItem>Red</asp:ListItem>
                    <asp:ListItem>Grey</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label10" runat="server" Text="Connectivity : "></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlConnectivity" runat="server" CssClass="inputbox2" Width="90%">
                    <asp:ListItem>Wired</asp:ListItem>
                    <asp:ListItem>Wireless</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblSubType" runat="server" Text="Speaker Type"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlSubType" runat="server" CssClass="inputbox2" Width="90%">
                    <asp:ListItem>Soundbar Speaker</asp:ListItem>
                    <asp:ListItem>Bluetooth Speaker</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label11" runat="server" Text="With Microphone :"></asp:Label>
            </td>
            <td>
                <asp:CheckBox ID="cbMic" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label13" runat="server" Text="Deep Bass : "></asp:Label>
            </td>
            <td>
                <asp:CheckBox ID="cbBass" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label14" runat="server" Text="Water Resistense : "></asp:Label>
            </td>
            <td>
                <asp:CheckBox ID="cbWaterResist" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label15" runat="server" Text="Other features : "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtFeature" runat="server" TextMode="MultiLine" CssClass="inputbox2" Width="90%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblQty" runat="server" Text="Quantity : "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtQty" runat="server" TextMode="Number" min="0" CssClass="inputbox2" Width="90%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvQty" runat="server" ControlToValidate="txtQty" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label7" runat="server" Text="Image : "></asp:Label>
            </td>
            <td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:RequiredFieldValidator ID="rfvImage" runat="server" ControlToValidate="FileUpload1" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">
                <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add" Visible="False" CssClass="btnEdit" Width="100%" />
                <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="Update" Visible="False" CssClass="btnEdit" Width="100%" />
            </td>
        </tr>
        <tr>
            
            <td colspan="2">
                &nbsp;</td>
        </tr>
    </table>
            </div>
        </div>
</asp:Content>
