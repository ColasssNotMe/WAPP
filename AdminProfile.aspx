<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="Assignment.AdminProfile" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Profile | Ncient</title>
    <link rel="stylesheet" href="AdminProfile.css" />
    <link rel="stylesheet" href="index.css" />
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header ID="HeaderControl" runat="server" />
        <main class="profile-page">
            <header class="page-header">
                <h1>Admin Profile</h1>
                <p>Manage your administrator account, contact details, and security settings.</p>
            </header>

            <div class="profile-grid">
                <!-- Left: identity card -->
                <section class="panel identity-panel">
                    <div class="identity">
                        <div class="avatar" id="avatar" runat="server"></div>
                        <p class="identity-name" id="displayName" runat="server"></p>
                        <p class="identity-meta" id="userMeta" runat="server"></p>
                    </div>
                    <div class="profile-details">
                        <div class="detail-row">
                            <span class="detail-label">Role</span>
                            <span class="detail-badge-role">Administrator</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Access</span>
                            <span class="detail-value">Full platform access</span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Joined</span>
                            <span class="detail-value" id="joinedDate" runat="server"></span>
                        </div>
                    </div>
                    <div class="profile-note">
                        Responsible for user access, learning content, and platform moderation.
                    </div>
                </section>

                <!-- Right: settings + security -->
                <div class="settings-column">

                    <!-- Account settings -->
                    <section class="panel">
                        <div class="panel-heading-row">
                            <div>
                                <h2>Account settings</h2>
                                <p class="panel-sub">Your personal and contact details.</p>
                            </div>
                            <div class="heading-actions">
                                <asp:Label ID="lblEditing" runat="server"
                                    CssClass="badge editing-badge" Text="Editing" Visible="false" />
                                <asp:Button ID="btnEdit" runat="server"
                                    Text="Edit profile"
                                    CssClass="button button-outline"
                                    CausesValidation="false"
                                    OnClick="btnEdit_Click" />
                            </div>
                        </div>

                        <div id="pageMessage" runat="server" class="toast-message" visible="false" role="status"></div>

                        <div class="profile-form">
                            <div class="form-row">
                                <div class="form-field">
                                    <label for="firstName">First name</label>
                                    <input id="firstName" type="text" runat="server" maxlength="50" placeholder="First name" />
                                </div>
                                <div class="form-field">
                                    <label for="lastName">Last name</label>
                                    <input id="lastName" type="text" runat="server" maxlength="50" placeholder="Last name" />
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-field">
                                    <label for="usernameInput">Username</label>
                                    <input id="usernameInput" type="text" runat="server" maxlength="50" placeholder="Enter username" />
                                </div>
                                <div class="form-field">
                                    <label for="email">Email address</label>
                                    <input id="email" type="email" runat="server" maxlength="100" placeholder="name@example.com" />
                                </div>
                            </div>
                            <div class="form-field" id="schoolField" runat="server">
                                <label for="school">School / Institution</label>
                                <input id="school" type="text" runat="server" maxlength="100" placeholder="Institution name" />
                            </div>
                        </div>

                        <asp:Panel ID="pnlEditActions" runat="server" CssClass="form-actions" Visible="false">
                            <asp:Button ID="btnSave" runat="server"
                                Text="Save changes"
                                CssClass="button button-primary"
                                OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancelEdit" runat="server"
                                Text="Cancel"
                                CssClass="button button-subtle"
                                CausesValidation="false"
                                OnClick="btnCancelEdit_Click" />
                        </asp:Panel>
                    </section>

                    <!-- Security -->
                    <section class="panel">
                        <div class="panel-heading-row">
                            <div>
                                <h2>Security</h2>
                                <p class="panel-sub">Keep your administrator account protected.</p>
                            </div>
                            <div class="heading-actions">
                                <asp:Button ID="btnShowPassword" runat="server"
                                    Text="Change password"
                                    CssClass="button button-outline"
                                    CausesValidation="false"
                                    OnClick="btnShowPassword_Click" />
                            </div>
                        </div>

                        <div id="passwordMessage" runat="server" class="toast-message" visible="false" role="alert"></div>

                        <asp:Panel ID="pnlPassword" runat="server" Visible="false">
                            <p class="dialog-note">
                                Use at least 8 characters. A mix of letters, numbers and symbols is recommended.
                            </p>
                            <div class="profile-form">
                                <div class="form-field">
                                    <label for="txtCurrentPassword">Current password</label>
                                    <asp:TextBox ID="txtCurrentPassword" runat="server"
                                        TextMode="Password" MaxLength="100"
                                        autocomplete="current-password"
                                        placeholder="Enter current password" />
                                </div>
                                <div class="form-row">
                                    <div class="form-field">
                                        <label for="txtNewPassword">New password</label>
                                        <asp:TextBox ID="txtNewPassword" runat="server"
                                            TextMode="Password" MaxLength="100"
                                            autocomplete="new-password"
                                            placeholder="Enter new password" />
                                    </div>
                                    <div class="form-field">
                                        <label for="txtConfirmPassword">Confirm new password</label>
                                        <asp:TextBox ID="txtConfirmPassword" runat="server"
                                            TextMode="Password" MaxLength="100"
                                            autocomplete="new-password"
                                            placeholder="Confirm new password" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <asp:Button ID="btnChangePassword" runat="server"
                                    Text="Update password"
                                    CssClass="button button-primary"
                                    OnClick="btnChangePassword_Click" />
                                <asp:Button ID="btnCancelPassword" runat="server"
                                    Text="Cancel"
                                    CssClass="button button-subtle"
                                    CausesValidation="false"
                                    OnClick="btnCancelPassword_Click" />
                            </div>
                        </asp:Panel>
                    </section>
                </div>
            </div>
        </main>
        <uc:Footer ID="FooterControl" runat="server" />
    </form>
</body>
</html>