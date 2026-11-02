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
    <link href="index.css" rel="stylesheet" />
    <link rel="stylesheet" href="TeacherDashboard.css" />
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        .interactive-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        .interactive-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.08) !important;
        }
        .interactive-row {
            transition: background-color 0.15s ease, padding-left 0.15s ease;
            cursor: pointer;
            border-radius: 8px;
            padding: 10px 12px !important;
            margin: 2px 0;
            text-decoration: none;
            color: inherit;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .interactive-row:hover {
            background-color: #f8fafc;
            padding-left: 16px !important;
        }
        .badge-link {
            text-decoration: none;
            transition: background-color 0.2s ease, transform 0.15s ease;
            cursor: pointer;
            display: inline-block;
        }
        .badge-link:hover {
            background-color: #cbd5e1 !important;
            transform: scale(1.03);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <main class="dashboard-page" style="max-width: 1200px; margin: 0 auto; padding: 40px 24px;">
            
            <header class="dashboard-header" style="margin-bottom: 32px; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h1 class="page-title" style="font-size: 32px; font-weight: 800; color: #1a2536; margin: 0;">Teacher Dashboard</h1>
                    <p class="page-subtitle" style="color: #64748b; font-size: 15px; margin: 6px 0 0 0;">
                        Welcome back, <strong><asp:Label ID="lblTeacherName" runat="server" Text="Teacher" /></strong>. Here's what's happening across all classrooms today.
                    </p>
                </div>
                <a href="ManageStudents.aspx" class="active-badge badge-link" style="background: #e2e8f0; padding: 8px 16px; border-radius: 20px; font-size: 14px; font-weight: 600; color: #1a2536;">
                    ● <asp:Label ID="lblActiveClassrooms" runat="server" Text="0" /> active classrooms
                </a>
            </header>

            <!-- Interactive Metrics Cards Grid -->
            <div class="metrics-grid" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 32px;">
                
                <a href="ManageStudents.aspx" class="card metric-card interactive-card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                    <div style="display: flex; justify-content: space-between; color: #64748b; font-weight: 600; font-size: 14px;">
                        <span>Students</span>
                        <i data-lucide="users"></i>
                    </div>
                    <div style="font-size: 36px; font-weight: 800; color: #1a2536; margin: 12px 0 4px 0;">
                        <asp:Label ID="lblStudentCount" runat="server" Text="0" />
                    </div>
                    <span style="color: #94a3b8; font-size: 13px;">Click to manage students →</span>
                </a>

                <a href="ManageQuiz.aspx" class="card metric-card interactive-card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                    <div style="display: flex; justify-content: space-between; color: #64748b; font-weight: 600; font-size: 14px;">
                        <span>Quizzes</span>
                        <i data-lucide="help-circle"></i>
                    </div>
                    <div style="font-size: 36px; font-weight: 800; color: #1a2536; margin: 12px 0 4px 0;">
                        <asp:Label ID="lblQuizCount" runat="server" Text="0" />
                    </div>
                    <span style="color: #94a3b8; font-size: 13px;">Click to view quizzes →</span>
                </a>

                <a href="ManageNotes.aspx" class="card metric-card interactive-card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                    <div style="display: flex; justify-content: space-between; color: #64748b; font-weight: 600; font-size: 14px;">
                        <span>Notes</span>
                        <i data-lucide="file-text"></i>
                    </div>
                    <div style="font-size: 36px; font-weight: 800; color: #1a2536; margin: 12px 0 4px 0;">
                        <asp:Label ID="lblNoteCount" runat="server" Text="0" />
                    </div>
                    <span style="color: #94a3b8; font-size: 13px;">Click to view materials →</span>
                </a>

            </div>

            <!-- Dashboard Main Content Grid -->
            <div class="dashboard-content-grid" style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px;">
                
                <!-- Left Column: Interactive Material & Quiz Lists -->
                <div class="left-column" style="display: flex; flex-direction: column; gap: 24px;">
                    
                    <!-- Material Section -->
                    <div class="card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                            <h2 style="font-size: 18px; font-weight: 800; color: #1a2536; margin: 0;">Material</h2>
                            <a href="ManageNotes.aspx" style="background: #f1f5f9; padding: 6px 12px; border-radius: 12px; font-size: 12px; font-weight: 700; color: #1a2536; text-decoration: none;">View All</a>
                        </div>

                        <asp:Repeater ID="rptRecentMaterials" runat="server">
                            <HeaderTemplate><div style="display: flex; flex-direction: column; gap: 4px;"></HeaderTemplate>
                            <ItemTemplate>
                                <a href='<%# "EditNotes.aspx?materialID=" + Eval("materialID") %>' class="interactive-row">
                                    <div>
                                        <h3 style="font-size: 15px; font-weight: 700; color: #1a2536; margin: 0;"><%# Eval("title") %></h3>
                                        <p style="font-size: 13px; color: #64748b; margin: 4px 0 0 0;"><%# Eval("className") %> <%# !string.IsNullOrEmpty(Eval("chapter").ToString()) ? "• " + Eval("chapter") : "" %></p>
                                    </div>
                                    <span style="font-size: 12px; font-weight: 600; color: #94a3b8;"><%# Convert.ToDateTime(Eval("uploadDate")).ToString("MMM dd") %></span>
                                </a>
                            </ItemTemplate>
                            <FooterTemplate></div></FooterTemplate>
                        </asp:Repeater>

                        <asp:Panel ID="pnlNoMaterials" runat="server" Visible="false" Style="padding: 20px 0; color: #64748b;">
                            <p style="margin: 0; font-weight: 700; color: #1a2536;">No recent materials</p>
                            <p style="margin: 4px 0 0 0; font-size: 13px;">No materials have been added yet.</p>
                        </asp:Panel>
                    </div>

                    <!-- Quiz Section -->
                    <div class="card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                            <h2 style="font-size: 18px; font-weight: 800; color: #1a2536; margin: 0;">Quiz</h2>
                            <a href="ManageQuiz.aspx" style="background: #f1f5f9; padding: 6px 12px; border-radius: 12px; font-size: 12px; font-weight: 700; color: #1a2536; text-decoration: none;">View All</a>
                        </div>

                        <asp:Repeater ID="rptRecentQuizzes" runat="server">
                            <HeaderTemplate><div style="display: flex; flex-direction: column; gap: 4px;"></HeaderTemplate>
                            <ItemTemplate>
                                <a href='<%# "ManageQuiz.aspx?quizID=" + Eval("quizID") %>' class="interactive-row">
                                    <div>
                                        <h3 style="font-size: 15px; font-weight: 700; color: #1a2536; margin: 0;"><%# Eval("title") %></h3>
                                        <p style="font-size: 13px; color: #64748b; margin: 4px 0 0 0;"><%# Eval("className") %> • <%# Eval("totalMarks") %> marks</p>
                                    </div>
                                    <span style="font-size: 12px; font-weight: 600; color: #94a3b8;"><%# Convert.ToDateTime(Eval("createdDate")).ToString("MMM dd") %></span>
                                </a>
                            </ItemTemplate>
                            <FooterTemplate></div></FooterTemplate>
                        </asp:Repeater>

                        <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false" Style="padding: 20px 0; color: #64748b;">
                            <p style="margin: 0; font-weight: 700; color: #1a2536;">No recent quizzes</p>
                            <p style="margin: 4px 0 0 0; font-size: 13px;">No quizzes have been created yet.</p>
                        </asp:Panel>
                    </div>
                </div>

                <!-- Right Column: Quick Actions & Classroom Summary -->
                <div class="right-column" style="display: flex; flex-direction: column; gap: 24px;">
                    
                    <!-- Quick Actions -->
                    <div class="card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                        <h2 style="font-size: 18px; font-weight: 800; color: #1a2536; margin: 0 0 16px 0;">Quick Actions</h2>
                        <div style="display: flex; flex-direction: column; gap: 12px;">
                            <a href="ManageStudents.aspx" style="display: block; text-align: center; padding: 12px; background: #1a2536; color: #fff; border-radius: 10px; font-weight: 700; text-decoration: none; transition: background 0.2s;" onmouseover="this.style.background='#2a384c'" onmouseout="this.style.background='#1a2536'">Manage students</a>
                            <a href="ManageNotes.aspx" style="display: block; text-align: center; padding: 12px; background: #fff; color: #1a2536; border: 1px solid #cbd5e1; border-radius: 10px; font-weight: 700; text-decoration: none; transition: background 0.2s;" onmouseover="this.style.background='#f8fafc'" onmouseout="this.style.background='#fff'">Manage Notes</a>
                            <a href="ManageQuiz.aspx" style="display: block; text-align: center; padding: 12px; background: #fff; color: #1a2536; border: 1px solid #cbd5e1; border-radius: 10px; font-weight: 700; text-decoration: none; transition: background 0.2s;" onmouseover="this.style.background='#f8fafc'" onmouseout="this.style.background='#fff'">Manage quizzes</a>
                        </div>
                    </div>

                    <!-- Interactive Classroom Summary -->
                    <div class="card" style="background: #fff; padding: 24px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03);">
                        <h2 style="font-size: 18px; font-weight: 800; color: #1a2536; margin: 0 0 16px 0;">Classroom Summary</h2>
                        
                        <asp:Repeater ID="rptClassroomSummary" runat="server">
                            <HeaderTemplate><div style="display: flex; flex-direction: column; gap: 4px;"></HeaderTemplate>
                            <ItemTemplate>
                                <a href="ManageStudents.aspx" class="interactive-row">
                                    <span style="font-weight: 700; color: #1a2536; font-size: 14px;"><%# Eval("className") %></span>
                                    <span style="font-size: 13px; color: #64748b; font-weight: 600;"><%# Eval("StudentCount") %> students</span>
                                </a>
                            </ItemTemplate>
                            <FooterTemplate></div></FooterTemplate>
                        </asp:Repeater>

                        <asp:Panel ID="pnlNoClassrooms" runat="server" Visible="false" Style="padding: 10px 0; color: #64748b; font-size: 14px;">
                            No classrooms found.
                        </asp:Panel>
                    </div>
                </div>

            </div>
        </main>

        <uc:Footer runat="server" />
    </form>

    <script type="text/javascript">
        // @ts-nocheck
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    </script>
</body>
</html>