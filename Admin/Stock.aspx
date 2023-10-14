<%@ Page Title="Stock" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Stock.aspx.cs" Inherits="JBLStore.Admin.Stock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
            <div class="productheader">
                <asp:Label ID="Label1" runat="server" Text="Stock" Font-Bold="True" Font-Size="25px"></asp:Label>
                <div>
                    <asp:TextBox ID="txtSearch" CssClass="searchbox" runat="server" placeholder="search"></asp:TextBox>
                    <asp:Button ID="btnsearch" CssClass="btnSearch" runat="server" Text="&#128269;" OnClick="btnsearch_Click" />
                </div>
                <asp:RadioButtonList ID="rblStock" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblStock_SelectedIndexChanged">
                    <asp:ListItem Selected="True">All&amp;nbsp;&amp;nbsp;</asp:ListItem>
                    <asp:ListItem>In stock&amp;nbsp;&amp;nbsp;</asp:ListItem>
                    <asp:ListItem>Out of stock&amp;nbsp;&amp;nbsp;</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                <HeaderTemplate>
                    <table class="stocktable" border="1" style="text-align:center">
                        <tr>
                            <th>S. NO.</th>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Model ID</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td>
                            <asp:Image ID="imageImage" ImageUrl='<%# Eval("image") %>' Width="40px" runat="server" />
                        </td>
                        <td><%# Eval("name") %></td>
                        <td><%# Eval("modelid") %></td>
                        <td><%# Eval("qty").ToString() == "0" ? "<p style='color:red'>Out of Stock</p>" : Eval("qty")%></td>
                        <td>
                            <asp:Button ID="btnView" CssClass="btnEdit" runat="server" Text="Update" CommandName="updateStock" CommandArgument='<%# Eval("modelid")%>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Label ID="lblDataResult" runat="server" Text="No Result Found" Visible="false"></asp:Label>
            <asp:SqlDataSource ID="dsInStock" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.modelid, a.image, a.name, b.qty FROM product_dtl AS a INNER JOIN stock AS b ON a.modelid = b.modelid WHERE (b.qty &gt; 0)"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsOutOfStock" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.modelid, a.image, a.name, b.qty FROM product_dtl AS a INNER JOIN stock AS b ON a.modelid = b.modelid WHERE (b.qty = 0)"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.modelid, a.image, a.name, b.qty FROM product_dtl AS a INNER JOIN stock AS b ON a.modelid = b.modelid"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
