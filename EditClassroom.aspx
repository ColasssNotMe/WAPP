<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditClassroom.aspx.cs" Inherits="Assignment.EditClassroom" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Classroom</title>

    <link rel="stylesheet" href="index.css" />
    <style>
        body {
            background-color: var(--bg-light);
            color: var(--primary-color);
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .edit-container {
            width: var(--container-width, 85vw);
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 0 60px 0;
        }

        .header-section {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary-color);
            margin: 0;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            border-radius: 8px;
            background: var(--white);
            border: 1px solid var(--border-color);
            color: var(--primary-color);
            text-decoration: none;
            box-shadow: var(--shadow);
            transition: all 0.2s ease;
        }

        .back-btn:hover {
            background: var(--bg-surface);
            transform: translateX(-2px);
        }

        .edit-card {
            background: var(--white);
            border-radius: 16px;
            padding: 32px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 24px;
        }

        .form-group label {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: inherit;
            font-size: 0.85rem;
            background: var(--white);
            color: var(--primary-color);
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            align-items: center;
        }

        .btn-submit {
            background: var(--primary-color);
            color: var(--white);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.95rem;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-submit:hover {
            background: #11172A;
        }

        .btn-cancel {
            background: var(--bg-surface);
            color: var(--primary-color);
            border: 1px solid var(--border-color);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.95rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s ease;
        }

        .btn-cancel:hover {
            background: #E6DED2;
            text-decoration: none;
        }

        .btn-delete {
            background: var(--accent-color, #880000);
            color: var(--white);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.95rem;
            border: none;
            cursor: pointer;
            margin-left: auto;
            transition: all 0.2s ease;
        }

        .btn-delete:hover {
            background: #660000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <div class="edit-container">
            <header class="header-section">
                <a href="MyClasses.aspx" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <h1 class="page-title"><asp:Label ID="lblPageTitle" runat="server" Text="Edit Classroom"></asp:Label></h1>
            </header>

            <main class="edit-card">
                <h2 style="font-size: 1.5rem; font-weight: 800; color: var(--primary-color); margin-bottom: 24px;">Classroom Details</h2>

                <div class="form-group">
                    <label for="txtClassName">Classroom name</label>
                    <asp:TextBox ID="txtClassName" runat="server" CssClass="form-control" placeholder="Enter classroom name"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtSubject">Subject</label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="e.g. Sejarah"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtDescription">Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Enter classroom description"></asp:TextBox>
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save changes" CssClass="btn-submit" OnClick="btnSaveChanges_Click" />
                    <a href="MyClasses.aspx" class="btn-cancel">Cancel</a>

                    <asp:Button ID="btnDelete" runat="server" Text="Delete classroom" CssClass="btn-delete"
                        OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this classroom? All associated enrollments and materials will be removed.');" CausesValidation="false" />
                </div>
            </main>
        </div>

        <uc:Footer runat="server" />
    </form>
</body>
</html>