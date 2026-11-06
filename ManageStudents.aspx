<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="Assignment.ManageStudents" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>

    <link rel="stylesheet" href="index.css" />
    <style>
        .students-container {
            width: var(--container-width, 85vw);
            margin: 0 auto;
            padding: 40px 0 60px 0;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary-color);
            margin: 0;
        }

        .page-subtitle {
            margin: 4px 0 0 0;
            color: var(--secondary-color);
            font-size: 0.85rem;
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
        }

        .count-badge {
            background: var(--white);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--primary-color);
            border: 1px solid var(--border-color);
        }

        .students-card {
            background: var(--white);
            border-radius: 16px;
            padding: 16px 24px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
        }

        .student-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .student-row:last-child {
            border-bottom: none;
        }

        .student-identity {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .avatar-circle {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--muted-surface);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 1rem;
            text-transform: uppercase;
        }

        .student-name {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--primary-color);
            margin: 0;
        }

        .student-meta {
            font-size: 0.85rem;
            color: var(--secondary-color);
            margin: 2px 0 0 0;
        }

        .action-group {
            display: flex;
            gap: 8px;
        }

        .btn-action {
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: all 0.2s ease;
        }

        .btn-assign {
            background: var(--bg-surface);
            color: var(--primary-color);
            border: 1px solid var(--border-color);
        }

        .btn-assign:hover {
            background: #E6DED2;
        }

        .btn-results {
            background: var(--primary-color);
            color: var(--white);
        }

        .btn-results:hover {
            background: #11172A;
        }

        /* Modal Popup Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(28, 37, 65, 0.4);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        .modal-card {
            background: var(--white);
            border-radius: 16px;
            padding: 32px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 12px 32px rgba(0,0,0,0.15);
            border: 1px solid var(--border-color);
            max-height: 85vh;
            overflow-y: auto;
        }

        .results-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
        }

        .results-table th, .results-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.85rem;
        }

        .results-table th {
            font-weight: 800;
            color: var(--primary-color);
            background: var(--muted-surface);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <div class="students-container">
            <header class="page-header">
                <div class="header-left">
               <a href="TeacherDashboard.aspx" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <div>
                        <h1 class="page-title">Student List</h1>
                        <p class="page-subtitle">Assign Student to their Classes and view quiz results.</p>
                    </div>
                </div>

                <div class="count-badge">
                    <asp:Label ID="lblStudentCount" runat="server" Text="0"></asp:Label> students
                </div>
            </header>

            <main class="students-card">
                <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
                    <ItemTemplate>
                        <div class="student-row">
                            <div class="student-identity">
                                <div class="avatar-circle">
                                    <%# Eval("StudentName").ToString().Substring(0, 1) %>
                                </div>
                                <div>
                                    <h3 class="student-name"><%# Eval("StudentName") %></h3>
                                    <p class="student-meta"><%# Eval("username") %> • <%# Eval("AssignedClass") %></p>
                                </div>
                            </div>

                            <div class="action-group">
                                <asp:Button ID="btnViewResults" runat="server" Text="View Results" CssClass="btn-action btn-results"
                                    CommandName="ViewResults" CommandArgument='<%# Eval("studentID") + "|" + Eval("StudentName") %>' />

                                <asp:Button ID="btnOpenAssign" runat="server" Text="Assign Class" CssClass="btn-action btn-assign"
                                    CommandName="OpenAssign" CommandArgument='<%# Eval("studentID") + "|" + Eval("StudentName") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </main>
        </div>

        <!-- Hidden inputs for dialog tracking -->
        <asp:HiddenField ID="hfSelectedStudentID" runat="server" />

        <!-- Assign Class Modal -->
        <div id="assignModal" runat="server" class="modal-overlay">
            <div class="modal-card" style="max-width: 400px;">
                <h3 style="font-size: 1.25rem; font-weight: 800; margin-bottom: 8px;">Assign Class</h3>
                <p style="margin-bottom: 20px;">Selecting class for <asp:Label ID="lblModalStudentName" runat="server" Font-Bold="true"></asp:Label></p>

                <div style="margin-bottom: 24px;">
                    <label style="font-size: 0.85rem; font-weight: 700; display: block; margin-bottom: 8px;">Classroom</label>
                    <asp:DropDownList ID="ddlClassrooms" runat="server" Style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid var(--border-color); font-family: inherit;">
                    </asp:DropDownList>
                </div>

                <div style="display: flex; gap: 12px; justify-content: flex-end;">
                    <asp:Button ID="btnCancelAssign" runat="server" Text="Cancel" CssClass="btn-action btn-assign" OnClick="btnCancelAssign_Click" CausesValidation="false" />
                    <asp:Button ID="btnSaveAssign" runat="server" Text="Save" CssClass="btn-action btn-results" OnClick="btnSaveAssign_Click" />
                </div>
            </div>
        </div>

        <!-- Student Quiz Results Modal -->
        <div id="resultsModal" runat="server" class="modal-overlay">
            <div class="modal-card">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                    <div>
                        <h3 style="font-size: 1.25rem; font-weight: 800; margin: 0;">Quiz Results</h3>
                        <p style="margin: 4px 0 0 0;">Performance history for <asp:Label ID="lblResultStudentName" runat="server" Font-Bold="true"></asp:Label></p>
                    </div>
                    <asp:Button ID="btnCloseResults" runat="server" Text="Close" CssClass="btn-action btn-assign" OnClick="btnCloseResults_Click" CausesValidation="false" />
                </div>

                <asp:Repeater ID="rptStudentResults" runat="server">
                    <HeaderTemplate>
                        <table class="results-table">
                            <thead>
                                <tr>
                                    <th>Quiz Title</th>
                                    <th>Classroom</th>
                                    <th>Score</th>
                                    <th>Time Taken (mins)</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="font-weight: 700; color: var(--primary-color);"><%# Eval("QuizTitle") %></td>
                            <td><%# Eval("className") %></td>
                            <td style="font-weight: 800; color: var(--success-color);"><%# Eval("score") %> / <%# Eval("totalMarks") %></td>
                            <td><%# Eval("timeTaken") != DBNull.Value ? Eval("timeTaken") : "-" %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoResults" runat="server" Visible="false" Style="text-align: center; padding: 24px 0; color: var(--secondary-color);">
                    This student has not attempted any quizzes yet.
                </asp:Panel>
            </div>
        </div>

        <uc:Footer runat="server" />
    </form>
</body>
</html>