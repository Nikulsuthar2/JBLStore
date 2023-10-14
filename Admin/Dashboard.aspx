<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JBLStore.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dash-container">
        <a class="value-card" href="Product.aspx">
            <label class="card-title">Total Products</label>
            <asp:Label CssClass="card-value" ID="lblTProduct" runat="server" Text="0"></asp:Label>
        </a>
        <a class="value-card" href="Customer.aspx">
            <label class="card-title">Total Customers</label>
            <asp:Label CssClass="card-value" ID="lblTCustomer" runat="server" Text="0"></asp:Label>
        </a>
        <a class="value-card" href="Orders.aspx">
            <label class="card-title">New Orders</label>
            <asp:Label CssClass="card-value" ID="lblNewOrder" runat="server" Text="0"></asp:Label>
        </a>
        <a class="value-card" href="Orders.aspx">
            <label class="card-title">Order Completed</label>
            <asp:Label CssClass="card-value" ID="lblOrderComplete" runat="server" Text="0"></asp:Label>
        </a>
        <a class="value-card" href="Orders.aspx">
            <label class="card-title">Total Earning</label>
            <asp:Label CssClass="card-value" ID="lblTotalEarn" runat="server" Text="0"></asp:Label>
        </a>
    </div>
    
</asp:Content>
