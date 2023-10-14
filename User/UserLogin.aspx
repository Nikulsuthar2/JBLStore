<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="JBLStore.User.UserLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../CSS/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="display:flex;justify-content:center;align-items:center;height:100vh;padding: 20px;background-color:lavender;">
        <div class="loginform">
            <h1 style="text-align:center;">Customer Login</h1>
            <div class="input-section">
                <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>
                <div class="input-container">
                    <asp:TextBox ID="txtEmail" class="inputbox" runat="server" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email is Required" ForeColor="Red" SetFocusOnError="True" Font-Size="X-Large">*</asp:RequiredFieldValidator>
                </div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Enter a valid email address" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </div>
            <div class="input-section">
                <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
                <div class="input-container">
                    <asp:TextBox ID="txtPassword" class="inputbox" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" Display="Dynamic" ErrorMessage="Password is required" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <asp:Label ID="lblResult" runat="server" ForeColor="Red"></asp:Label>
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" CssClass="btnLogin" style="padding:8px"/>
            <p style="text-align:center;">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="UserSignup.aspx">Don't have an account?</asp:HyperLink>
            </p>
        </div>
    </div>
    </form>
</body>
</html>
