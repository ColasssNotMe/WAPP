<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Assignment.Register" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Create Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="index.css" rel="stylesheet" />
    <link href="Register.css" rel="stylesheet" />
</head>
<body>
    <uc:Header runat="server" />
    <form id="form1" runat="server">
        <main class="signup-page">
            <aside class="signup-visual" aria-label="Decorative welcome image">
                <!-- Replace this visual placeholder with your own illustration or image. -->
                <div class="visual-placeholder">
                    <span class="visually-hidden">Decorative image placeholder</span>
                </div>
            </aside>

            <section class="signup-panel" aria-labelledby="signup-title">
                <div class="signup-content">
                    <header class="signup-header">
                        <h1 id="signup-title">Create your free account</h1>
                        <p>Already have an account? <a href="Login.aspx">Log in</a></p>
                    </header>

                    <div class="signup-fields">
                        <div class="field-group role-group">
                            <asp:Label ID="RoleLabel" runat="server" AssociatedControlID="RoleRadioList"
                                CssClass="field-label" Text="Select your role" />
                            <asp:RadioButtonList ID="RoleRadioList" runat="server" RepeatDirection="Horizontal"
                                RepeatLayout="Flow" CssClass="role-options">
                                <asp:ListItem Value="Student" Selected="True">Student</asp:ListItem>
                                <asp:ListItem Value="Teacher">Teacher</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="RoleRequired" runat="server"
                                ControlToValidate="RoleRadioList" InitialValue=""
                                ErrorMessage="Please select a role." CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group">
                            <asp:Label ID="UsernameLabel" runat="server" AssociatedControlID="UsernameTextBox"
                                CssClass="field-label" Text="Username:" />
                            <div class="input-wrap">
                                <span class="input-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24">
                                        <rect x="4" y="5" width="16" height="14" rx="1"></rect><path d="m4 6 16 12M20 6 4 18"></path></svg>
                                </span>
                                <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="form-input"
                                    MaxLength="40" autocomplete="username" />
                            </div>
                            <asp:RequiredFieldValidator ID="UsernameRequired" runat="server"
                                ControlToValidate="UsernameTextBox" ErrorMessage="Please enter a username."
                                CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group">
                            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="EmailTextBox"
                                CssClass="field-label" Text="Email:" />
                            <div class="input-wrap">
                                <span class="input-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24">
                                        <rect x="4" y="5" width="16" height="14" rx="1"></rect><path d="m4 6 16 12M20 6 4 18"></path></svg>
                                </span>
                                <asp:TextBox ID="EmailTextBox" runat="server" CssClass="form-input"
                                    TextMode="Email" autocomplete="email" />
                            </div>
                            <asp:RequiredFieldValidator ID="EmailRequired" runat="server"
                                ControlToValidate="EmailTextBox" ErrorMessage="Please enter your email."
                                CssClass="validation-message" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="EmailFormatValidator" runat="server"
                                ControlToValidate="EmailTextBox" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Enter a valid email address." CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox"
                                CssClass="field-label" Text="Password:" />
                            <div class="input-wrap">
                                <span class="input-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24">
                                        <rect x="4" y="5" width="16" height="14" rx="1"></rect><path d="m4 6 16 12M20 6 4 18"></path></svg>
                                </span>
                                <asp:TextBox ID="PasswordTextBox" runat="server" CssClass="form-input password-input"
                                    TextMode="Password" autocomplete="new-password" />
                                <button type="button" class="toggle-password" data-target="<%= PasswordTextBox.ClientID %>"
                                    aria-label="Show password" aria-pressed="false">
                                    <svg viewBox="0 0 24 24" aria-hidden="true">
                                        <path d="M2.5 12s3.3-5.5 9.5-5.5 9.5 5.5 9.5 5.5-3.3 5.5-9.5 5.5S2.5 12 2.5 12Z"></path><circle cx="12" cy="12" r="2.5"></circle></svg>
                                </button>
                            </div>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"
                                ControlToValidate="PasswordTextBox" ErrorMessage="Please enter a password."
                                CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group">
                            <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPasswordTextBox"
                                CssClass="field-label" Text="Confirm Password:" />
                            <div class="input-wrap">
                                <span class="input-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24">
                                        <rect x="4" y="5" width="16" height="14" rx="1"></rect><path d="m4 6 16 12M20 6 4 18"></path></svg>
                                </span>
                                <asp:TextBox ID="ConfirmPasswordTextBox" runat="server" CssClass="form-input password-input"
                                    TextMode="Password" autocomplete="new-password" />
                                <button type="button" class="toggle-password" data-target="<%= ConfirmPasswordTextBox.ClientID %>"
                                    aria-label="Show confirm password" aria-pressed="false">
                                    <svg viewBox="0 0 24 24" aria-hidden="true">
                                        <path d="M2.5 12s3.3-5.5 9.5-5.5 9.5 5.5 9.5 5.5-3.3 5.5-9.5 5.5S2.5 12 2.5 12Z"></path><circle cx="12" cy="12" r="2.5"></circle></svg>
                                </button>
                            </div>
                            <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server"
                                ControlToValidate="ConfirmPasswordTextBox" ErrorMessage="Please confirm your password."
                                CssClass="validation-message" Display="Dynamic" />
                            <asp:CompareValidator ID="PasswordCompareValidator" runat="server"
                                ControlToCompare="PasswordTextBox" ControlToValidate="ConfirmPasswordTextBox"
                                ErrorMessage="Passwords do not match." CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group">
                            <asp:Label ID="SchoolLabel" runat="server" AssociatedControlID="SchoolDropDown"
                                CssClass="field-label" Text="School:" />
                            <asp:DropDownList ID="SchoolDropDown" runat="server" CssClass="form-select">
                                <asp:ListItem Value="" Text="Select your school" />
                                <asp:ListItem Value="school-a" Text="School A" />
                                <asp:ListItem Value="school-b" Text="School B" />
                                <asp:ListItem Value="school-c" Text="School C" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="SchoolRequired" runat="server"
                                ControlToValidate="SchoolDropDown" InitialValue=""
                                ErrorMessage="Please select your school." CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group">
                            <asp:Label ID="FormLabel" runat="server" AssociatedControlID="FormDropDown"
                                CssClass="field-label" Text="Form:" />
                            <asp:DropDownList ID="FormDropDown" runat="server" CssClass="form-select">
                                <asp:ListItem Value="" Text="Select your form" />
                                <asp:ListItem Value="Form 1" Text="Form 1" />
                                <asp:ListItem Value="Form 2" Text="Form 2" />
                                <asp:ListItem Value="Form 3" Text="Form 3" />
                                <asp:ListItem Value="Form 4" Text="Form 4" />
                                <asp:ListItem Value="Form 5" Text="Form 5" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="FormRequired" runat="server"
                                ControlToValidate="FormDropDown" InitialValue=""
                                ErrorMessage="Please select your form." CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <asp:Button ID="CreateAccountButton" runat="server" Text="Create Account  ⟶"
                            CssClass="create-account-button"  />
                        <asp:Label ID="SignupMessage" runat="server" CssClass="signup-message" EnableViewState="false" />
                    </div>
                </div>
            </section>
        </main>
    </form>

    <uc:Footer runat="server" />
</body>
</html>
