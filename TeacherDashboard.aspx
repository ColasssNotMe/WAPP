<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherDashboard.aspx.cs" Inherits="Assignment.TeacherDashboard" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Teacher Dashboard</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <script src="https://unpkg.com/lucide@latest"></script>

    <link href="index.css" rel="stylesheet" />
    <link rel="stylesheet" href="TeacherDashboard.css">
    <style>
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
        .quick-action-btn:last-child {
            margin-bottom: 0;
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
        .item-link-row {
            text-decoration: none;
            color: inherit;
            display: block;
            transition: background-color 0.2s ease, transform 0.1s ease;
            border-radius: 8px;
            padding: 4px 8px;
            margin: -4px -8px;
        }
        .item-link-row:hover {
            background-color: #f8fafc;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <uc:Header ID="HeaderControl" runat="server" />

        <div class="dashboard-container">

            <header class="dashboard-header">

                <div class="header-title-group">

                    <h1>Teacher Dashboard</h1>

                    <p>
                        Welcome back,
                        <span>
                            <asp:Label
                                ID="lblTeacherName"
                                runat="server"
                                Text="Teacher">
                            </asp:Label>
                        </span>.
                        Here's what's happening in your classrooms today.
                    </p>

                </div>

                <div class="active-classrooms-badge">

                    <span class="status-dot"></span>

                    <span>
                        <asp:Label
                            ID="lblActiveClassrooms"
                            runat="server"
                            Text="0">
                        </asp:Label>
                        active classrooms
                    </span>

                </div>

            </header>

            <section class="metrics-grid">

                <a href="ManageStudents.aspx"
                   style="text-decoration: none; color: inherit; display: block;">

                    <div class="metric-card">

                        <div class="metric-card-header">

                            <span class="metric-label">
                                Students
                            </span>

                            <div class="metric-icon-box">
                                <i data-lucide="users"
                                   style="width: 18px; height: 18px;"></i>
                            </div>

                        </div>

                        <div class="metric-value">

                            <asp:Label
                                ID="lblStudentCount"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </div>

                        <div class="metric-subtitle">
                            Across all classes
                        </div>

                    </div>

                </a>

                <a href="ManageQuiz.aspx"
                   style="text-decoration: none; color: inherit; display: block;">

                    <div class="metric-card red-card">

                        <div class="metric-card-header">

                            <span class="metric-label">
                                Quizzes
                            </span>

                            <div class="metric-icon-box">
                                <i data-lucide="help-circle"
                                   style="width: 18px; height: 18px;"></i>
                            </div>

                        </div>

                        <div class="metric-value">

                            <asp:Label
                                ID="lblQuizCount"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </div>

                        <div class="metric-subtitle">
                            Across all classes
                        </div>

                    </div>

                </a>

                <a href="ManageNotes.aspx"
                   style="text-decoration: none; color: inherit; display: block;">

                    <div class="metric-card green-card">

                        <div class="metric-card-header">

                            <span class="metric-label">
                                Notes
                            </span>

                            <div class="metric-icon-box">
                                <i data-lucide="file-text"
                                   style="width: 18px; height: 18px;"></i>
                            </div>

                        </div>

                        <div class="metric-value">

                            <asp:Label
                                ID="lblNoteCount"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </div>

                        <div class="metric-subtitle">
                            Added this month
                        </div>

                    </div>

                </a>

            </section>

            <div class="main-content-grid">

                <div class="left-column">

                    <div class="dashboard-section-card">

                        <div class="section-header">

                            <h2 class="section-title">
                                Material
                            </h2>

                            <span class="section-tag">
                                Recent
                            </span>

                        </div>

                        <div class="activity-list">

                            <asp:Repeater
                                ID="rptMaterials"
                                runat="server">

                                <ItemTemplate>

                                    <a href="ManageNotes.aspx" class="item-link-row">
                                        <div class="activity-item">

                                            <div class="activity-icon-wrapper">

                                                <i data-lucide="book-open"
                                                   style="width: 18px; height: 18px;">
                                                </i>

                                            </div>

                                            <div class="activity-details">

                                                <div class="activity-title">

                                                    <%# Eval("title") %>

                                                </div>

                                                <div class="activity-meta">

                                                    <span>
                                                        <%# Eval("className") %>
                                                    </span>

                                                    <span class="meta-divider">
                                                        •
                                                    </span>

                                                    <span>
                                                        <%# Eval("uploadDate", "{0:hh:mm tt}") %>
                                                    </span>

                                                </div>

                                            </div>

                                        </div>
                                    </a>

                                </ItemTemplate>

                            </asp:Repeater>

                            <asp:Panel
                                ID="pnlNoMaterials"
                                runat="server"
                                Visible="false">

                                <div class="activity-item">

                                    <div class="activity-details">

                                        <div class="activity-title">
                                            No recent materials
                                        </div>

                                        <div class="activity-meta">
                                            No materials have been added yet.
                                        </div>

                                    </div>

                                </div>

                            </asp:Panel>

                        </div>

                    </div>

                    <div class="dashboard-section-card">

                        <div class="section-header">

                            <h2 class="section-title">
                                Quiz
                            </h2>

                            <span class="section-tag">
                                Recent
                            </span>

                        </div>

                        <div class="activity-list">

                            <asp:Repeater
                                ID="rptQuizzes"
                                runat="server">

                                <ItemTemplate>

                                    <a href='<%# Eval("quizID") != DBNull.Value ? "EditQuiz.aspx?quizID=" + Eval("quizID") : "ManageQuiz.aspx" %>' class="item-link-row">
                                        <div class="activity-item">

                                            <div class="activity-icon-wrapper">

                                                <i data-lucide="clipboard-check"
                                                   style="width: 18px; height: 18px;">
                                                </i>

                                            </div>

                                            <div class="activity-details">

                                                <div class="activity-title">

                                                    <%# Eval("title") %>

                                                </div>

                                                <div class="activity-meta">

                                                    <span>
                                                        <%# Eval("className") %>
                                                    </span>

                                                    <span class="meta-divider">
                                                        •
                                                    </span>

                                                    <span>
                                                        <%# Eval("createdDate", "{0:hh:mm tt}") %>
                                                    </span>

                                                </div>

                                            </div>

                                        </div>
                                    </a>

                                </ItemTemplate>

                            </asp:Repeater>

                            <asp:Panel
                                ID="pnlNoQuizzes"
                                runat="server"
                                Visible="false">

                                <div class="activity-item">

                                    <div class="activity-details">

                                        <div class="activity-title">
                                            No recent quizzes
                                        </div>

                                        <div class="activity-meta">
                                            No quizzes have been created yet.
                                        </div>

                                    </div>

                                </div>

                            </asp:Panel>

                        </div>

                    </div>

                </div>

                <div class="right-column">

                    <!-- Quick Actions Card -->
                    <div class="dashboard-section-card" style="margin-bottom: 24px;">

                        <div class="section-header" style="border-bottom: none; padding-bottom: 0; margin-bottom: 16px;">

                            <h2 class="section-title">
                                Quick Actions
                            </h2>

                        </div>

                        <div class="quick-actions-body">

                            <a href="ManageStudents.aspx" class="quick-action-btn quick-action-primary">
                                Manage students
                            </a>

                            <a href="ManageNotes.aspx" class="quick-action-btn quick-action-secondary">
                                Manage topics
                            </a>

                            <a href="ManageQuiz.aspx" class="quick-action-btn quick-action-secondary">
                                Manage quizzes
                            </a>

                        </div>

                    </div>

                    <!-- Classroom Summary Card -->
                    <div class="dashboard-section-card sticky-card">

                        <div class="section-header"
                             style="border-bottom: none; padding-bottom: 0; margin-bottom: 12px;">

                            <h2 class="section-title">
                                Classroom Summary
                            </h2>

                        </div>

                        <div class="summary-list">

                            <asp:Repeater
                                ID="rptClassrooms"
                                runat="server">

                                <ItemTemplate>

                                    <a href='<%# "ClassroomDetails.aspx?classID=" + Eval("classID") %>' class="item-link-row">
                                        <div class="summary-row">

                                            <span class="class-name">
                                                <%# Eval("className") %>
                                            </span>

                                            <span class="student-count">

                                                <%# Eval("studentCount") %>

                                                <span class="student-label">
                                                    students
                                                </span>

                                            </span>

                                        </div>
                                    </a>

                                </ItemTemplate>

                            </asp:Repeater>

                            <asp:Panel
                                ID="pnlNoClassrooms"
                                runat="server"
                                Visible="false">

                                <div class="summary-row">

                                    <span class="class-name">
                                        No classrooms
                                    </span>

                                    <span class="student-count">
                                        0
                                        <span class="student-label">
                                            students
                                        </span>
                                    </span>

                                </div>

                            </asp:Panel>

                        </div>

                    </div>

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