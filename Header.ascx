<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Assignment.WebUserControl1" %>

<link href="Header.css" rel="stylesheet" />

<header class="site-header">
    <!-- Left: Logo -->
    <div class="header-left">
        <img src="img/logo.png" alt="Logo" class="header-logo" />
    </div>

    <!-- Center: Navigation Links -->
    <nav class="header-nav">
        <a id="homeButton" runat="server" href="HomePage.aspx" class="nav-link">Home</a>
        <a id="aboutButton" runat="server" href="About.aspx" class="nav-link">About</a>
    </nav>

    <!-- Right: Action Buttons -->
    <div class="header-actions">
        <button id="loginButton" runat="server" type="button">Login</button>
        <button id="registerButton" runat="server" type="button" class="btn-primary">Get Started</button>
    </div>
</header>