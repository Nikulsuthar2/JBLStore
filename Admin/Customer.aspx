<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="JBLStore.Admin.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
            <div class="productheader">
                <asp:Label ID="Label1" runat="server" Text="Customers" Font-Bold="True" Font-Size="25px"></asp:Label>
            </div>
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
                     <table class="stocktable" border="1" style="text-align:center">
                        <tr>
                            <th>S. NO.</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Mobile No.</th>
                            <th>Address</th>
                            <th>Total Puchesed Items</th>
                            <th>Total Spend</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1  %></td>
                        <td><%# Eval("name")  %></td>
                        <td><%# Eval("email")  %></td>
                        <td><%# Eval("mobileno")  %></td>
                        <td><%# Eval("address")  %></td>
                        <td><%# Eval("totitem")  %></td>
                        <td>&#8377 <%# Eval("totspend")  %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.name, a.email, a.mobileno, a.address, SUM(ISNULL(c.qty, 0)) AS totitem, SUM(ISNULL(c.amt, 0)) AS totspend FROM orderline AS c INNER JOIN order_dtl AS b ON c.oid = b.oid RIGHT OUTER JOIN user_dtl AS a ON b.uid = a.uid GROUP BY a.name, a.email, a.mobileno, a.address"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
