<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="Assignment.AdminProfile" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Profile | Ncient</title>
    <link rel="stylesheet" href="AdminProfile.css">
    <link rel="stylesheet" href="index.css">

</head>
<body>
  <uc:Header ID="HeaderControl" runat="server" />
  <main class="profile-page">
    <header class="page-header">
      <h1>Admin Profile</h1>
      <p>Manage your administrator account, contact details, and security settings.</p>
    </header>

    <section class="panel" aria-labelledby="administrator-heading">
      <h2 id="administrator-heading">Administrator</h2>

      <div class="identity">
        <div class="avatar" aria-label="Farah Aziz initials">FA</div>
        <div>
          <p class="identity-name">Farah Aziz</p>
          <p class="identity-meta">admin001 • Ncient Education</p>
        </div>
      </div>

      <div class="profile-details">
        <span class="detail-label">Role</span>
        <span class="detail-value">Administrator</span>

        <span class="detail-label">Access</span>
        <span class="detail-value">Full platform access</span>

        <span class="detail-label">Joined</span>
        <span class="detail-value">January 2026</span>
      </div>

      <p class="profile-note">Responsible for user access, learning content, and platform moderation.</p>
    </section>

    <section class="panel settings-panel" aria-labelledby="settings-heading">
      <h2 id="settings-heading">Account Settings</h2>

      <form class="profile-form" id="profileForm">
        <div class="form-field">
          <label for="fullName">Full name</label>
          <input id="fullName" name="fullName" type="text" value="Farah Aziz" autocomplete="name" required>
        </div>

        <div class="form-field">
          <label for="email">Email address</label>
          <input id="email" name="email" type="email" value="farah@ncient.edu.my" autocomplete="email" required>
        </div>

        <div class="form-field">
          <label for="phone">Phone number</label>
          <input id="phone" name="phone" type="tel" value="+60 12-456 7890" autocomplete="tel">
        </div>

        <div class="form-field">
          <label for="organisation">Organisation</label>
          <input id="organisation" name="organisation" type="text" value="Ncient Education" autocomplete="organization">
        </div>

        <div class="form-actions">
          <button class="button button-primary" type="submit">Save changes</button>
          <button class="button button-secondary" type="button" id="changePasswordButton">Change password</button>
        </div>
        <p id="formMessage" role="status" aria-live="polite" hidden></p>
      </form>
    </section>
  </main>
    <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>
