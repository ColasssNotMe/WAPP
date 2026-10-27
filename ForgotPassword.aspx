<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Assignment.ForgotPassword" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Forgot Password</title>
    <link href="index.css" rel="stylesheet" />
    <link href="Login.css" rel="stylesheet" />
    <link href="ForgotPassword.css" rel="stylesheet" />
</head>
<body>
    <uc:Header runat="server" />
    <form id="form1" runat="server">
        <main class="login-page">
            <section class="login-panel" aria-label="Reset password">
                <div class="login-content reset-content">
                    <header class="welcome-header">
                        <h1>Forgot password?</h1>
                        <p>Remembered it? <a href="Login.aspx">Back to sign in</a></p>
                    </header>

                    <div class="form-fields">

                        <div class="field-group">
                            <asp:Label
                                ID="EmailLabel"
                                runat="server"
                                AssociatedControlID="EmailTextBox"
                                CssClass="field-label"
                                Text="Registered Email:" />

                            <div class="otp-email-row">
                                <asp:TextBox
                                    ID="EmailTextBox"
                                    runat="server"
                                    CssClass="form-input"
                                    TextMode="Email"
                                    autocomplete="email" />

                                <asp:Button
                                    ID="btnGetCode"
                                    runat="server"
                                    Text="Get code"
                                    CssClass="get-code-button"
                                    OnClick="btnGetCode_Click" />
                            </div>

                            <asp:RequiredFieldValidator
                                ID="EmailRequired"
                                runat="server"
                                ControlToValidate="EmailTextBox"
                                ErrorMessage="Please enter your registered email address."
                                CssClass="validation-message"
                                Display="Dynamic" />

                            <asp:RegularExpressionValidator
                                ID="EmailFormatValidator"
                                runat="server"
                                ControlToValidate="EmailTextBox"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Enter a valid email address."
                                CssClass="validation-message"
                                Display="Dynamic" />
                        </div>

                        <asp:Label
                            ID="InfoMessage"
                            runat="server"
                            CssClass="login-message info"
                            EnableViewState="false"
                            Visible="false" />

                        <div class="field-group">
                            <asp:Label
                                ID="OtpLabel"
                                runat="server"
                                AssociatedControlID="OtpTextBox"
                                CssClass="field-label"
                                Text="Verification code:" />

                            <asp:TextBox
                                ID="OtpTextBox"
                                runat="server"
                                CssClass="form-input"
                                MaxLength="6"
                                placeholder="6-digit code"
                                autocomplete="one-time-code" />
                        </div>

                        <div class="field-group">
                            <asp:Label
                                ID="NewPasswordLabel"
                                runat="server"
                                AssociatedControlID="NewPasswordTextBox"
                                CssClass="field-label"
                                Text="New password:" />

                            <asp:TextBox
                                ID="NewPasswordTextBox"
                                runat="server"
                                CssClass="form-input"
                                TextMode="Password"
                                placeholder="At least 8 characters"
                                autocomplete="new-password" />
                        </div>

                        <div class="field-group">
                            <asp:Label
                                ID="ConfirmPasswordLabel"
                                runat="server"
                                AssociatedControlID="ConfirmPasswordTextBox"
                                CssClass="field-label"
                                Text="Confirm new password:" />

                            <asp:TextBox
                                ID="ConfirmPasswordTextBox"
                                runat="server"
                                CssClass="form-input"
                                TextMode="Password"
                                placeholder="Re-enter new password"
                                autocomplete="new-password" />
                        </div>

                        <asp:Label
                            ID="ErrorMessage"
                            runat="server"
                            CssClass="login-message"
                            EnableViewState="false"
                            Visible="false" />

                        <asp:Button
                            ID="btnChangePassword"
                            runat="server"
                            Text="Change password"
                            CssClass="sign-in-button reset-submit"
                            OnClick="btnChangePassword_Click" />

                        <asp:Label
                            ID="SuccessMessage"
                            runat="server"
                            CssClass="login-message success"
                            EnableViewState="false"
                            Visible="false" />

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

    <uc:Footer runat="server" />
</body>
</html>
