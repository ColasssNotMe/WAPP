<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyClasses.aspx.cs" Inherits="Assignment.MyClasses" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Classes</title>

    <link rel="stylesheet" href="index.css" />
    <style>
        body {
            background-color: var(--bg-light);
            color: var(--primary-color);
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .classes-container {
            width: var(--container-width, 85vw);
            margin: 0 auto;
            padding: 40px 0 60px 0;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .header-title-group {
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
            text-decoration: none;
        }

        .btn-create {
            background: var(--primary-color);
            color: var(--white);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            transition: all 0.2s ease;
            box-shadow: var(--shadow);
        }

        .btn-create:hover {
            background: #11172A;
            color: var(--white);
            text-decoration: none;
            transform: translateY(-1px);
        }

        .classes-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }

        @media (max-width: 1024px) {
            .classes-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .classes-grid {
                grid-template-columns: 1fr;
            }
        }

        .class-card {
            background: var(--white);
            border-radius: 16px;
            padding: 28px 24px 24px 24px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .class-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(28, 37, 65, 0.08);
        }

        .class-card-header {
            margin-bottom: 20px;
        }

        .class-name {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-color);
            margin: 0 0 4px 0;
        }

        .class-meta {
            font-size: 0.85rem;
            color: var(--secondary-color);
            margin: 0;
            font-weight: 500;
        }

        .class-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-bottom: 24px;
            padding: 16px 12px;
            background: var(--muted-surface);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            text-align: center;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .stat-item:not(:last-child)::after {
            content: '';
            position: absolute;
            right: 0;
            top: 15%;
            height: 70%;
            width: 1px;
            background-color: var(--border-color);
        }

        .stat-value {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary-color);
            line-height: 1.2;
        }

        .stat-label {
            font-size: 0.75rem;
            color: var(--secondary-color);
            font-weight: 600;
            margin-top: 2px;
        }

        .class-actions {
            display: flex;
            gap: 12px;
        }

        .btn-card-action {
            flex: 1;
            text-align: center;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-primary-action {
            background: var(--primary-color);
            color: var(--white);
        }

        .btn-primary-action:hover {
            background: #11172A;
            color: var(--white);
            text-decoration: none;
        }

        .btn-secondary-action {
            background: var(--bg-surface);
            color: var(--primary-color);
            border: 1px solid var(--border-color);
        }

        .btn-secondary-action:hover {
            background: #E6DED2;
            text-decoration: none;
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 24px;
            background: var(--white);
            border-radius: 16px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <div class="classes-container">

            <header class="header-section">
                <div class="header-title-group">
                    <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <h1 class="page-title">My Classes</h1>
                </div>

                <a href="EditClassroom.aspx" class="btn-create">Create Classroom</a>
            </header>

            <main>
                <div class="classes-grid">
                    <asp:Repeater ID="rptClassrooms" runat="server">
                        <ItemTemplate>
                            <div class="class-card">
                                <div>
                                    <div class="class-card-header">
                                        <h2 class="class-name"><%# Eval("className") %></h2>
                                        <p class="class-meta"><%# !string.IsNullOrEmpty(Eval("subject").ToString()) ? Eval("subject") : "Sejarah" %></p>
                                    </div>

                                    <div class="class-stats">
                                        <div class="stat-item">
                                            <span class="stat-value"><%# Eval("StudentCount") %></span>
                                            <span class="stat-label">Students</span>
                                        </div>
                                        <div class="stat-item">
                                            <span class="stat-value"><%# Eval("NoteCount") %></span>
                                            <span class="stat-label">Notes</span>
                                        </div>
                                        <div class="stat-item">
                                            <span class="stat-value"><%# Eval("QuizCount") %></span>
                                            <span class="stat-label">Quizzes</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="class-actions">
                                    <a href='<%# "ManageStudents.aspx?classID=" + Eval("classID") %>' class="btn-card-action btn-primary-action">Manage Students</a>
                                    <a href='<%# "EditClassroom.aspx?classID=" + Eval("classID") %>' class="btn-card-action btn-secondary-action">Edit</a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoClasses" runat="server" Visible="false" CssClass="empty-state">
                        <h3 style="font-size: 1.5rem; font-weight: 800; color: var(--primary-color); margin: 0 0 8px 0;">No Classrooms Found</h3>
                        <p style="font-size: 0.85rem; color: var(--secondary-color); margin: 0 0 20px 0;">There are no active classrooms in the system yet.</p>
                        <a href="EditClassroom.aspx" class="btn-create">Create First Classroom</a>
                    </asp:Panel>
                </div>
            </main>

        </div>

        <uc:Footer runat="server" />
    </form>
</body>
</html>