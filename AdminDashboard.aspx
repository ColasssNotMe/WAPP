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
    </header>

    <section class="stats-grid" aria-label="Platform statistics">
      <article class="stat-card">
        <p class="stat-label">Students</p>
        <p class="stat-value" id="student_num" runat="server"></p>
        <p class="stat-note">Across 3 schools</p>
      </article>
      <article class="stat-card">
        <p class="stat-label">Teachers</p>
        <p class="stat-value" id="teacher_num" runat="server">86</p>
        <p class="stat-note" id="teacher_approval" runat="server"></p>
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

          <a class="action-card" href="AdminUserManagement.aspx?tab=pending">
            <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <circle cx="9" cy="7" r="4"/>
              <path d="M3 21v-2a6 6 0 0 1 11.5-2.5"/>
              <path d="m16 11 2 2 4-4"/>
            </svg>
            <span class="action-title">Approve teachers <span class="arrow">→</span></span>
            <span class="action-description" id="pendingTeacherNum" runat="server"></span>
          </a>

          <a class="action-card" href="AdminMaterialManagement.aspx">
            <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v16H6.5A2.5 2.5 0 0 0 4 21z"/>
              <path d="M4 5.5v13A2.5 2.5 0 0 1 6.5 16H20"/>
            </svg>
            <span class="action-title">Manage Materials <span class="arrow">→</span></span>
            <span class="action-description">Keep materials current.</span>
          </a>

          <a class="action-card" href="AdminQuizManagement.aspx">
              <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v16H6.5A2.5 2.5 0 0 0 4 21z"/>
                <path d="M4 5.5v13A2.5 2.5 0 0 1 6.5 16H20"/>
              </svg>
              <span class="action-title">Manage Quizzes <span class="arrow">→</span></span>
              <span class="action-description">Keep quizzes current.</span>
          </a>
          <a class="action-card" href="AdminClassroomManagement.aspx">
              <svg class="action-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v16H6.5A2.5 2.5 0 0 0 4 21z"/>
                <path d="M4 5.5v13A2.5 2.5 0 0 1 6.5 16H20"/>
              </svg>
              <span class="action-title">Manage Classes <span class="arrow">→</span></span>
              <span class="action-description">Keep classes current.</span>
          </a>
        </div>
      </section>

      <aside class="panel attention-panel">
        <h2 class="panel-heading">Needs Attention</h2>
        <div class="attention-list">
          <div class="attention-item">
            <span>Teacher approval</span>
            <strong id="teacherRequest" runat="server"></strong>
          </div>
        </div>
        <a class="review-button" href="AdminUserManagement.aspx?tab=pending">Review teacher requests</a>
      </aside>
    </section>

    <!-- ======================== RECENT ACTIVITY ======================== -->
    <section class="panel recent-activity-panel" style="margin-top: 24px;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
        <h2 class="panel-heading" style="margin: 0;">Recent Activity</h2>
        <a href="AdminSystemLog.aspx" class="btn primary" style="font-size: 12px; padding: 6px 12px; text-decoration: none; border-radius: 6px;">View All Logs →</a>
      </div>
      
      <div class="table-wrap">
        <table class="data-table">
          <thead>
            <tr>
              <th style="width: 200px;">Time</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            <asp:Repeater ID="rptRecentLogs" runat="server">
              <ItemTemplate>
                <tr>
                  <td style="white-space: nowrap; color: var(--secondary-color);">
                    <%# Convert.ToDateTime(Eval("createdAt")).ToString("dd MMM yyyy, hh:mm tt") %>
                  </td>
                  <td>
                    <%#: Eval("description") %>
                  </td>
                </tr>
              </ItemTemplate>
              <FooterTemplate>
                <% if (rptRecentLogs.Items.Count == 0) { %>
                  <tr>
                    <td colspan="2" class="empty" style="text-align: center; padding: 20px; color: var(--secondary-color);">No recent activity found.</td>
                  </tr>
                <% } %>
              </FooterTemplate>
            </asp:Repeater>
          </tbody>
        </table>
      </div>
    </section>
    <!-- ================================================================= -->

  </main>
    <uc:Footer ID="FooterControl" runat="server" />
  </form>
</body>
</html>