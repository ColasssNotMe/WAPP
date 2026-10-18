<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SqlConnection.aspx.cs" Inherits="Assignment.SqlConnection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WAPP %>" ProviderName="<%$ ConnectionStrings:WAPP.ProviderName %>" SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
