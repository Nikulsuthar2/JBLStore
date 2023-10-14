<%@ Page Title="Products" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="JBLStore.Admin.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
        <div class="productheader">
            <asp:Label ID="Label1" runat="server" Text="Products" Font-Bold="True" Font-Size="25px"></asp:Label>
            <div>
                <asp:TextBox ID="txtSearch" CssClass="searchbox" runat="server" placeholder="search"></asp:TextBox>
                <asp:Button ID="btnsearch" CssClass="btnSearch" runat="server" Text="&#128269;" OnClick="btnsearch_Click" />
            </div>
            <asp:Button ID="btnAddProduct" CssClass="btnPrimary" runat="server" Text="Add Product" OnClick="btnAddProduct_Click" />
        </div>
            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                <HeaderTemplate>
                    <table border="1" class="producttable" style="text-align:center;">
                        <tr>
                            <th>S.No.</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Model</th>
                            <th>Price</th>
                            <th>Discount</th>
                            <th>Discount Price</th>
                            <th>Type</th>
                            <th>Operation</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td><asp:Image ID="imageImage" runat="server" ImageUrl='<%# Eval("image") %>'  Width="60px"/></td>
                        <td><asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' /></td>
                        <td><asp:Label ID="pidLabel" runat="server" Text='<%# Eval("modelid") %>' /></td>
                        <td class="productlist-price">&#8377 <asp:Label ID="priceLabel" CssClass="productlist-price" runat="server" Text='<%# Eval("price") %>' /></td>
                        <td><asp:Label ID="discountLabel" CssClass="productlist-dcnt" runat="server" Text='<%# Eval("discount") + "%" %>' /></td>
                        <td>&#8377 
                            <%#
                                Double.Parse(Eval("price").ToString()) - (Double.Parse(Eval("price").ToString()) * (Double.Parse(Eval("discount").ToString()) / 100))
                            %>
                        </td>
                        <td><asp:Label ID="typeLabel" runat="server" Text='<%# Eval("type") %>' /></td>
                        <td>
                            <asp:Button ID="btnProductEdit" CssClass="btnEdit" runat="server" Text="&#9998; Edit" CommandName="editProduct" CommandArgument='<%# Eval("modelid") %>' />
                            <asp:Button ID="btnProductDelete" CssClass="btnDelete" runat="server" Text="&#10006; Remove" CommandName="deleteProduct" CommandArgument='<%# Eval("modelid") %>' OnClientClick="return confirm('Are you sure you want to delete?');" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT * FROM [product_dtl]"></asp:SqlDataSource>
            
    </div>
    </div>
</asp:Content>
