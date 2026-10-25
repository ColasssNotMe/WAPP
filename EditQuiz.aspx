<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditQuiz.aspx.cs" Inherits="Assignment.EditQuiz" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Quiz</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="EditQuiz.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="create-quiz-container">
            <header class="page-header">
                <div class="header-left">
                    <a href="ManageQuiz.aspx" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <div class="title-group">
                        <h1 class="page-title">Edit Quiz</h1>
                        <p class="page-subtitle">Update quiz settings and details.</p>
                    </div>
                </div>
            </header>

            <div class="create-quiz-grid">
                <main class="card quiz-settings-card">
                    <h2 class="card-title">Edit Quiz Settings</h2>
                    <div class="quiz-form">
                        <div class="form-group">
                            <label for="txtQuizTitle">Quiz title</label>
                            <asp:TextBox ID="txtQuizTitle" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="ddlClassroom">Classroom</label>
                            <asp:DropDownList ID="ddlClassroom" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label for="txtTotalMarks">Total Marks</label>
                            <asp:TextBox ID="txtTotalMarks" runat="server" CssClass="form-control" TextMode="Number" />
                        </div>

                        <div class="form-actions">
                            <asp:Button ID="btnUpdateQuiz" runat="server" Text="Save changes" CssClass="btn btn-primary" OnClick="btnUpdateQuiz_Click" />
                            <a href="ManageQuiz.aspx" class="btn btn-secondary">Cancel</a>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </form>
</body>
</html>