<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UpdateStock.aspx.cs" Inherits="JBLStore.Admin.UpdateStock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
            <div class="productheader">
                <asp:Label ID="Label3" runat="server" Text="Manage Stocks" Font-Bold="True" Font-Size="25px"></asp:Label>
                <asp:Button ID="btnBackStock" CssClass="btnPrimary" runat="server" Text="Back to Stock" onClick="btnBackStock_Click"/>
            </div>
            <table align="center" style="width:300px;border:1px solid;padding:20px;border-radius:10px;" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="2"><asp:Image ID="imgProduct" runat="server" width="100%"/></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Pid : "></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="lblPid" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="In Stock : "></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="lblQty" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox ID="txtQty" runat="server" CssClass="inputbox" min="0" TextMode="Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" >
                        <div style="display:flex;gap:5px">
                            <asp:Button ID="btnSet" Width="100%" runat="server" OnClick="btnSet_Click" Text="Set" CssClass="btnPrimary" />
                            <asp:Button ID="btnAdd" Width="100%" runat="server" OnClick="btnAdd_Click" Text="Add" CssClass="btnPrimary"/>
                            <asp:Button ID="btnRemove" Width="100%" runat="server" OnClick="btnRemove_Click" Text="Remove" CssClass="btnPrimary"/>
                        </div>
                        
                    </td>
                </tr>
            </table>

        </div>
    </div>
</asp:Content>
