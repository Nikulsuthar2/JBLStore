<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="JBLStore.Admin.OrderDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div class="productlistbody">
            <div class="productheader">
                <a class="btnPrimary" href="javascript:history.back()">Back</a>
                <asp:Label ID="Label3" runat="server" Text="Order Details" Font-Bold="True" Font-Size="25px"></asp:Label>
                
                <asp:Button ID="btnPrint" CssClass="btnEdit" runat="server" Text="Print" OnClientClick="return printBill()" />
            </div>
             <asp:Panel ID="panelInvoice" runat="server">
                <div class="orderdetails">
                <div>
                    <asp:Label ID="Label1" runat="server" Text="Order ID - " Font-Bold="True" Font-Size="25px"></asp:Label>
                    <asp:Label ID="lblOid" runat="server" Text="" Font-Bold="True" Font-Size="25px"></asp:Label>      
                </div>
                <hr />
                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" DataSourceID="OrderLine">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td colspan="5">
                                    <asp:Label ID="Label11" runat="server" Text="Items Details" Font-Bold="True" Font-Size="Larger"></asp:Label></td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td width="50px" style="text-align:center"><%# Container.ItemIndex + 1 %></td>
                            <td width="50px" style="text-align:center">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>' width="40px" AlternateText="Removed"/></td>
                            <td width="300px"><%# Eval("name") %></td>
                            <td width="60px" style="text-align:center">Qty - <asp:Label ID="lblQty" runat="server" Text='<%# Eval("qty") %>'></asp:Label></td>
                            <td width="100px" style="text-align:center">&#8377;<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("amt") %>'></asp:Label></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            <tr><td colspan="5"><hr /></td></tr>
                            <tr>
                                <td colspan="3">Total</td>
                                <td style="text-align:center">
                                    <asp:Label ID="totalQty" runat="server" Text=""></asp:Label></td>
                                <td style="text-align:center">
                                    <asp:Label ID="totalPrice" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="OrderLine" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT a.image, ISNULL(a.name,'Removed') as name, b.qty, b.amt FROM product_dtl AS a RIGHT OUTER JOIN orderline AS b ON a.pid = b.pid WHERE (b.oid = @oid)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="oid" QueryStringField="oid" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <table cellspacing="0" width="100%">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Large" Text="Customer Details"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label7" runat="server" Text="Name"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label8" runat="server" Text="Email"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label9" runat="server" Text="Mobile No."></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblMobileNo" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label10" runat="server" Text="Address"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblAddress" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center">
                            <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputbox2">
                                <asp:ListItem>Pending</asp:ListItem>
                                <asp:ListItem>Completed</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btnEdit" OnClick="btnUpdate_Click" Text="Update" />
                        </td>
                    </tr>
                </table>
            </div>
            </asp:Panel>
        </div>
    </div>
    <script>
        function printBill() {
            var lblstatus = document.getElementById("<%=lblStatus.ClientID%>");
            var ddlstatus = document.getElementById("<%=ddlStatus.ClientID%>");
            var btnUpdate = document.getElementById("<%=btnUpdate.ClientID%>");

            lblstatus.hidden = true;
            ddlstatus.hidden = true;
            if (btnUpdate != null) {
                btnUpdate.hidden = true;
            }

            var panel = document.getElementById("<%=panelInvoice.ClientID%>");
            var printWindow = window.open('', '', 'height=700,width=1000');
            printWindow.document.write('<html><head><title>Order Details</title></head><body>');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.print();
        }
    </script>
</asp:Content>
