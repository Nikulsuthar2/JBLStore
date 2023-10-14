<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="JBLStore.Admin.Orders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
            <div class="productheader">
                <asp:Label ID="Label1" runat="server" Text="Orders" Font-Bold="True" Font-Size="25px"></asp:Label>
            </div>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="OrderList" OnItemCommand="Repeater1_ItemCommand">
                <HeaderTemplate>
                    <table class="producttable" style="text-align:center;">
                        <tr>
                            <th>S.No.</th>
                            <th>Order ID</th>
                            <th>Customer Email</th>
                            <th>Total Price</th>
                            <th>Quantity</th>
                            <th>Date Time</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td><%# Eval("oid") %></td>
                        <td><%# Eval("email") %></td>
                        <td>&#8377;<%# Eval("totalprice") %></td>
                        <td><%# Eval("totalitem") %></td>
                        <td><%# Eval("datetime") %></td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("status") %>' ForeColor='<%# Eval("status").ToString() == "Completed" ? System.Drawing.Color.Green : System.Drawing.Color.Red %>' Font-Bold="True"></asp:Label></td>
                        <td>
                            <asp:Button ID="btnView" runat="server" CssClass="btnEdit" Text="View" CommandName="viewOrder" CommandArgument='<%# Eval("oid") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="OrderList" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.oid, b.email, a.totalprice, a.totalitem, a.datetime, a.status FROM order_dtl AS a INNER JOIN user_dtl AS b ON a.uid = b.uid ORDER BY a.datetime desc"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
