<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="Assignment.StudentProfile" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>

    <link href="index.css" rel="stylesheet" />
    <link href="StudentProfile.css" rel="stylesheet" />
</head>

<body>

    <uc:Header runat="server" />
    <form id="form1" runat="server">

        <main class="profile-page">

            <div class="profile-layout">

                <!-- ============================= -->
                <!-- LEFT PROFILE CARD -->
                <!-- ============================= -->

                <aside class="profile-sidebar">

                    <div class="profile-header">

                        <div class="profile-avatar">
                            <asp:Image
                                ID="profilePic"
                                runat="server"
                                ImageUrl="~/svg/user.svg"
                                AlternateText="Profile Picture"
                                CssClass="profile-image" />
                        </div>

                        <div class="profile-name">
                            <strong id="usernameDisplay" runat="server">Username</strong>
                        </div>

                    </div>

                    <div class="profile-divider"></div>

                    <!-- Account Information -->

                    <div class="account-section">

                        <span class="section-label">ACCOUNT INFO</span>

                        <div class="account-row">
                            <span>User ID</span>
                            <span id="accountUserId" runat="server" class="account-value">—</span>
                        </div>

                        <div class="account-row">
                            <span>Username</span>
                            <span id="accountUsername" runat="server" class="account-value">—</span>
                        </div>

                        <div class="account-row">
                            <span>Role</span>
                            <span id="accountRole" runat="server" class="account-value">—</span>
                        </div>

                        <div class="account-row">
                            <span>Date Registered</span>
                            <span id="accountDateRegistered" runat="server" class="account-value">—</span>
                        </div>

                        <div class="account-row">
                            <span>School</span>
                            <span id="accountSchool" runat="server" class="account-value">—</span>
                        </div>


                    </div>
                    <div class="profile-divider"></div>

                    <!-- Profile Picture -->

                    <div class="photo-section">

                        <span class="photo-label">Profile picture
                        </span>

                        <asp:FileUpload
                            ID="ProfileImageUpload"
                            runat="server"
                            CssClass="file-upload" />

                        <label
                            for="<%= ProfileImageUpload.ClientID %>"
                            class="upload-button">

                            <span class="upload-icon">↥</span>
                            Upload photo

                        </label>

                    </div>

                </aside>


                <!-- ============================= -->
                <!-- RIGHT PROFILE FORM -->
                <!-- ============================= -->

                <section class="profile-content">

                    <h2 class="profile-title">Student Profile
                    </h2>

                    <div id="saveResult" runat="server" class="save-result" visible="false">
                    </div>

                    <!-- ============================= -->
                    <!-- BASIC INFORMATION -->
                    <!-- ============================= -->

                    <div class="form-grid">

                        <!-- First Name -->

                        <div class="form-group">

                            <label for="txtFirstName">
                                First name
                            </label>

                            <asp:TextBox
                                ID="txtFirstName"
                                runat="server"
                                CssClass="form-input"
                                placeholder="Enter first name">
                            </asp:TextBox>

                        </div>


                        <!-- Last Name -->

                        <div class="form-group">

                            <label for="txtLastName">
                                Last name
                            </label>

                            <asp:TextBox
                                ID="txtLastName"
                                runat="server"
                                CssClass="form-input"
                                placeholder="Enter last name">
                            </asp:TextBox>

                        </div>

                    </div>


                    <!-- Username -->

                    <div class="form-group">

                        <label for="txtUsername">
                            Username
                        </label>

                        <asp:TextBox
                            ID="txtUsername"
                            runat="server"
                            CssClass="form-input"
                            placeholder="Enter username">
                        </asp:TextBox>

                    </div>


                    <!-- Email -->

                    <div class="form-group">

                        <label for="txtEmail">
                            Email address
                        </label>

                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            CssClass="form-input"
                            TextMode="Email"
                            Text="nurul@ncient.edu.my">
                        </asp:TextBox>

                    </div>


                    <!-- Role -->

                    <div class="form-group">

                        <label for="txtRole">
                            Role
                        </label>

                        <asp:TextBox
                            ID="txtRole"
                            runat="server"
                            CssClass="form-input disabled-input"
                            Text="Student"
                            ReadOnly="true">
                        </asp:TextBox>

                    </div>


                    <!-- ============================= -->
                    <!-- STUDENT INFORMATION -->
                    <!-- ============================= -->

                    <div class="form-section">

                        <div class="form-section-header">
                            Student Information
                        </div>

                        <div class="section-line"></div>


                        <div class="form-grid">



                            <!-- Grade Level -->

                            <div class="form-group">

                                <label for="txtGrade">
                                    Grade Level
                                </label>

                                <asp:TextBox
                                    ID="txtGrade"
                                    runat="server"
                                    CssClass="form-input"
                                    placeholder="Enter grade level">
                                </asp:TextBox>

                            </div>

                        </div>


                        <!-- School -->

                        <div class="form-group">

                            <label for="txtSchool">
                                School
                            </label>

                            <asp:TextBox
                                ID="txtSchool"
                                runat="server"
                                CssClass="form-input"
                                placeholder="Enter school name">
                            </asp:TextBox>

                        </div>

                    </div>


                    <!-- ============================= -->
                    <!-- SECURITY -->
                    <!-- ============================= -->

                    <div class="form-section">

                        <div class="form-section-header">
                            Security
                        </div>

                        <div class="section-line"></div>


                        <!-- Password -->

                        <div class="form-group">

                            <label for="txtPassword">
                                Password
                            </label>

                            <div class="password-wrapper">

                                <asp:TextBox
                                    ID="txtPassword"
                                    runat="server"
                                    CssClass="form-input password-input disabled-input"
                                    TextMode="Password"
                                    Text="********"
                                    ReadOnly="true"
                                    autocomplete="off">
                                </asp:TextBox>

                                <asp:Button
                                    ID="btnChangePassword"
                                    runat="server"
                                    Text="Change"
                                    CssClass="change-button"
                                    CausesValidation="false"
                                    OnClick="btnChangePassword_Click" />

                            </div>

                            <span class="form-hint">
                                Click Change to reset your password with an email verification code.
                            </span>

                        </div>

                    </div>


                    <!-- ============================= -->
                    <!-- ACTION BUTTONS -->
                    <!-- ============================= -->

                    <div class="profile-actions">

                        <asp:Button
                            ID="btnSave"
                            runat="server"
                            Text="Save changes"
                            CssClass="save-button"
                            OnClick="btnSave_Click" />

                        <asp:Button
                            ID="btnDiscard"
                            runat="server"
                            Text="Discard"
                            CssClass="discard-button"
                            CausesValidation="false" />

                    </div>
                </section>

            </div>

            <!-- ============================= -->
            <!-- CHANGE PASSWORD MODAL -->
            <!-- ============================= -->

            <asp:Panel
                ID="pnlPasswordModal"
                runat="server"
                CssClass="modal-overlay"
                style="display:none;">

                <div class="modal-card" role="dialog" aria-modal="true" aria-labelledby="pwdModalTitle">

                    <asp:Button
                        ID="btnClosePasswordModal"
                        runat="server"
                        Text="&times;"
                        CssClass="modal-close"
                        CausesValidation="false"
                        OnClick="btnClosePasswordModal_Click" />

                    <h3 id="pwdModalTitle" class="modal-title">Change password</h3>

                    <p class="modal-subtitle">
                        Enter the email registered to your account. We will send a 6-digit
                        verification code to it.
                    </p>

                    <div class="otp-email-row">

                        <asp:TextBox
                            ID="txtOtpEmail"
                            runat="server"
                            CssClass="form-input"
                            TextMode="Email"
                            placeholder="name@example.com"
                            autocomplete="email">
                        </asp:TextBox>

                        <asp:Button
                            ID="btnGetCode"
                            runat="server"
                            Text="Get code"
                            CssClass="get-code-button"
                            CausesValidation="false"
                            OnClick="btnGetCode_Click" />

                    </div>

                    <asp:Label
                        ID="lblOtpInfo"
                        runat="server"
                        CssClass="modal-info"
                        EnableViewState="false" />

                    <div class="form-group">

                        <label for="txtOtp">Verification code</label>

                        <asp:TextBox
                            ID="txtOtp"
                            runat="server"
                            CssClass="form-input"
                            MaxLength="6"
                            placeholder="6-digit code"
                            autocomplete="one-time-code">
                        </asp:TextBox>

                    </div>

                    <div class="form-group">

                        <label for="txtNewPassword">New password</label>

                        <asp:TextBox
                            ID="txtNewPassword"
                            runat="server"
                            CssClass="form-input"
                            TextMode="Password"
                            placeholder="At least 8 characters"
                            autocomplete="new-password">
                        </asp:TextBox>

                    </div>

                    <div class="form-group">

                        <label for="txtConfirmPassword">Confirm new password</label>

                        <asp:TextBox
                            ID="txtConfirmPassword"
                            runat="server"
                            CssClass="form-input"
                            TextMode="Password"
                            placeholder="Re-enter new password"
                            autocomplete="new-password">
                        </asp:TextBox>

                    </div>

                    <asp:Label
                        ID="lblPasswordError"
                        runat="server"
                        CssClass="modal-error"
                        EnableViewState="false" />

                    <asp:Button
                        ID="btnSubmitPasswordChange"
                        runat="server"
                        Text="Change password"
                        CssClass="modal-submit"
                        CausesValidation="false"
                        OnClick="btnSubmitPasswordChange_Click" />

                </div>

            </asp:Panel>

        </main>

    </form>

    <uc:Footer runat="server" />

</body>
</html>
