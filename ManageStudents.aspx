<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="Assignment.ManageStudents" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student List</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <script src="https://unpkg.com/lucide@latest"></script>

    <link href="index.css" rel="stylesheet" />
    <link rel="stylesheet" href="TeacherDashboard.css">
    <style>
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .modal-card {
            background: #ffffff;
            padding: 32px;
            border-radius: 20px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        .modal-title {
            font-size: 20px;
            font-weight: 800;
            color: #1a2536;
            margin: 0 0 8px 0;
        }
        .modal-subtitle {
            font-size: 14px;
            color: #64748b;
            margin: 0 0 20px 0;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
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
        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
        }
        .btn-cancel-modal {
            background-color: #ffffff;
            color: #1a2536;
            border: 1px solid #cbd5e1;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
        }
        .btn-save-modal {
            background-color: #1a2536;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <uc:Header ID="HeaderControl" runat="server" />

        <div class="dashboard-container">

            <header class="dashboard-header" style="display:flex; justify-content:space-between; align-items:flex-start;">

                <div style="display:flex; align-items:center; gap:16px;">
                    <a href="TeacherDashboard.aspx" style="color:#1a2536; text-decoration:none; display:flex; align-items:center;">
                        <i data-lucide="arrow-left" style="width:24px; height:24px;"></i>
                    </a>
                    <div class="header-title-group">
                        <h1>Student List</h1>
                        <p>Assign Student to their Classes.</p>
                    </div>
                </div>

                <div class="active-classrooms-badge">
                    <span>
                        <asp:Label ID="lblStudentCount" runat="server" Text="0"></asp:Label>
                        students
                    </span>
                </div>

            </header>

            <main class="dashboard-section-card" style="padding: 24px; background:#fff; border-radius:20px; box-shadow:0 4px 20px rgba(0,0,0,0.03);">

                <div class="activity-list">

                    <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">

                        <ItemTemplate>

                            <div class="activity-item" style="display:flex; align-items:center; justify-content:space-between; padding: 16px 0; border-bottom: 1px solid #f1f5f9;">

                                <div style="display:flex; align-items:center; gap:16px;">

                                    <div class="activity-icon-wrapper" style="width:40px; height:40px; background:#f1f5f9; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:700; color:#1a2536;">
                                        <%# Eval("StudentName").ToString().Substring(0, 1).ToLower() %>
                                    </div>

                                    <div class="activity-details">

                                        <div class="activity-title" style="font-size:16px; font-weight:700; color:#1a2536; margin:0 0 4px 0;">
                                            <%# Eval("StudentName") %>
                                        </div>

                                        <div class="activity-meta" style="font-size:13px; color:#64748b;">
                                            <span><%# Eval("username") %></span>
                                            <span class="meta-divider">•</span>
                                            <span><%# Eval("AssignedClass") %></span>
                                        </div>

                                    </div>

                                </div>

                                <div>
                                    <asp:Button ID="btnOpenAssign" runat="server" Text="Assign Class" CommandName="OpenAssign" CommandArgument='<%# Eval("studentID") + "|" + Eval("StudentName") %>' style="background:#f1f5f9; color:#1a2536; border:1px solid #e2e8f0; padding:8px 16px; border-radius:10px; font-weight:700; font-size:13px; cursor:pointer;" />
                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>

                </div>

            </main>

        </div>

        <!-- Assign Classroom Modal -->
        <div id="assignModal" class="modal-overlay" runat="server" style="display: none;">
            <div class="modal-card">
                <h2 class="modal-title">Assign Classroom</h2>
                <p class="modal-subtitle">
                    Select a new classroom for 
                    <strong><asp:Label ID="lblModalStudentName" runat="server" /></strong>:
                </p>

                <asp:HiddenField ID="hfSelectedStudentID" runat="server" />

                <div class="form-group" style="margin: 20px 0;">
                    <label for="ddlClassrooms">Classroom</label>
                    <asp:DropDownList ID="ddlClassrooms" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <div class="modal-actions">
                    <asp:Button ID="btnCancelAssign" runat="server" Text="Cancel" CssClass="btn-cancel-modal" OnClick="btnCancelAssign_Click" CausesValidation="false" />
                    <asp:Button ID="btnSaveAssign" runat="server" Text="Save" CssClass="btn-save-modal" OnClick="btnSaveAssign_Click" />
                </div>
            </div>
        </div>

        <script>
lucide.createIcons();
</script>

        <uc:Footer ID="FooterControl" runat="server" />

    </form>

</body>
</html>