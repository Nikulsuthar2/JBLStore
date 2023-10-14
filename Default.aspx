<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="JBLStore.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>JBL</title>
    <link rel="stylesheet" href="CSS/style.css" />
</head>
<body >
    <form id="form1" runat="server">
        <div class="navbar">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Assets/JBL_logo.png" Width="40px" />
            <asp:Button ID="btnAdmin" CssClass="btnAdmin" runat="server" Text="Admin" OnClick="btnAdmin_Click" />
        </div>
        <div class="mainbody" style="background-color:lavender;background-image:url('Images/Assets/bg.png');background-size:cover;background-repeat:no-repeat;">
            <div class="divbackblur">
                <asp:Label ID="Label2" runat="server" Text="Buy JBL Speakers and Headphones." Font-Bold="True" Font-Size="40px" ForeColor="White"></asp:Label>
                <div>
                    <asp:Button ID="btnSignup" CssClass="btnSignup" runat="server" Text="Sign Up" OnClick="btnSignup_Click" />&nbsp;&nbsp;
                    <asp:Button ID="btnLogin" CssClass="btnLogin" runat="server" Text="Log in" OnClick="btnLogin_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
