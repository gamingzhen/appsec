<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="appsec.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="register" runat="server" OnClick="register_Click" Text="Register" />
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="login" runat="server" OnClick="login_Click" Text="Login" />
        </div>
    </form>
</body>
</html>
