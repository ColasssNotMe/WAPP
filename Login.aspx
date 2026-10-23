<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Assignment.Login" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Sign In </title>
    <link href="index.css" rel="stylesheet" />
    <link href="Login.css" rel="stylesheet" />
</head>
<body>
    <uc:Header runat="server" />
    <form id="form1" runat="server">
        <main class="login-page">
            <section class="login-panel" aria-label="Sign in">
                <div class="login-content">
                    <header class="welcome-header">
                        <h1>Welcome back</h1>
                        <p>Don't have an account? <a href="Register.aspx">Sign up</a></p>
                    </header>

                    <div class="form-fields">
                        <div class="field-group">
                            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="EmailTextBox" CssClass="field-label"
                                Text="Work or Academic Email:" />
                            <div class="input-wrap">
                                <span class="input-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="14" rx="1"></rect><path d="m4 6 8 7 8-7"></path></svg>
                                </span>
                                <asp:TextBox ID="EmailTextBox" runat="server" CssClass="form-input" TextMode="Email"
                                    autocomplete="username" />
                            </div>
                            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="EmailTextBox"
                                ErrorMessage="Please enter your email address." CssClass="validation-message" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="EmailFormatValidator" runat="server" ControlToValidate="EmailTextBox"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Enter a valid email address."
                                CssClass="validation-message" Display="Dynamic" />
                        </div>

                        <div class="field-group password-group">
                            <div class="label-row">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" CssClass="field-label"
                                    Text="Password:" />
                                <a href="ForgotPassword.aspx" class="forgot-link">Forgot Password?</a>
                            </div>
                            <div class="input-wrap">
                                <span class="input-icon password-icon" aria-hidden="true">
                                    <img src="svg/password.svg"  width="20" height="20"/>
                                </span>
                                <asp:TextBox ID="PasswordTextBox" runat="server" CssClass="form-input password-input"
                                    TextMode="Password" autocomplete="current-password" />
                                <button type="button" class="toggle-password" id="togglePassword" aria-label="Show password" aria-pressed="false">
                                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M2.5 12s3.3-5.5 9.5-5.5 9.5 5.5 9.5 5.5-3.3 5.5-9.5 5.5S2.5 12 2.5 12Z"></path><circle cx="12" cy="12" r="2.5"></circle></svg>
                                </button>
                            </div>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="PasswordTextBox"
                                ErrorMessage="Please enter your password." CssClass="validation-message" Display="Dynamic" />
                        </div>


                        <asp:Button ID="SignInButton" runat="server" Text="Sign In to Ncient  →"
                            CssClass="sign-in-button" OnClick="SignInButton_Click"  />
                        <asp:Label ID="LoginMessage" runat="server" CssClass="login-message" EnableViewState="false" />
                    </div>
                </div>
            </section>

            <aside class="visual-panel" aria-label="Welcome illustration">
                <div class="visual-placeholder">
                    <img src="img/loginImage.jpg" />
                </div>
            </aside>
        </main>
    </form>

    <uc:Footer  runat="server" />
</body>
</html>
