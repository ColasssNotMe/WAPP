<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Assignment.AdminDashboard" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard | Ncient</title>
  <link rel="stylesheet" href="AdminDashboard.css">
  <link rel="stylesheet" href="index.css">
  
</head>
<body>
  <form id="adminForm" runat="server">
  <uc:Header ID="HeaderControl" runat="server" />
  <main class="dashboard">
    <header class="page-header">
      <div>
        <h1>Admin Dashboard</h1>
        <p id="welcomeMessage" runat="server"></p>
      </div>
      <span class="overview-pill">Platform overview</span>
      <button type="button" class="overview-pill" onclick="document.getElementById('addAdminModal').style.display='flex';">Add new admin</button>
    </header>
    <a  href="AdminProfile.aspx" text="View Profile">

    <div id="addAdminModal" class="admin-modal" style="display:none;">
      <div class="admin-modal-content" role="dialog" aria-modal="true" aria-labelledby="addAdminTitle">
        <button type="button" class="admin-modal-close" onclick="document.getElementById('addAdminModal').style.display='none';">&times;</button>
        <h2 id="addAdminTitle">Add new admin</h2>
        <asp:Label ID="adminMessage" runat="server" CssClass="admin-message" />
        <label for="adminUsername">Username</label>
        <asp:TextBox ID="adminUsername" runat="server" MaxLength="50" />
        <asp:RequiredFieldValidator ID="adminUsernameRequired" runat="server" ControlToValidate="adminUsername" ErrorMessage="Username is required." CssClass="admin-message" />
        <label for="adminEmail">Email</label>
        <asp:TextBox ID="adminEmail" runat="server" TextMode="Email" MaxLength="255" />
        <asp:RequiredFieldValidator ID="adminEmailRequired" runat="server" ControlToValidate="adminEmail" ErrorMessage="Email is required." CssClass="admin-message" />
        <label for="adminPassword">Password</label>
        <asp:TextBox ID="adminPassword" runat="server" TextMode="Password" MaxLength="255" />
        <asp:RequiredFieldValidator ID="adminPasswordRequired" runat="server" ControlToValidate="adminPassword" ErrorMessage="Password is required." CssClass="admin-message" />
        <asp:Button ID="addAdminButton" runat="server" Text="Create admin" CssClass="review-button" OnClick="AddAdminButton_Click" />
      </div>
    </div>


    <section class="stats-grid" aria-label="Platform statistics">
      <article class="stat-card">
        <p class="stat-label">Students</p>
        <p class="stat-value" id="student_num" runat="server"></p>
        <p class="stat-note">Across 24 schools</p>
      </article>
      <article class="stat-card">
        <p class="stat-label">Teachers</p>
        <p class="stat-value" id="teacher_num" runat="server">86</p>
        <p class="stat-note" id="teacher_approval" runat="server">8 awaiting approval</p>
      </article>
      <article class="stat-card">
        <p class="stat-label">Classrooms</p>
        <p class="stat-value" id="classroom_num" runat="server">142</p>
        <p class="stat-note">128 active classrooms</p>
      </article>
      <article class="stat-card">
        <p class="stat-label">Quizzes</p>
        <p class="stat-value" id="quiz_num" runat="server">324</p>
        <p class="stat-note">18 published this week</p>
      </article>
    </section>
    
    <section class="content-grid" aria-label="Administration tools and attention items">
      <section class="panel quick-panel">
        <h2 class="panel-heading">Quick actions</h2>
        <p class="panel-description">Your most common administration tasks, one step away.</p>

        <div class="action-grid">
          <a class="action-card" href="AdminUserManagement.aspx">
            <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <path d="M16 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
              <circle cx="10" cy="7" r="4"/>
              <path d="M20 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
            <span class="action-title">Manage users <span class="arrow">→</span></span>
            <span class="action-description">Review accounts and access.</span>
          </a>

          <a class="action-card" href="AdminUserManagement.aspx">
            <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <circle cx="9" cy="7" r="4"/>
              <path d="M3 21v-2a6 6 0 0 1 11.5-2.5"/>
              <path d="m16 11 2 2 4-4"/>
            </svg>
            <span class="action-title">Approve teachers <span class="arrow">→</span></span>
            <span class="action-description">8 registrations need a decision.</span>
          </a>

          <a class="action-card" href="AdminMaterialManagement.aspx">
            <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v16H6.5A2.5 2.5 0 0 0 4 21z"/>
              <path d="M4 5.5v13A2.5 2.5 0 0 1 6.5 16H20"/>
            </svg>
            <span class="action-title">Manage content <span class="arrow">→</span></span>
            <span class="action-description">Keep quizzes and materials current.</span>
          </a>
        </div>
      </section>

      <aside class="panel attention-panel">
        <h2 class="panel-heading">Needs Attention</h2>
        <div class="attention-list">
          <div class="attention-item">
            <span>Teacher approval</span>
            <strong>8 requests</strong>
          </div>
          <div class="attention-item">
            <span class="flagged-label">Flagged comments</span>
            <strong>3 to review</strong>
          </div>
          <div class="attention-item">
            <span>Material review</span>
            <strong>5 pending</strong>
          </div>
        </div>
        <a class="review-button" href="AdminUserManagement.aspx">Review teacher requests</a>
      </aside>
    </section>
  </main>
    <uc:Footer ID="FooterControl" runat="server" />
  </form>
</body>
</html>
