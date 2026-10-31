<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Assignment.ForgotPassword" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password - Ncient</title>
    <link href="index.css" rel="stylesheet" />
    <link rel="stylesheet" href="ForgotPassword.css" />
</head>
<body>
    <uc:Header runat="server" />

    <form id="form1" runat="server">
        <main class="forgot-page">
            <section class="forgot-panel" aria-label="Forgot Password Panel">
                <div class="forgot-content">
                    
                    <asp:MultiView ID="ResetMultiView" runat="server" ActiveViewIndex="0">
                        
                        <!-- ================= STEP 1: ENTER EMAIL ================= -->
                        <asp:View ID="ViewEmail" runat="server">
                            <header class="welcome-header">
                                <span class="step-badge">Step 1 of 3</span>
                                <h1>Forgot Password</h1>
                                <p>Enter your account email to receive a 6-digit verification code.</p>
                            </header>
                            <div class="form-fields">
                                <div class="field-group">
                                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" CssClass="field-label" Text="Registered Email:" />
                                    <div class="input-wrap">
                                        <span class="input-icon" aria-hidden="true">
                                            <svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="14" rx="1"></rect><path d="m4 6 8 7 8-7"></path></svg>
                                        </span>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email" placeholder="e.g. user@gmail.com" />
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Please enter your email." CssClass="validation-message" Display="Dynamic" ValidationGroup="EmailGroup" />
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Enter a valid email address."
                                        CssClass="validation-message" Display="Dynamic" ValidationGroup="EmailGroup" />
                                </div>
                                <asp:Button ID="btnSendOTP" runat="server" Text="Send Verification Code  →"
                                    CssClass="submit-button" ValidationGroup="EmailGroup" OnClick="btnSendOTP_Click" />
                                
                                <asp:Label ID="lblMessageStep1" runat="server" CssClass="error-message" EnableViewState="false" />
                                <p style="font-size: 12px; margin-top: 16px; color: var(--secondary-color);">
                                    Remembered your password? <a href="Login.aspx" class="text-link">Sign in</a>
                                </p>
                            </div>
                        </asp:View>
                        <!-- ================= STEP 2: ENTER OTP ================= -->
                        <asp:View ID="ViewOTP" runat="server">
                            <header class="welcome-header">
                                <span class="step-badge">Step 2 of 3</span>
                                <h1>Check your email</h1>
                                <p>We've sent a 6-digit code to <strong><asp:Literal ID="litSentToEmail" runat="server" /></strong></p>
                            </header>
                            <div class="form-fields">
                                <div class="field-group">
                                    <asp:Label ID="lblOTP" runat="server" AssociatedControlID="txtOTP" CssClass="field-label" Text="6-Digit Verification Code:" />
                                    <div class="input-wrap">
                                        <asp:TextBox ID="txtOTP" runat="server" CssClass="form-input otp-input" MaxLength="6" placeholder="000000" />
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvOTP" runat="server" ControlToValidate="txtOTP"
                                        ErrorMessage="Please enter the 6-digit OTP." CssClass="validation-message" Display="Dynamic" ValidationGroup="OTPGroup" />
                                </div>
                                <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify Code  →"
                                    CssClass="submit-button" ValidationGroup="OTPGroup" OnClick="btnVerifyOTP_Click" />
                                <div class="link-row">
                                    <asp:Button ID="btnResendOTP" runat="server" Text="Didn't get code? Resend" CssClass="text-link" OnClick="btnResendOTP_Click" CausesValidation="false" />
                                    <asp:Button ID="btnChangeEmail" runat="server" Text="Change Email" CssClass="text-link" OnClick="btnChangeEmail_Click" CausesValidation="false" />
                                </div>
                                <asp:Label ID="lblMessageStep2" runat="server" CssClass="error-message" EnableViewState="false" />
                            </div>
                        </asp:View>
                        <!-- ================= STEP 3: RESET PASSWORD ================= -->
                        <asp:View ID="ViewNewPassword" runat="server">
                            <header class="welcome-header">
                                <span class="step-badge">Step 3 of 3</span>
                                <h1>Set New Password</h1>
                                <p>Create a secure new password for your account.</p>
                            </header>
                            <div class="form-fields">
                                <div class="field-group">
                                    <asp:Label ID="lblNewPass" runat="server" AssociatedControlID="txtNewPassword" CssClass="field-label" Text="New Password:" />
                                    <div class="input-wrap">
                                        <span class="input-icon" aria-hidden="true">
                                            <img src="svg/password.svg" width="18" height="18" />
                                        </span>
                                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-input" TextMode="Password" />
                                    </div>
                                    <!-- Required -->
                                    <asp:RequiredFieldValidator ID="rfvNewPass" runat="server"
                                        ControlToValidate="txtNewPassword"
                                        ErrorMessage="Please enter a password."
                                        CssClass="validation-message"
                                        Display="Dynamic"
                                        ValidationGroup="ResetGroup" />
                                    <!-- Regex Strength from Register.aspx -->
                                    <asp:RegularExpressionValidator ID="revNewPassStrength" runat="server"
                                        ControlToValidate="txtNewPassword"
                                        ValidationExpression="^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).+$"
                                        ErrorMessage="Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 symbol."
                                        CssClass="validation-message"
                                        Display="Dynamic"
                                        ValidationGroup="ResetGroup" />
                                </div>
                                <!-- Confirm Password -->
                                <div class="field-group">
                                    <asp:Label ID="lblConfirmPass" runat="server" AssociatedControlID="txtConfirmPassword" CssClass="field-label" Text="Confirm New Password:" />
                                    <div class="input-wrap">
                                        <span class="input-icon" aria-hidden="true">
                                            <img src="svg/password.svg" width="18" height="18" />
                                        </span>
                                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input" TextMode="Password" />
                                    </div>
                                    <!-- Required -->
                                    <asp:RequiredFieldValidator ID="rfvConfirmPass" runat="server"
                                        ControlToValidate="txtConfirmPassword"
                                        ErrorMessage="Please confirm your password."
                                        CssClass="validation-message"
                                        Display="Dynamic"
                                        ValidationGroup="ResetGroup" />
                                    <!-- Compare from Register.aspx -->
                                    <asp:CompareValidator ID="cvPassMatch" runat="server"
                                        ControlToValidate="txtConfirmPassword"
                                        ControlToCompare="txtNewPassword"
                                        ErrorMessage="Passwords do not match."
                                        CssClass="validation-message"
                                        Display="Dynamic"
                                        ValidationGroup="ResetGroup" />
                                </div>
                                <asp:Button ID="btnSavePassword" runat="server" Text="Update Password  →"
                                    CssClass="submit-button" ValidationGroup="ResetGroup" OnClick="btnSavePassword_Click" />
                                <asp:Label ID="lblMessageStep3" runat="server" CssClass="error-message" EnableViewState="false" />
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </section>
            <aside class="visual-panel" aria-label="Illustration">
                <div class="visual-placeholder">
                    <img src="img/loginImage.jpg" alt="Login Graphic" />
                </div>
            </aside>
        </main>
    </form>
    <uc:Footer runat="server" />
</body>
</html>
