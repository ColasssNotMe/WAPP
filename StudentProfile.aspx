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
                            CN
                        </div>

                        <div class="profile-name">
                            <strong>Aiman</strong>
                        </div>

                    </div>

                    <div class="profile-divider"></div>

                    <!-- Account Information -->

                    <div class="account-section">

                        <span class="section-label">ACCOUNT INFO
                        </span>

                        <div class="account-row">
                            <span>User ID</span>
                            <span class="account-value">—</span>
                        </div>

                        <div class="account-row">
                            <span>Username</span>
                            <span class="account-value">—</span>
                        </div>

                        <div class="account-row">
                            <span>Role</span>
                            <span class="account-value">Student</span>
                        </div>

                        <div class="account-row">
                            <span>Date Registered</span>
                            <span class="account-value">January 2026
                            </span>
                        </div>

                        <div class="account-row">
                            <span>School</span>
                            <span class="account-value">SMK Taman Melawati
                            </span>
                        </div>

                        <div class="account-row">
                            <span>Subject</span>
                            <span class="account-value">Sejarah KSSM
                            </span>
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
                                Text="Nurul">
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

                            <!-- Age -->

                            <div class="form-group">

                                <label for="txtAge">
                                    Age
                                </label>

                                <asp:TextBox
                                    ID="txtAge"
                                    runat="server"
                                    CssClass="form-input"
                                    TextMode="Number"
                                    placeholder="Enter age">
                                </asp:TextBox>

                            </div>


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
                                    CssClass="form-input password-input"
                                    TextMode="Password"
                                    Text="password123">
                                </asp:TextBox>

                                <asp:Button
                                    ID="btnChangePassword"
                                    runat="server"
                                    Text="Change"
                                    CssClass="change-button"
                                    CausesValidation="false" />

                            </div>

                            <span class="form-hint">Use a strong password of at least 8 characters.
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
                            CssClass="save-button" />

                        <asp:Button
                            ID="btnDiscard"
                            runat="server"
                            Text="Discard"
                            CssClass="discard-button"
                            CausesValidation="false" />

                    </div>

                </section>

            </div>

        </main>

    </form>

    <uc:Footer runat="server" />

</body>
</html>
