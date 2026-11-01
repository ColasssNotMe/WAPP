<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditNotes.aspx.cs" Inherits="Assignment.EditNotes" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Note</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link href="index.css" rel="stylesheet" />
    <link rel="stylesheet" href="CreateQuiz.css" />
    <style>
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 20px;
        }
        .form-group label {
            font-size: 14px;
            font-weight: 700;
            color: #1a2536;
        }
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-family: inherit;
            font-size: 14px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <div class="quizzes-container" style="max-width: 800px; margin: 0 auto; padding: 40px 24px;">
            <header class="page-header" style="margin-bottom: 32px;">
                <div class="header-left" style="display: flex; align-items: center; gap: 16px;">
                    <a href="ManageNotes.aspx" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <div class="title-group">
                        <h1 class="page-title" style="margin: 0; font-size: 28px; font-weight: 800; color: #1a2536;">Edit Note</h1>
                        <p class="page-subtitle" style="margin: 4px 0 0 0; color: #64748b; font-size: 14px;">Update material details and status settings.</p>
                    </div>
                </div>
            </header>

            <main class="card" style="padding: 32px; background: #fff; border-radius: 20px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                <h2 style="font-size: 20px; font-weight: 800; color: #1a2536; margin: 0 0 24px 0;">Note Settings</h2>

                <!-- Note Title -->
                <div class="form-group">
                    <label for="txtTitle">Note Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter note title"></asp:TextBox>
                </div>

                <!-- Chapter Field (Linked to Database) -->
                <div class="form-group">
                    <label for="txtChapter">Chapter</label>
                    <asp:TextBox ID="txtChapter" runat="server" CssClass="form-control" placeholder="Only Number e.g. : 1 , 2 "></asp:TextBox>
                </div>

                <!-- Classroom -->
                <div class="form-group">
                    <label for="ddlClassroom">Classroom</label>
                    <asp:DropDownList ID="ddlClassroom" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <!-- File Upload -->
                <div class="form-group">
                    <label for="fileUploadPdf">Upload PDF Note (Leave empty to keep existing)</label>
                    <asp:FileUpload ID="fileUploadPdf" runat="server" CssClass="form-control" />
                    <p style="margin: 6px 0 0 0; font-size: 13px; color: #64748b;">
                        Current File: <asp:Label ID="lblCurrentFile" runat="server" Text="None" Font-Bold="true"></asp:Label>
                    </p>
                </div>

                <!-- Status -->
                <div class="form-group">
                    <label for="ddlStatus">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Published" Text="Published"></asp:ListItem>
                        <asp:ListItem Value="Draft" Text="Draft"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Actions -->
                <div style="display: flex; gap: 12px; margin-top: 32px;">
                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save changes" CssClass="btn btn-primary" OnClick="btnSaveChanges_Click" style="padding: 12px 24px; background: #1a2536; color: #fff; border: none; border-radius: 10px; font-weight: 700; cursor: pointer;" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" style="padding: 12px 24px; background: #fff; color: #1a2536; border: 1px solid #cbd5e1; border-radius: 10px; font-weight: 700; cursor: pointer;" />
                </div>
            </main>
        </div>

        <uc:Footer runat="server" />
    </form>
</body>
</html>