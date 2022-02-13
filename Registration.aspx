<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="appsec.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://www.google.com/recaptcha/api.js?render=6LeKsWYeAAAAACytxBDCDGmLcXJS6LJniw14oosf"></script>
    <script type="text/javascript">
        function ValidatePwd() {
            var str = document.getElementById('<%=pwdText.ClientID%>').value;
            if (str.length < 12) {
                document.getElementById("passwordLbl").innerHTML = "Password must contain at least 12 characters";
                document.getElementById("passwordLbl").style.color = "Red";
                return ("too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("passwordLbl").innerHTML = "Password must contain a number";
                document.getElementById("passwordLbl").style.color = "Red";
                return ("no_number");
            }
            else if (str.search(/[a-zA-Z]/) == -1) {
                document.getElementById("passwordLbl").innerHTML = "Password must contain an upper case letter and a lower case letter";
                document.getElementById("passwordLbl").style.color = "Red";
                return ("no_upper_lower_case");
            }
            else if (str.search(/[^a-zA-Z0-9]/) == -1) {
                document.getElementById("passwordLbl").innerHTML = "Password must contain a special character";
                document.getElementById("passwordLbl").style.color = "Red";
                return ("no_spec_char");
            }
            else {
                document.getElementById("passwordLbl").innerHTML = "Excellent";
                document.getElementById("passwordLbl").style.color = "Green";
            }
        }
        function ValidateEmail() {
            var str = document.getElementById('<%=emailText.ClientID%>').value;
            if (str.search(/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i) == -1) {
                document.getElementById("btn_submit").disabled = true;
            } else {
                document.getElementById("btn_submit").disabled = false;
            }
            if (str.length == 0) {
                document.getElementById("btn_submit").disabled = true;
            }
        }
        function ValidateFN() {
            var str = document.getElementById('<%=FNText.ClientID%>').value;
            if (str.length == 0) {
                document.getElementById("btn_submit").disabled = true;
            } else {
                document.getElementById("btn_submit").disabled = false;
            }
        }
        function ValidateLN() {
            var str = document.getElementById('<%=LNText.ClientID%>').value;
            if (str.length == 0) {
                document.getElementById("btn_submit").disabled = true;
            } else {
                document.getElementById("btn_submit").disabled = false;
            }
        }
        function ValidateCC() {
            var str = document.getElementById('<%=CCText.ClientID%>').value;
            if (str.length < 16) {
                document.getElementById("btn_submit").disabled = true;
            } else {
                document.getElementById("btn_submit").disabled = false;
            }
        }
        grecaptcha.ready(function () {
            grecaptcha.execute('', { action: 'R' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 276px;
        }
        .auto-style2 {
            width: 276px;
            height: 26px;
        }
        .auto-style3 {
            height: 26px;
        }
        .auto-style4 {
            width: 562px;
        }
        .auto-style5 {
            height: 26px;
            width: 562px;
        }
    </style>
</head>
<body style="height: 216px">

    <form id="form1" runat="server">
        <div>
            <table dir="ltr" style="width: 100%;">
                <tr>
                    <td class="auto-style1">Email:</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="emailText" runat="server" TextMode="Email" onkeyup="javascript:ValidateEmail() ">   </asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">First Name:</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="FNText" runat="server" onkeyup="javascript:ValidateFN()"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">Last Name:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="LNText" runat="server" onkeyup="javascript:ValidateLN()"></asp:TextBox>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">Credit Card Info:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="CCText" runat="server" MaxLength="16" TextMode="Number" onkeyup="javascript:ValidateCC()"></asp:TextBox>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">Password:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="pwdText" runat="server" TextMode="Password" onkeyup="javascript:ValidatePwd()"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Check Password" />
                    </td>
                    <td class="auto-style3">
                        <asp:Label ID="passwordLbl" runat="server" Text="Password Strength"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Date of Birth:</td>
                    <td class="auto-style5">
                        <asp:TextBox ID="DOB" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">Photo:</td>
                    <td class="auto-style5">
                        <asp:FileUpload ID="photoUpload" runat="server" />
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style5">&nbsp;<input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/></td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style5">
                        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" disabled="true"/>
                    </td>
                    <td class="auto-style3">
                        <asp:Label ID="lbl_Error" runat="server" Text="Error messages will be displayed here:"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
