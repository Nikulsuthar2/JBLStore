<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bill.aspx.cs" Inherits="JBLStore.User.Bill" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../CSS/style.css" />
    <link rel="stylesheet" href="../CSS/productlist.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:10px;">
            <table cellspacing="0" style="border:2px solid black;width:100%">
                <tr>
                    <td colspan="2">
                        <div style="display:flex;justify-content:space-between;align-items:center;padding:5px;">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Assets/JBL_logo.png" Width="80px" />
                        <asp:Label ID="lblbillDate" runat="server" Text="generated on :"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><hr style="color:black;border:1px solid black;" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="display:flex;">
                            <div style="display:flex;flex-direction:column;padding:5px;gap:5px;border-right:2px solid black;border-bottom:2px solid black;width:80%">
                                <h3>Buyer (Bill to)</h3>
                                <asp:Label ID="lblCName" runat="server" Font-Bold="True"></asp:Label>
                                <asp:Label ID="lblCEmail" runat="server"></asp:Label>
                                <asp:Label ID="lblCMobile" runat="server"></asp:Label>
                                <asp:Label ID="lblAddress" runat="server"></asp:Label>
                            </div>
                            <div style="display:flex;flex-direction:column;padding:5px;gap:5px;border-bottom:2px solid black;width:100%">
                                <h3>Order Details</h3>
                                <asp:Label ID="lblOid" runat="server"></asp:Label>
                                <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                                <asp:Label ID="lblOStatus" runat="server"></asp:Label>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="orderDetails" OnItemDataBound="Repeater1_ItemDataBound" >
                            <HeaderTemplate>
                                <table class="producttable" style="margin:5px 0px;">
                                    <tr>
                                        <th>S.No.</th>
                                        <th>Product Name</th>
                                        <th>Model ID</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Discount %</th>
                                        <th>Final Amount</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex + 1 %></td>
                                    <td><%# Eval("name") %></td>
                                    <td style="text-align:center"><%# Eval("modelid") %></td>
                                    <td style="text-align:center">
                                        <asp:Label ID="lblPQty" runat="server" Text='<%# Eval("qty") %>'></asp:Label></td>
                                    <td style="text-align:center">&#8377;<%# Eval("price") %></td>
                                    <td style="text-align:center"><%# Eval("discount") + "%" %></td>
                                    <td style="text-align:center">&#8377;<asp:Label ID="lblPAmt" runat="server" Text='<%# Eval("amt") %>'></asp:Label></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <tr><td colspan="7">&nbsp;</td></tr>
                                    <tr>
                                        <td></td>
                                        <td style="text-align:end">Total</td>
                                        <td></td>
                                        <td style="text-align:center">
                                            <asp:Label ID="lblTotalQty" runat="server" Text=""></asp:Label></td>
                                        <td></td>
                                        <td></td>
                                        <td style="text-align:center">
                                            <asp:Label ID="lblTotalAmt" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="orderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.name, a.modelid, a.price, a.discount, b.qty, b.amt FROM order_dtl AS c INNER JOIN orderline AS b ON c.oid = b.oid INNER JOIN product_dtl AS a ON b.pid = a.pid WHERE (b.oid = @oid)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="oid" QueryStringField="oid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <hr style="color:black;border:1px solid black;"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Print or Download" OnClientClick="return print()" UseSubmitBehavior="False" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button2" runat="server" Text="Back" OnClientClick="return history.back()" UseSubmitBehavior="False" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
