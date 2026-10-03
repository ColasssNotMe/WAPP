<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Assignment.WebUserControl1" %>

<link rel="stylesheet" type="text/css" href="header.css" />

<header style="background-color: #808080;justify-content:space-evenly;align-items:center ; color: white; display: flex">

        <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" Text="Label"></asp:Label>
        <div style="display: inline; align-content:center">
            <asp:LinkButton ID="homeButton" runat="server">Home</asp:LinkButton>
            <asp:LinkButton ID="aboutButton" runat="server">About</asp:LinkButton>
        </div>
        <div style="display: inline; align-content:center">
        <asp:Button ID="loginButton" runat="server" Text="Login" />
        <asp:Button ID="registerButton" runat="server" Text="Get Started" />
    </div>
    

    

</header>
