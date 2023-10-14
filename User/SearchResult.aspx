<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="SearchResult.aspx.cs" Inherits="JBLStore.User.SearchResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 20px">
        <asp:Label ID="lblHeader" runat="server" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
    </div>
    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
            <div style="padding:20px;display:flex;gap:20px;flex-wrap:wrap;">
        </HeaderTemplate>
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
                    <div style="display:flex;gap:10px">
                        <asp:Label ID="lblInStock" runat="server" Text="Out of stock" Visible="False" Font-Bold="True" ForeColor="Red"></asp:Label>
                        <asp:Button ID="btnSPatc" runat="server" Text="Add to cart" CommandName="atcProduct" CommandArgument='<%# Eval("pid") %>' CssClass="btnPrimary" width="100%"/>
                        <asp:Button ID="btnSPBuy" runat="server" Text="Buy" CssClass="btnLogin" CommandName="buyProduct" CommandArgument='<%# Eval("pid") %>' />
                    </div>
                </div>
            </a>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
