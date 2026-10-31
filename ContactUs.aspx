<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Assignment.ContactUs" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Contact Us</title>
    <link rel="stylesheet" href="ContactUs.css">
    <link rel="stylesheet" href="index.css">
</head>
<body>
<form id="form1" runat="server">

    <uc:Header ID="HeaderControl" runat="server" />

    <div class="container">

        <div class="page-header">
            <div>
                <h1>Contact Us</h1>
                <p>Get in touch with our support team. We're here to help.</p>
            </div>
        </div>

        <div class="card">
            
            <div class="contact-grid">
                
                <!-- Email -->
                <div class="contact-item">
                    <div class="contact-icon">📧</div>
                    <div class="contact-text">
                        <label>Email</label>
                        <span>support@ncient.com</span>
                    </div>
                </div>

                <!-- Phone -->
                <div class="contact-item">
                    <div class="contact-icon">📞</div>
                    <div class="contact-text">
                        <label>Phone</label>
                        <span>+60 12-345 6789</span>
                    </div>
                </div>

                <!-- Support Hours -->
                <div class="contact-item">
                    <div class="contact-icon">🕒</div>
                    <div class="contact-text">
                        <label>Support Hours</label>
                        <span>Mon - Fri, 9:00 AM - 5:00 PM</span>
                    </div>
                </div>

                <!-- Response Time -->
                <div class="contact-item">
                    <div class="contact-icon">⚡</div>
                    <div class="contact-text">
                        <label>Response Time</label>
                        <span>Within 24 hours</span>
                    </div>
                </div>

                <!-- Address -->
                <div class="contact-item full-width">
                    <div class="contact-icon">📍</div>
                    <div class="contact-text">
                        <label>Office Address</label>
                        <span>123 Education Lane, Technology Park, 57000 Kuala Lumpur, Malaysia</span>
                    </div>
                </div>

            </div>

            <div class="contact-footer">
                We look forward to hearing from you!
            </div>

        </div>
    </div>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>