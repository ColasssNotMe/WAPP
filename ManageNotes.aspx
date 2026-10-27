<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageNotes.aspx.cs" Inherits="Assignment.ManageNotes" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Notes</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="ManageQuiz.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="quizzes-container">
            <header class="page-header">
                <div class="header-left">
                    <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <div class="title-group">
                        <h1 class="page-title">Manage Notes</h1>
                        <p class="page-subtitle">Publish structured notes, summaries, and reference materials for your students.</p>
                    </div>
                </div>
            </header>

            <div class="quizzes-content-grid">

                <main class="card quiz-library-card">
                    <h2 class="card-title">Notes Library</h2>

                    <div class="quiz-items-wrapper">
                        <asp:Repeater ID="rptNotes" runat="server" OnItemCommand="rptNotes_ItemCommand">
                            <ItemTemplate>
                                <div class="quiz-row">
                                    <div class="quiz-info">
                                        <h3 class="quiz-name">
                                            <asp:LinkButton ID="lblNoteSelect" runat="server"
                                                CommandName="SelectNote"
                                                CommandArgument='<%# Eval("materialID") %>'
                                                Text='<%# Eval("title") %>'
                                                CssClass="quiz-link" />
                                        </h3>
                                        <p class="quiz-meta"><%# Eval("className") %> • Chapter <%# Eval("chapter") %></p>
                                    </div>
                                    <span class="status-badge <%# Eval("status").ToString().ToLower() == "published" ? "published" : "draft" %>">
                                        <%# Eval("status") %>
                                    </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <asp:Button ID="btnAddNote" runat="server" Text="Add note" CssClass="btn btn-create-quiz" OnClick="btnAddNote_Click" />
                </main>

                <aside class="card quiz-details-card">
                    <h2 class="card-title">Note Details</h2>

                    <div class="details-list">
                        <div class="details-row">
                            <span class="details-label">Note Title</span>
                            <span class="details-value"><asp:Label ID="lblDetailTitle" runat="server" Text="Select a note" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Chapter</span>
                            <span class="details-value"><asp:Label ID="lblDetailChapter" runat="server" Text="-" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Classroom</span>
                            <span class="details-value"><asp:Label ID="lblDetailClassroom" runat="server" Text="-" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Upload Date</span>
                            <span class="details-value"><asp:Label ID="lblDetailDate" runat="server" Text="-" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Status</span>
                            <span class="details-value"><asp:Label ID="lblDetailStatus" runat="server" Text="-" /></span>
                        </div>
                    </div>

                    <asp:Panel ID="pnlActions" runat="server" Visible="false" Style="margin-top:20px;">
                        <div class="details-actions" style="display: flex; gap: 10px;">
                            <asp:Button ID="btnEditNote" runat="server" Text="Edit note" CssClass="btn btn-primary" OnClick="btnEditNote_Click" />
                            <asp:Button ID="btnDeleteNote" runat="server" Text="Delete note" CssClass="btn btn-danger" OnClick="btnDeleteNote_Click" OnClientClick="return confirm('Are you sure you want to delete this note?');" />
                        </div>
                    </asp:Panel>
                </aside>
            </div>
        </div>
    </form>
</body>
</html>