<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="JBLStore.User.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="display:flex;justify-content:center;">
        <div style="width:60%">
            <div style="display:flex;gap:30px;align-items: center;">
                <div>
                    <asp:Image ID="imgProduct" runat="server" width="250px" />
                </div>
                <div style="display:flex;flex-direction:column;gap:20px;">
                    <asp:Label ID="lblName" runat="server" Text="Label" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
                    <div>
                        <asp:Label ID="lblPrice" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblDcnt" runat="server" Visible="False" Font-Bold="True" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lblDcntPrice" runat="server" Visible="False" Font-Bold="True" ForeColor="Green" ></asp:Label>
                    </div>
                    <div>
                        <asp:Label ID="lblStock" runat="server" Text="Out of stock" Visible="False" ForeColor="Red" Font-Bold="True"></asp:Label>
                        <asp:Button ID="btnATC" runat="server" Text="Add to Cart" CssClass="btnPrimary" OnClick="btnATC_Click"/>
                        <asp:Button ID="btnBuy" runat="server" Text="Buy" CssClass="btnLogin" OnClick="btnBuy_Click" />
                    </div>
                </div>
            </div>
            <div style="display:flex;flex-direction:column;gap: 10px;">
                <asp:Label ID="Label1" runat="server" Text="Description" Font-Size="X-Large" Font-Bold="True"></asp:Label>
                <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="Specifications" Font-Size="X-Large" Font-Bold="True"></asp:Label>
                <table>
                    <tr>
                        <td width="20%">Model ID</td>
                        <td width="80%">- 
                            <asp:Label ID="lblModelid" runat="server"></asp:Label>
&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Type</td>
                        <td>- 
                            <asp:Label ID="lblType" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Color</td>
                        <td style="display:flex;gap:10px;">- 
                            <div style="width:20px;height:20px;border:1px solid #cbcbcb;border-radius:50%;background-color:<%=lblColor.Text%>"></div>
                            <asp:Label ID="lblColor" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Connectivity</td>
                        <td>- 
                            <asp:Label ID="lblConnectivity" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>With Microphone</td>
                        <td>- 
                            <asp:Label ID="lblMic" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSubTypeTitle" runat="server"></asp:Label></td>
                        <td>- 
                            <asp:Label ID="lblSubType" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Deep Bass</td>
                        <td>- 
                            <asp:Label ID="lblBass" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Water Resistence</td>
                        <td>- 
                            <asp:Label ID="lblWProof" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Other features</td>
                        <td>- 
                            <asp:Label ID="lblFeatures" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
