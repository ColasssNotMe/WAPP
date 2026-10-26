<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="Assignment.ManageStudents" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="ManageQuiz.css">
    <style>
        .student-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            transition: background-color 0.2s ease;
        }
        .student-row:last-child {
            border-bottom: none;
        }
        .student-row:hover {
            background-color: #f8fafc;
        }
        .student-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .avatar-circle {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background-color: #f1f5f9;
            color: #1a2536;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 16px;
        }
        .student-info h3 {
            font-size: 15px;
            font-weight: 700;
            color: #1a2536;
            margin: 0 0 2px 0;
        }
        .student-meta {
            font-size: 13px;
            color: #64748b;
            margin: 0;
        }
        .student-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .progress-val {
            font-weight: 700;
            font-size: 14px;
            color: #334155;
            min-width: 40px;
            text-align: right;
        }
        /* Action Modal */
        .modal-backdrop {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.4);
            display: flex; align-items: center; justify-content: center;
            z-index: 1000;
        }
        .modal-card {
            background: #fff;
            padding: 28px;
            border-radius: 20px;
            width: 420px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="quizzes-container">
            
            <!-- Header Section -->
            <header class="page-header">
                <div class="header-left">
                    <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <div class="title-group">
                        <h1 class="page-title">Student List</h1>
                        <p class="page-subtitle">Track student progress, attendance, and classroom participation.</p>
                    </div>
                </div>
                <div class="header-right">
                    <span class="status-badge published" style="font-size:14px; padding: 8px 16px;">
                        <asp:Label ID="lblTotalStudents" runat="server" Text="0 students" />
                    </span>
                </div>
            </header>

            <!-- Main Content Card -->
            <main class="card" style="padding: 12px 24px;">
                <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
                    <ItemTemplate>
                        <div class="student-row">
                            <div class="student-left">
                                <div class="avatar-circle">
                                    <%# Eval("Initial") %>
                                </div>
                                <div class="student-info">
                                    <h3><%# Eval("FullName") %></h3>
                                    <p class="student-meta"><%# Eval("username") %> • <%# Eval("className") %></p>
                                </div>
                            </div>
                            <div class="student-right">
                                <span class="status-badge <%# Eval("status").ToString().ToLower() == "active" ? "published" : "draft" %>">
                                    <%# Eval("status") %>
                                </span>
                                <span class="progress-val"><%# Eval("AvgProgress") %>%</span>
                                <asp:Button ID="btnAssign" runat="server" Text="Assign Class" 
                                    CssClass="btn btn-secondary" style="padding: 6px 12px; font-size:12px;" 
                                    CommandName="OpenAssign" CommandArgument='<%# Eval("studentID") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </main>

            <!-- Assign Class Modal Panel -->
            <asp:Panel ID="pnlModal" runat="server" Visible="false" CssClass="modal-backdrop">
                <div class="modal-card">
                    <h2 class="card-title" style="margin-bottom:12px;">Assign Classroom</h2>
                    <p class="page-subtitle" style="margin-bottom:20px;">Select a new classroom for <asp:Label ID="lblModalStudentName" runat="server" Font-Bold="true" />:</p>
                    
                    <div class="form-group" style="margin-bottom:20px;">
                        <label for="ddlClassrooms">Classroom</label>
                        <asp:DropDownList ID="ddlClassrooms" runat="server" CssClass="form-control" style="width:100%; padding:10px; border-radius:10px;" />
                    </div>

                    <div style="display:flex; gap:10px; justify-content:flex-end;">
                        <asp:Button ID="btnSaveAssignment" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveAssignment_Click" />
                        <asp:Button ID="btnCancelModal" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancelModal_Click" />
                    </div>
                </div>
            </asp:Panel>

        </div>
    </form>
</body>
</html>