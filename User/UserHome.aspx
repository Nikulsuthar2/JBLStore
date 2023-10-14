<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="JBLStore.User.UserHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="border-bottom: 1px solid #cbcbcb;display:flex;justify-content:center;background-color: lavender;">
        <div class="big-product-card">
            <asp:Image ID="imgBPImage" runat="server" height="300px" />
            <div style="display:flex;flex-direction:column;gap:10px;justify-content:space-between;">
                <asp:Label ID="lblBPName" runat="server" Font-Bold="True" Font-Size="40px"></asp:Label>
                <asp:Label ID="lblBPid" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblBPDesc" runat="server"></asp:Label>
                <div style="display:flex;gap:10px;">
                    <p><asp:Label ID="lblBPPrice" runat="server"></asp:Label></p>
                    <p><asp:Label ID="lblBPDiscount" runat="server" Visible="False" Font-Bold="True" ForeColor="Red"></asp:Label></p>
                     <p><asp:Label ID="lblBPDcntPrice" runat="server" Visible="False" Font-Bold="True" ForeColor="Green"></asp:Label></p>
                </div>
                <div style="display:flex;justify-content:space-between">
                    <asp:Label ID="lblStock" runat="server" Text="Out of stock" Visible="False" ForeColor="Red" Font-Bold="True"></asp:Label>
                    <asp:Button ID="btnBPatc" runat="server" Text="Add to Cart" CssClass="btnPrimary" OnClick="btnBPatc_Click" />
                    <asp:Button ID="btnBPbuy" runat="server" Text="Buy" CssClass="btnLogin" OnClick="btnBPbuy_Click"/>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div style="display:flex;justify-content:space-between;padding:10px 20px;">
            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="25px" Text="Speakers"></asp:Label>
            <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="SearchResult.aspx?speaker=1">View More</asp:HyperLink>
        </div>
        <div style="display:flex;gap:20px;padding:10px 20px;">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SpeakerProduct" OnItemDataBound="Repeater1_ItemDataBound" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <a href='<%# "ProductDetails.aspx?pid=" + Eval("pid") %>' style="text-decoration:none">
                        <div class="small-product-card">
                            <asp:Image ID="imgSP" runat="server" ImageUrl='<%# Eval("image") %>' Width="100%"/>
                            <asp:LinkButton ID="lblSPName" runat="server" Font-Bold="True" PostBackUrl='<%# "ProductDetails.aspx?pid=" + Eval("pid") %>' ><%# Eval("name") %></asp:LinkButton>
                            <asp:Label ID="lblSPid" runat="server" Text='<%# Eval("pid") %>' Visible="false"></asp:Label>
                            <div>
                                <asp:Label ID="lblSPPrice" runat="server" Text='<%# "&#8377 " + Eval("price") %>' Font-Strikeout='<%# Int32.Parse(Eval("discount").ToString()) > 0 ? true : false %>'></asp:Label>
                                <asp:Label ID="lblSPDcnt" runat="server" Text='<%# Eval("discount") + "%" %>' ForeColor="Red" Font-Bold="True"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text='<%# "&#8377;" +
                                    (Double.Parse(Eval("price").ToString()) - (Double.Parse(Eval("price").ToString()) * (Double.Parse(Eval("discount").ToString()) / 100))).ToString()
                                %>' ForeColor="Green" Font-Bold="True"></asp:Label>
                            </div>
                            <div style="display:flex;justify-content:space-between;gap:5px">
                                <asp:Label ID="lblInStock" runat="server" Text="Out of stock" Visible="False" Font-Bold="True" ForeColor="Red"></asp:Label>
                                <asp:Button ID="btnSPatc" runat="server" Text="Add to cart" CommandName="atcProduct" CommandArgument='<%# Eval("pid") %>' CssClass="btnPrimary" width="100%"/>
                                <asp:Button ID="btnSPBuy" runat="server" Text="Buy" CssClass="btnLogin" CommandName="buyProduct" CommandArgument='<%# Eval("pid") %>' />
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="SpeakerProduct" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT pid, modelid, name, price, discount, description, image, type, color, connectivity, mic, subtype, deepbass, waterproof, features FROM product_dtl WHERE (type = 'Speaker')"></asp:SqlDataSource>
        </div>
    </div>
    <div>
        <div style="display:flex;justify-content:space-between;padding:10px 20px;">
            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="25px" Text="Headsets"></asp:Label>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="SearchResult.aspx?headset=1">View More</asp:HyperLink>
        </div>
        <div style="display:flex;gap:20px;padding:10px 20px;">
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="HeadsetProduct" OnItemCommand="Repeater2_ItemCommand" OnItemDataBound="Repeater2_ItemDataBound">
                <ItemTemplate>
                    <a href='<%# "ProductDetails.aspx?pid=" + Eval("pid") %>' style="text-decoration:none">
                        <div class="small-product-card">
                            <asp:Image ID="imgSP" runat="server" ImageUrl='<%# Eval("image") %>' Width="100%"/>
                            <asp:LinkButton ID="lblSPName" runat="server" Font-Bold="True" PostBackUrl='<%# "ProductDetails.aspx?pid=" + Eval("pid") %>' ><%# Eval("name") %></asp:LinkButton>
                            <asp:Label ID="lblSPid" runat="server" Text='<%# Eval("pid") %>' Visible="false"></asp:Label>
                            <div>
                                <asp:Label ID="lblSPPrice" runat="server" Text='<%# "&#8377 " + Eval("price") %>' Font-Strikeout='<%# Int32.Parse(Eval("discount").ToString()) > 0 ? true : false %>'></asp:Label>
                                <asp:Label ID="lblSPDcnt" runat="server" Text='<%# Eval("discount") + "%" %>' ForeColor="Red" Font-Bold="True"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text='<%# "&#8377;" +
                                    (Double.Parse(Eval("price").ToString()) - (Double.Parse(Eval("price").ToString()) * (Double.Parse(Eval("discount").ToString()) / 100))).ToString()
                                %>' ForeColor="Green" Font-Bold="True"></asp:Label>
                            </div>
                            <div style="display:flex;justify-content:space-between;gap:5px">
                                <asp:Label ID="lblInStock" runat="server" Text="Out of stock" Font-Bold="true" ForeColor="Red" Visible="False"></asp:Label>
                                <asp:Button ID="btnSPatc" runat="server" Text="Add to cart" CommandName="atcProduct" CommandArgument='<%# Eval("pid") %>' CssClass="btnPrimary" width="100%"/>
                                <asp:Button ID="btnSPBuy" runat="server" Text="Buy" CssClass="btnLogin" CommandName="buyProduct" CommandArgument='<%# Eval("pid") %>' />
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="HeadsetProduct" runat="server" ConnectionString="<%$ ConnectionStrings:JBL %>" SelectCommand="SELECT pid, modelid, name, price, discount, description, image, type, color, connectivity, mic, subtype, deepbass, waterproof, features FROM product_dtl WHERE (type = 'Headset')"></asp:SqlDataSource>
        </div>
        </div>
</asp:Content>
