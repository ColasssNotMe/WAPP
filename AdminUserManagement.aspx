<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminUserManagement.aspx.cs" Inherits="Assignment.AdminUserManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User Management | Ncient</title>
  <link rel="stylesheet" href="AdminUserManagement.css">
  <link rel="stylesheet" href="index.css">
</head>
<body>
    <uc:Header ID="HeaderControl" runat="server" />
  <main class="dashboard">
    <header class="page-header">
      <div>
        <h1>User Management</h1>
        <p>Manage platform accounts, roles, and access for students, teachers, and administrators.</p>
      </div>
      <span class="overview-pill">1,338 users</span>
    </header>

    <div class="notice-bar" role="status">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
        <path d="M10.3 3.9 1.8 18a2 2 0 0 0 1.7 3h17a2 2 0 0 0 1.7-3L13.7 3.9a2 2 0 0 0-3.4 0z"/>
        <path d="M12 9v4M12 17h.01"/>
      </svg>
      <span>8 teachers are awaiting approval. Pending teachers cannot access teacher functions until approved.</span>
    </div>

    <section class="content-grid" aria-label="User directory and details">
      <section class="panel">
        <h2 class="panel-heading">User directory</h2>
        <p class="panel-description">1,248 accounts · 1,176 students · 60 teachers · 12 administrators</p>

        <div class="tab-list" role="tablist">
          <button class="tab" type="button" role="tab" aria-selected="true">All Users</button>
          <button class="tab" type="button" role="tab" aria-selected="false">Students</button>
          <button class="tab" type="button" role="tab" aria-selected="false">Teachers</button>
          <a class="tab" href="teacher-approvals.html">Pending Teacher Approvals</a>
        </div>

        <div class="filter-row">
          <label class="search-field">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
            <input type="search" placeholder="Search name, username or email" aria-label="Search users" />
          </label>
          <button class="select-button" type="button">
            Account status: All
            <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m6 9 6 6 6-6"/></svg>
          </button>
        </div>

        <div class="table-wrap">
          <table class="data-table">
            <thead>
              <tr><th>Name</th><th>Username</th><th>Email</th><th>Role</th><th>Account Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
              <tr><td class="user-name">Nur Aisyah Rahman</td><td>aisyah.rahman</td><td class="user-email">aisyah.rahman@ncient.my</td><td>Admin</td><td class="status status--active">Active</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="user-name">Ahmad Farid Abdullah</td><td>ahmad.farid</td><td class="user-email">farid.abdullah@ncient.my</td><td>Teacher</td><td class="status status--active">Active</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="user-name">Siti Hajar Ismail</td><td>siti.hajar</td><td class="user-email">siti.hajar@ncient.my</td><td>Teacher</td><td class="status status--active">Active</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="user-name">Nurul Izzah Hassan</td><td>nurul.izzah</td><td class="user-email">nurul.izzah@ncient.my</td><td>Teacher</td><td class="status status--pending">Pending</td><td class="row-actions"><a href="teacher-approvals.html">Review</a></td></tr>
              <tr><td class="user-name">Raj Kumar</td><td>raj.kumar</td><td class="user-email">raj.kumar@ncient.my</td><td>Teacher</td><td class="status status--pending">Pending</td><td class="row-actions"><a href="teacher-approvals.html">Review</a></td></tr>
              <tr><td class="user-name">Aina Sofea Zulkifli</td><td>aina.sofea</td><td class="user-email">aina.sofea@ncient.my</td><td>Student</td><td class="status status--active">Active</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="user-name">Muhammad Danish</td><td>muhammad.danish</td><td class="user-email">danish@ncient.my</td><td>Student</td><td class="status status--active">Active</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="user-name">Lim Wei Jun</td><td>lim.wei.jun</td><td class="user-email">wei.jun@ncient.my</td><td>Student</td><td class="status status--disabled">Disabled</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
            </tbody>
          </table>
        </div>

        <div class="pagination">
          <span class="pagination-note">Showing 1–8 of 1,248 accounts</span>
          <div class="pagination-controls">
            <button class="page-button" type="button">Previous</button>
            <button class="page-button" type="button" aria-current="page">1</button>
            <button class="page-button" type="button">Next</button>
          </div>
        </div>
      </section>

      <aside class="panel">
        <h2 class="panel-heading">User Details</h2>
        <dl class="detail-list">
          <dt>Name</dt><dd>Aiman bin Abdullah</dd>
          <dt>User ID</dt><dd>user001</dd>
          <dt>Role</dt><dd>Student</dd>
          <dt>School</dt><dd>SMK Taman Melawati</dd>
          <dt>Registered</dt><dd>12 Jan 2026</dd>
          <dt>Last active</dt><dd>Today, 10:15 AM</dd>
          <dt>Status</dt><dd class="status--active">Active</dd>
        </dl>
        <p class="detail-note">Role changes update platform permissions. Suspended accounts cannot sign in.</p>
        <button class="primary-button" type="button">Edit user</button>
      </aside>
    </section>
  </main>
    <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>

