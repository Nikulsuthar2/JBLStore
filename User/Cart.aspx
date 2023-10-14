<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="JBLStore.User.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="cart-header">
            <h1>My Cart</h1>
            <asp:Button ID="btnBackHome" runat="server" Text="Back" CssClass="btnPrimary"  OnClick="btnBackHome_Click" />
        </div>
        <div style="padding: 0px 20px">
            <asp:Repeater ID="Repeater1" runat="server"  OnItemDataBound="Repeater1_ItemDataBound" OnItemCommand="Repeater1_ItemCommand">
                <HeaderTemplate>
                    <table class="producttable" border="1" style="text-align:center;">
                        <tr>
                            <th>S.No.</th>
                            <th>Image</th>
                            <th>Product</th>
                            <th>Discount</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td>
                            <asp:Image ID="cartimage" runat="server" Width="40px" ImageUrl='<%# Eval("image") %>' />
                        </td>
                        <td style="text-align:start">
                            <asp:Label ID="lblname" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                            <asp:Label ID="lblpid" runat="server" Text='<%# Eval("pid") %>' Visible="false"></asp:Label>
                        </td>
                        <td style="color:red;font-weight:bold"><%# Eval("discount") + "%" %></td>
                        <td style="color:green;font-weight:bold">&#8377;
                            <asp:Label ID="lblprice" runat="server" 
                                Text='<%# Eval("price") %>'>
                            </asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblqty" runat="server" Text='<%# Eval("qty") %>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="ddlQty" CssClass="inputbox2" runat="server" value='<%# Eval("qty").ToString()%>' onchange='<%# "addQty(this,"+Eval("pid")+")" %>' >
                                
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnRemove" runat="server" CssClass="btnDelete" CommandName="cartDelete" CommandArgument='<%# Eval("pid") %>' Text="Remove" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="cartData" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.pid, a.image, a.name, a.price, a.discount, b.qty FROM product_dtl AS a INNER JOIN cart AS b ON a.pid = b.pid WHERE (b.uid = @uid)">
                <SelectParameters>
                    <asp:SessionParameter Name="uid" SessionField="uid" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div style="padding: 10px 400px">
            <table cellpadding="0" cellspacing="0" class="tablelist">
                <tr>
                    <td colspan="2">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="20px" Text="Price Details"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Price"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Discount"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="lblTotalDcnt" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Total Amount"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="lblTotalDcntPrice" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:Button ID="btnPlaceOrder" runat="server" CssClass="btnEdit" Text="Place Order" OnClick="btnPlaceOrder_Click" />
                    </td>
                </tr>
            </table>

        </div>
    </div>
    <script>
        function addQty(obj,pid) {
            //alert(obj.value + " " + pid)
            location.href = "Cart.aspx?setqty=" + obj.value + "&pid=" + pid;
        }
    </script>
</asp:Content>
