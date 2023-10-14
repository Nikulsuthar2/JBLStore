<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="SalesReport.aspx.cs" Inherits="JBLStore.Admin.SalesReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
            <div class="productheader">
                <asp:Label ID="Label1" runat="server" Text="Sales Report" Font-Bold="True" Font-Size="25px"></asp:Label>
                <div>
                    <asp:RadioButtonList ID="rblReporttype" runat="server" OnSelectedIndexChanged="rblReporttype_SelectedIndexChanged" AutoPostBack="True">
                        <asp:ListItem Selected="True">Customer Wise</asp:ListItem>
                        <asp:ListItem>Product Wise</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div>
                    <asp:Label ID="Label2" runat="server" Text="Month : "></asp:Label>
                    <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                        <asp:ListItem>None</asp:ListItem>
                        <asp:ListItem>JAN</asp:ListItem>
                        <asp:ListItem>FEB</asp:ListItem>
                        <asp:ListItem>MAR</asp:ListItem>
                        <asp:ListItem>APR</asp:ListItem>
                        <asp:ListItem>MAY</asp:ListItem>
                        <asp:ListItem>JUN</asp:ListItem>
                        <asp:ListItem>JUL</asp:ListItem>
                        <asp:ListItem>AUG</asp:ListItem>
                        <asp:ListItem>SEP</asp:ListItem>
                        <asp:ListItem>OCT</asp:ListItem>
                        <asp:ListItem>NOV</asp:ListItem>
                        <asp:ListItem>DEC</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="Label3" runat="server" Text="Year : "></asp:Label>
                    <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                        <asp:ListItem>None</asp:ListItem>
                        <asp:ListItem>2022</asp:ListItem>
                        <asp:ListItem>2023</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table class="producttable">
                        <tr>
                            <th>S.No.</th>
                            <th>Customer Email</th>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Amount Paid</th>
                            <th>Purchase Date</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td style="text-align:center"><%# Container.ItemIndex + 1 %></td>
                        <td><%# Eval("email") %></td>
                        <td><%# Eval("name") %></td>
                        <td style="text-align:center"><%# Eval("qty") %></td>
                        <td style="text-align:center">&#8377;<%# Eval("amt") %></td>
                        <td style="text-align:center"><%# Eval("datetime") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Repeater ID="Repeater2" runat="server" Visible="False">
                <HeaderTemplate>
                    <table class="producttable">
                        <tr>
                            <th>S.No.</th>
                            <th>Product</th>
                            <th>Model ID</th>
                            <th>Total Sold</th>
                            <th>Total Earning</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td style="text-align:center"><%# Container.ItemIndex + 1 %></td>
                        <td><%# Eval("name") %></td>
                        <td style="text-align:center"><%# Eval("modelid") %></td>
                        <td style="text-align:center"><%# Eval("totsold") %></td>
                        <td style="text-align:center">&#8377;<%# Eval("totearn") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.name, a.modelid, COUNT(b.oid) AS totsold, SUM(b.amt) AS totearn, MAX(c.datetime) AS maxdate FROM product_dtl AS a INNER JOIN orderline AS b INNER JOIN order_dtl AS c ON b.oid = c.oid ON a.pid = b.pid WHERE (c.status = 'Completed') GROUP BY a.name, a.modelid ORDER BY maxdate DESC"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
