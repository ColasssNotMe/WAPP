<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="Assignment.WebUserControl1" %>

<link href="Header.css" rel="stylesheet" />

<header class="site-header">
    <!-- Left: Logo -->
    <div class="header-left">
        <button class="logo-button">
            <img src="img/logo.png" alt="Logo" class="header-logo" />
        </button>
    </div>

    <!-- Center: Navigation Links -->
    <nav class="header-nav">
        <a id="homeButton" runat="server" href="HomePage.aspx" class="nav-link">Home</a>
        <a id="aboutButton" runat="server" href="About.aspx" class="nav-link">About</a>
        <a id="dashboardButton" runat="server" href="Homepage.aspx" class="nav-link">Dashboard</a>
        <a id="classroomButton" runat="server" class="nav-link" href="">Classroom</a>
        <!--<asp:Label ID="roleDebug" runat="server" Text="role debug"></asp:Label>-->
    </nav>

    <!-- Right: Action Buttons -->
    <div class="header-actions" runat="server" id="headerActions">
        <button id="loginButton" runat="server" type="button" onclick="window.location.href='Login.aspx'">Login</button>
        <button id="registerButton" runat="server" type="button" class="btn-primary" onclick="window.location.href='Register.aspx'">Get Started</button>
    </div>

<div class="header-profile" runat="server" id="headerProfile">

    <div class="profile-container">

        <!-- Profile Picture -->
        <button id="profileButton"
                runat="server"
                onserverclick="ProfileButton_Click"
                class="profile-button">

            <img id="profilePic"
                 runat="server"
                 alt="Profile Picture"
                 class="profile-pic" />

        </button>

        <!-- Hidden Logout Div -->
        <div class="logout-menu">
            <asp:LinkButton ID="logoutButton"
                runat="server"
                CssClass="logout-link"
                OnClick="LogoutButton_Click">
                Logout
            </asp:LinkButton>
        </div>

    </div>

   </div>


</header>
