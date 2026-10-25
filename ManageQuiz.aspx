<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageQuiz.aspx.cs" Inherits="Assignment.ManageQuiz" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Quizzes</title>
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
                        <h1 class="page-title">Manage Quizzes</h1>
                        <p class="page-subtitle">Create, assign, and review quizzes for your students across all classrooms.</p>
                    </div>
                </div>
            </header>

            <div class="quizzes-content-grid">
                <!-- Left Column: Quiz Library Card -->
                <main class="card quiz-library-card">
                    <h2 class="card-title">Quiz Library</h2>

                    <div class="quiz-items-wrapper">
                        <asp:Repeater ID="rptQuizzes" runat="server" OnItemCommand="rptQuizzes_ItemCommand">
                            <ItemTemplate>
                                <div class="quiz-row">
                                    <div class="quiz-info">
                                        <h3 class="quiz-name">
                                            <asp:LinkButton ID="lblQuizSelect" runat="server" 
                                                CommandName="SelectQuiz" 
                                                CommandArgument='<%# Eval("quizID") %>' 
                                                Text='<%# Eval("title") %>' 
                                                CssClass="quiz-link" />
                                        </h3>
                                        <p class="quiz-meta"><%# Eval("className") %> • <%# Eval("totalMarks") %> marks</p>
                                    </div>
                                    <span class="status-badge published">Published</span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <asp:Button ID="btnCreateQuiz" runat="server" Text="Create quiz" CssClass="btn btn-create-quiz" OnClick="btnCreateQuiz_Click" />
                </main>

                <!-- Right Column: Quiz Details Card -->
                <aside class="card quiz-details-card">
                    <h2 class="card-title">Quiz Details</h2>

                    <div class="details-list">
                        <div class="details-row">
                            <span class="details-label">Quiz</span>
                            <span class="details-value"><asp:Label ID="lblDetailTitle" runat="server" Text="Select a quiz" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Classroom</span>
                            <span class="details-value"><asp:Label ID="lblDetailClassroom" runat="server" Text="-" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Total Marks</span>
                            <span class="details-value"><asp:Label ID="lblDetailMarks" runat="server" Text="-" /></span>
                        </div>
                        <div class="details-row">
                            <span class="details-label">Created Date</span>
                            <span class="details-value"><asp:Label ID="lblDetailDate" runat="server" Text="-" /></span>
                        </div>
                    </div>

                    <!-- Action Buttons Panel -->
                    <asp:Panel ID="pnlActions" runat="server" Visible="false" Style="margin-top:20px;">
                        <div class="details-actions" style="display: flex; gap: 10px;">
                            <asp:Button ID="btnEditQuiz" runat="server" Text="Edit quiz" CssClass="btn btn-primary" OnClick="btnEditQuiz_Click" />
                            <asp:Button ID="btnDeleteQuiz" runat="server" Text="Delete quiz" CssClass="btn btn-danger" OnClick="btnDeleteQuiz_Click" OnClientClick="return confirm('Are you sure you want to delete this quiz?');" />
                        </div>
                    </asp:Panel>
                </aside>
            </div>
        </div>
    </form>
</body>
</html>