<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherDashboard.aspx.cs" Inherits="Assignment.TeacherDashboard" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Teacher Dashboard</title>

    <!-- Google Fonts & Lucide Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <script src="https://unpkg.com/lucide@latest"></script>

    <!-- Stylesheets -->
    <link href="index.css" rel="stylesheet" />
    <link rel="stylesheet" href="TeacherDashboard.css">
</head>

<body>

    <form id="form1" runat="server">

        <uc:Header ID="HeaderControl" runat="server" />

        <div class="dashboard-container">

            <!-- Header Section -->
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


            <!-- Metric Cards Grid -->
            <section class="metrics-grid">

                <!-- Card 1: Students -->
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


                <!-- Card 2: Live Sessions -->
                <div class="metric-card gold-card">

                    <div class="metric-card-header">

                        <span class="metric-label">
                            Live sessions
                        </span>

                        <div class="metric-icon-box">
                            <i data-lucide="video"
                               style="width: 18px; height: 18px;"></i>
                        </div>

                    </div>

                    <div class="metric-value">

                        <asp:Label
                            ID="lblLiveSessionCount"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </div>

                    <div class="metric-subtitle">

                        <span class="metric-subtitle-dot"></span>
                        Scheduled this week

                    </div>

                </div>


                <!-- Card 3: Quizzes -->
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


                <!-- Card 4: Notes -->
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


            <!-- Main Content Grid -->
            <div class="main-content-grid">

                <!-- Left Column -->
                <div class="left-column">


                    <!-- Material Section -->
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


                    <!-- Quiz Section -->
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


                <!-- Right Column -->
                <div class="right-column">

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