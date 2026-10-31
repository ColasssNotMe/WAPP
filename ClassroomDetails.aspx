<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClassroomDetails.aspx.cs" Inherits="Assignment.ClassroomDetails" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classroom Details</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="MyClasses.css">
    <style>
        .details-container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 24px;
        }
        .header-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 32px;
        }
        .header-title-group {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .details-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }
        .info-label {
            color: #64748b;
        }
        .info-val {
            font-weight: 700;
            color: #1a2536;
        }
        .action-buttons-group {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        .quick-action-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            margin-bottom: 12px;
            box-sizing: border-box;
            transition: opacity 0.2s;
        }
        .quick-action-primary {
            background-color: #1a2536;
            color: #fff;
        }
        .quick-action-secondary {
            background-color: #ffffff;
            color: #1a2536;
            border: 1px solid #e2e8f0;
        }
        .quick-action-btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
     <form id="form1" runat="server">
        <uc:Header ID="HeaderControl" runat="server" />
             <link href="index.css" rel="stylesheet" />
        <div class="details-container">

            <!-- Fixed Header Section -->
            <header class="header-top">
                <div class="header-title-group">
                    <a href="MyClasses.aspx" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <h1 class="page-title" style="margin:0;">Classroom Details</h1>
                </div>
                <span class="status-badge published" style="font-size:14px; padding: 8px 16px; background:#f1f5f9; color:#1a2536; border-radius:20px; font-weight:700; white-space:nowrap;">
                    <asp:Label ID="lblStudentCount" runat="server" Text="0 students" />
                </span>
            </header>

            <div class="details-grid">
                
                <!-- Main Details Card -->
                <article class="card" style="padding: 32px; background:#fff; border-radius:20px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                    <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:24px;">
                        <div style="display:flex; gap:16px; align-items:center;">
                            <div class="card-icon-box" style="width:48px; height:48px; background:#f1f5f9; border-radius:12px; display:flex; align-items:center; justify-content:center;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                                    <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                                </svg>
                            </div>
                            <div>
                                <h2 style="font-size:20px; font-weight:800; color:#1a2536; margin:0 0 4px 0;">
                                    <asp:Label ID="lblClassName" runat="server" />
                                </h2>
                                <p style="font-size:14px; color:#64748b; margin:0;">
                                    <asp:Label ID="lblClassSubtitle" runat="server" />
                                </p>
                            </div>
                        </div>
                        <span style="background:#e2e8f0; color:#475569; padding:4px 12px; border-radius:12px; font-size:12px; font-weight:700;">Active</span>
                    </div>

                    <div style="margin-bottom: 24px;">
                        <div class="info-row">
                            <span class="info-label">Teacher</span>
                            <span class="info-val"><asp:Label ID="lblTeacherName" runat="server" /></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Invite code</span>
                            <span class="info-val" style="letter-spacing:1px;"><asp:Label ID="lblInviteCode" runat="server" /></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Created</span>
                            <span class="info-val"><asp:Label ID="lblCreatedDate" runat="server" /></span>
                        </div>
                    </div>

                    <div style="background:#f8fafc; padding:16px 20px; border-radius:12px; color:#475569; font-size:14px; margin-bottom:24px; line-height:1.5;">
                        <asp:Label ID="lblDescription" runat="server" />
                    </div>

                    <!-- Realigned Action Buttons -->
                    <div class="action-buttons-group">
                        <asp:HyperLink ID="lnkEditClass" runat="server" CssClass="btn btn-card-primary" style="text-decoration:none; display:inline-flex; align-items:center; justify-content:center; flex:1; text-align:center;">Edit classroom</asp:HyperLink>
                        <button type="button" onclick="copyInviteCode()" class="btn btn-card-secondary" style="flex:1; cursor:pointer;">Copy invite code</button>
                    </div>
                </article>

                <!-- Quick Actions Sidebar -->
                <aside class="card" style="padding: 28px; background:#fff; border-radius:20px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); height:fit-content;">
                    <h3 style="font-size:18px; font-weight:800; color:#1a2536; margin:0 0 20px 0;">Quick Actions</h3>
                    
                    <a href="ManageStudents.aspx" class="quick-action-btn quick-action-primary">Manage students</a>
                    <a href="ManageNotes.aspx" class="quick-action-btn quick-action-secondary">Manage topics</a>
                    <a href="ManageQuiz.aspx" class="quick-action-btn quick-action-secondary">Manage quizzes</a>
                </aside>

            </div>

        </div>
    </form>

    <script>
        function copyInviteCode() {
            var codeElement = document.getElementById('<%= lblInviteCode.ClientID %>');
            if (codeElement) {
                var codeText = codeElement.innerText;
                navigator.clipboard.writeText(codeText);
                alert("Invite code copied: " + codeText);
            }
        }
    </script>
       <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>