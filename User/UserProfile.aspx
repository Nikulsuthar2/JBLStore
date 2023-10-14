<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="JBLStore.User.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/productlist.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="background-color:lavender;">
    <div style="padding:20px;display:flex;gap:20px;align-items:center;">
        <asp:Label ID="Label1" runat="server" Text="User Details" Font-Size="XX-Large" Font-Bold="True"></asp:Label>
    </div>
    <div style="padding-left: 20px;">
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="uid" DataSourceID="user_dtl" ForeColor="#333333" GridLines="None" Height="50px" Width="284px" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="email" HeaderText="email" ReadOnly="True" SortExpression="email" />
                <asp:BoundField DataField="mobileno" HeaderText="mobileno" SortExpression="mobileno" />
                <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" />
                <asp:BoundField DataField="uid" HeaderText="uid" InsertVisible="False" ReadOnly="True" SortExpression="uid" Visible="False" />
                <asp:CommandField ShowEditButton="True" ButtonType="Button" EditText="Update Profile" >
                <ControlStyle CssClass="btnPrimary" />
                </asp:CommandField>
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
        <asp:Button ID="btnBTP" runat="server" OnClick="btnBTP_Click" Text="Back To Payment" Visible="False" />
        <asp:SqlDataSource ID="user_dtl" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT [name], [email], [mobileno], [address], [uid] FROM [user_dtl] WHERE ([uid] = @uid)" UpdateCommand="UPDATE [user_dtl] SET [name] = @name, [mobileno] = @mobileno, [address] = @address WHERE [uid] = @uid">
            <SelectParameters>
                <asp:SessionParameter Name="uid" SessionField="uid" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="mobileno" Type="String" />
                <asp:Parameter Name="address" Type="String" />
                <asp:Parameter Name="uid" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <div style="padding:20px;display:flex;gap:20px;align-items:center;">
        <asp:Label ID="Label6" runat="server" Text="My Orders" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
    </div>
    <div style="padding:0px 20px 20px 20px;">
        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" DataSourceID="MyOrderdtl" OnItemCommand="Repeater1_ItemCommand">
            <HeaderTemplate>
                <div style="display:flex;gap:40px;flex-wrap:wrap;">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="userOrder">
                    <div>
                        <h3 style="display:flex;justify-content:space-between;"><p>Order - <asp:Label ID="orderid" runat="server" Text='<%# Eval("oid") %>'></asp:Label></p><asp:Button ID="Button1" runat="server" Text="Bill" Commandname="btnBill" CommandArgument='<%# Eval("oid") %>' CssClass="btnEdit"/></h3>
                        <table style="width:100%;">
                            <tr>
                                <td>Total Item</td>
                                <td><asp:Label ID="lbltotitem" runat="server" Text='<%# Eval("totalitem") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Total Price</td>
                                <td><asp:Label ID="lbltotprice" runat="server" Text='<%# "&#8377; " + Eval("totalprice") %>' ForeColor="Green" Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Date & Time</td>
                                <td><asp:Label ID="lblodt" runat="server" Text='<%# Eval("datetime") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td><asp:Label ID="lblstatus" runat="server" Text='<%# Eval("Status") %>' ForeColor='<%# Eval("Status").ToString() == "Completed" ? System.Drawing.Color.Green : System.Drawing.Color.Red%>' Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td><asp:Label ID="lbladdress" runat="server" Text='<%# Eval("address") %>'></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <h3>Products</h3>
                        <asp:Repeater ID="OrderProductRepeater" runat="server">
                            <HeaderTemplate>
                                <Table class="ordertable">
                                    <tr>
                                        <th>S.No.</th>
                                        <th>Image</th>
                                        <th width="250px">Product Name</th>
                                        <th width="90px">Price</th>
                                        <th>Quantity</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td style="text-align:center;"><%# Container.ItemIndex + 1 %></td>
                                    <td style="text-align:center;">
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("image") %>' Width="50px"/></td>
                                    <td><%# Eval("name") %></td>
                                    <td style="text-align:center;">&#8377; <%# Eval("amt") %></td>
                                    <td style="text-align:center;"><%# Eval("qty") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </Table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="MyOrderdtl" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT * FROM order_dtl WHERE (uid = @uid) ORDER BY datetime DESC">
            <SelectParameters>
                <asp:SessionParameter Name="uid" SessionField="uid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</div>
</asp:Content>
