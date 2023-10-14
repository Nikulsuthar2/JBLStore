<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="JBLStore.User.Payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment</title>
    <link rel="stylesheet" href="../CSS/style.css" />
    <link rel="stylesheet" href="../CSS/productlist.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:10px 20px;display:flex;gap:20px;align-items:center">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="javascript:history.back()" CssClass="btnPrimary">Back</asp:HyperLink>
            <h1>Checkout</h1>
        </div>
        <div style="display:flex;gap:50px;padding:0px 20px;align-items:flex-start">
            <asp:Label ID="lblPid" runat="server" Text="" Visible="False"></asp:Label>
            <div style="display:flex;flex-direction:column;gap:10px;  padding:10px;border: 1px solid #cbcbcb;border-radius:10px;">
                <div style="display:flex;flex-direction:column;gap:10px;">
                    <div style="display:flex;flex-direction:column;gap:10px;">
                        <h3>Billing Address</h3>
                        <div>
                            <label>Addresss</label>
                            <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:20px;">
                                <asp:Label ID="lblAdress" runat="server" Font-Bold="True" Width="250px"></asp:Label>
                                <asp:Button ID="btnEditAdd" runat="server" Text="Edit" CssClass="btnPrimary" OnClick="btnEditAdd_Click"/>
                            </div>
                        </div>
                    </div>
                    <div style="background-color:#cbcbcb;border-radius:5px;height:1px;"></div>
                    <div style="display:flex;flex-direction:column;gap:10px;">
                        <h3>Payment</h3>
                        <div>
                            <label>Card Holder Name</label>
                            <asp:TextBox ID="txtCardName" CssClass="inputbox" runat="server"></asp:TextBox>
                        </div>
                        <div>
                            <label>Card Number</label>
                            <asp:TextBox ID="txtCardNo" CssClass="inputbox" runat="server" minLength="16" MaxLength="16"></asp:TextBox>
                        </div>
                        <div>
                            <label>CVV</label>
                            <asp:TextBox ID="txtCVV" CssClass="inputbox" maxlength="3" minlength="3" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <asp:Button ID="btnPay" CssClass="btnEdit" runat="server" Text="Pay" Width="100%" OnClick="btnPay_Click" />
                <asp:Label ID="lblTotalPrice" runat="server" Text="" Visible="False"></asp:Label>
                <asp:Label ID="lblTotalItem" runat="server" Text="" Visible="False"></asp:Label>
            </div>
            <div style="display:flex;gap:10px;flex-direction:column;padding:10px;border: 1px solid #cbcbcb;border-radius:10px;">
                <h3>Order Summary</h3>
                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                    <HeaderTemplate>
                        <table border="1" class="ordertable">
                            <tr>
                                <th>S. No.</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="text-align:center;"><%# Container.ItemIndex + 1 %></td>
                            <td>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>' Width="50px" /></td>
                            <td><%# Eval("name") %></td>
                            <td style="text-align:center;">
                                <asp:Label ID="lblQty" runat="server" Text='<%# Eval("qty") %>'></asp:Label></td>
                            <td style="text-align:center;color:green;font-weight:bold;">&#8377;
                                <asp:Label ID="lblPrice" runat="server" Text='<%#
                                    (Double.Parse(Eval("price").ToString()) - (Double.Parse(Eval("price").ToString()) * (Double.Parse(Eval("discount").ToString()) / 100))) * Int32.Parse(Eval("qty").ToString())
                                %>'></asp:Label>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            <tr>
                                <td></td>
                                <td style="font-weight:bold;">Total : </td>
                                <td style="text-align:center;font-weight:bold;">
                                    <asp:Label ID="totalQty" runat="server" Text=""></asp:Label></td>
                                <td style="text-align:center;color:green;font-weight:bold;">
                                    <asp:Label ID="totalPrice" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="SingleProduct" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT name,image, COUNT(pid) AS qty, price, discount FROM product_dtl WHERE (pid = @pid) GROUP BY name,image, price, discount">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblPid" Name="pid" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="OrderSummary" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.pid,a.image, a.name, a.price, a.discount, b.qty FROM product_dtl AS a INNER JOIN cart AS b ON a.pid = b.pid WHERE (b.uid = @uid)">
                    <SelectParameters>
                        <asp:SessionParameter Name="uid" SessionField="uid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
</body>
</html>
