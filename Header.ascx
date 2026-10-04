<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Assignment.WebUserControl1" %>

<header class="header-container" style="background-color: #808080; color: white; padding: 10px 20px; white-space: nowrap; display: flex; align-items: center; justify-content: space-between;">
    
    <div style="display: inline-block; width: 33%; text-align: left; vertical-align: middle;">
        <span id="websiteName" runat="server" style="font-size: xx-large; font-weight: bold;">Ncient</span>
    </div>

    <!-- Center: Navigation Links -->
    <div style="display: inline-block; width: 33%; text-align: center; vertical-align: middle;">
        <a id="homeButton" runat="server" href="HomePage.aspx" class="nav-link" style="color: white; text-decoration: none; margin-right: 15px;">Home</a>
        <a id="aboutButton" runat="server" href="About.aspx" class="nav-link" style="color: white; text-decoration: none;">About</a>
    </div>

    <!-- Right: Action Buttons -->
    <div style="display: inline-block; width: 33%; text-align: right; vertical-align: middle;">
        <button id="loginButton" runat="server" type="button" style="margin-right: 5px;">Login</button>
        <button id="registerButton" runat="server" type="button">Get Started</button>
    </div>

</header>