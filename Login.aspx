<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="appsec.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 277px;
        }
        .auto-style2 {
            width: 313px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Login<br />
            <table style="width:100%;">
                <tr>
                    <td class="auto-style1">Email:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="emailText" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Password:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="pwdText" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="errorMsg" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Button ID="loginBtn" runat="server" Text="Login" onclick="LoginMe"/>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
