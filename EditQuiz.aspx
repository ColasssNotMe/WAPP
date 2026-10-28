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
    <link rel="stylesheet" href="CreateQuiz.css">
    <style>
        .builder-card {
            background: #fff;
            border-radius: 20px;
            padding: 24px;
            margin-bottom: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-left: 6px solid #1a2536;
        }
        .question-card {
            border-left: 6px solid #475569;
            position: relative;
        }
        .option-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
        }
        .btn-remove-q {
            background: #ef4444;
            color: #fff;
            border: none;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            float: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="create-quiz-container">
            
            <!-- Header Section -->
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
                        <p class="page-subtitle">Modify quiz questions, settings, and answers.</p>
                    </div>
                </div>
            </header>

            <!-- Quiz Settings Header Card -->
            <div class="builder-card">
                <h2 class="card-title">Quiz Header</h2>
                <div class="quiz-form">
                    <div class="form-group">
                        <label>Quiz Title</label>
                        <asp:TextBox ID="txtQuizTitle" runat="server" CssClass="form-control" placeholder="Quiz Title" />
                    </div>

                    <div style="display: flex; gap: 20px;">
                        <div class="form-group" style="flex: 1;">
                            <label>Classroom</label>
                            <asp:DropDownList ID="ddlClassroom" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group" style="width: 150px;">
                            <label>Calculated Marks</label>
                            <asp:TextBox ID="txtTotalMarks" runat="server" CssClass="form-control" Text="0" ReadOnly="true" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Dynamic Question Cards Repeater -->
            <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
                <ItemTemplate>
                    <div class="builder-card question-card">
                        <asp:Button ID="btnRemoveQuestion" runat="server" Text="Delete Question" 
                            CssClass="btn-remove-q" CommandName="RemoveQuestion" CommandArgument='<%# Container.ItemIndex %>' />
                        
                        <h3 style="font-size:16px; font-weight:700; margin-bottom:16px; color:#1a2536;">
                            Question <%# Container.ItemIndex + 1 %>
                        </h3>

                        <div class="quiz-form">
                            <div style="display: flex; gap: 16px;">
                                <div class="form-group" style="flex: 2;">
                                    <label>Question Text</label>
                                    <asp:TextBox ID="txtQuestionText" runat="server" CssClass="form-control" 
                                        Text='<%# Eval("QuestionText") %>' placeholder="Enter your question here..." />
                                </div>
                                <div class="form-group" style="flex: 1;">
                                    <label>Question Type</label>
                                    <asp:DropDownList ID="ddlQuestionType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlQuestionType_SelectedIndexChanged" SelectedValue='<%# Eval("QuestionType") %>'>
                                        <asp:ListItem Text="Multiple Choice" Value="MCQ" />
                                        <asp:ListItem Text="Short Answer" Value="ShortAnswer" />
                                        <asp:ListItem Text="True / False" Value="TrueFalse" />
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group" style="width: 100px;">
                                    <label>Marks</label>
                                    <asp:TextBox ID="txtMarks" runat="server" CssClass="form-control" TextMode="Number" 
                                        Text='<%# Eval("Marks") %>' />
                                </div>
                            </div>

                            <!-- Multiple Choice & True/False Answers Block -->
                            <asp:Panel ID="pnlOptions" runat="server" Visible='<%# Eval("QuestionType").ToString() == "MCQ" || Eval("QuestionType").ToString() == "TrueFalse" %>'>
                                <label style="font-weight:600; font-size:14px; margin-bottom:8px; display:block;">Answers / Options</label>
                                
                                <div class="option-row">
                                    <asp:RadioButton ID="rb1" runat="server" GroupName="CorrectAns" Checked='<%# Eval("IsCorrect1") != DBNull.Value && Convert.ToBoolean(Eval("IsCorrect1")) %>' />
                                    <asp:TextBox ID="txtOption1" runat="server" CssClass="form-control" Text='<%# Eval("Option1") %>' placeholder="Option 1" />
                                </div>
                                <div class="option-row">
                                    <asp:RadioButton ID="rb2" runat="server" GroupName="CorrectAns" Checked='<%# Eval("IsCorrect2") != DBNull.Value && Convert.ToBoolean(Eval("IsCorrect2")) %>' />
                                    <asp:TextBox ID="txtOption2" runat="server" CssClass="form-control" Text='<%# Eval("Option2") %>' placeholder="Option 2" />
                                </div>
                                
                                <asp:Panel ID="pnlExtraMcq" runat="server" Visible='<%# Eval("QuestionType").ToString() == "MCQ" %>'>
                                    <div class="option-row">
                                        <asp:RadioButton ID="rb3" runat="server" GroupName="CorrectAns" Checked='<%# Eval("IsCorrect3") != DBNull.Value && Convert.ToBoolean(Eval("IsCorrect3")) %>' />
                                        <asp:TextBox ID="txtOption3" runat="server" CssClass="form-control" Text='<%# Eval("Option3") %>' placeholder="Option 3" />
                                    </div>
                                    <div class="option-row">
                                        <asp:RadioButton ID="rb4" runat="server" GroupName="CorrectAns" Checked='<%# Eval("IsCorrect4") != DBNull.Value && Convert.ToBoolean(Eval("IsCorrect4")) %>' />
                                        <asp:TextBox ID="txtOption4" runat="server" CssClass="form-control" Text='<%# Eval("Option4") %>' placeholder="Option 4" />
                                    </div>
                                </asp:Panel>
                            </asp:Panel>

                            <!-- Short Answer Block -->
                            <asp:Panel ID="pnlShortAnswer" runat="server" Visible='<%# Eval("QuestionType").ToString() == "ShortAnswer" %>'>
                                <div class="form-group">
                                    <label>Expected Answer (Optional Key)</label>
                                    <asp:TextBox ID="txtCorrectShortAnswer" runat="server" CssClass="form-control" Text='<%# Eval("Option1") %>' placeholder="Enter key answer for auto-grading..." />
                                </div>
                            </asp:Panel>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Builder Action Bar -->
            <div style="display: flex; gap: 16px; margin-top: 20px; justify-content: space-between; align-items: center;">
                <asp:Button ID="btnAddQuestion" runat="server" Text="+ Add Question" CssClass="btn btn-secondary" OnClick="btnAddQuestion_Click" />
                
                <div style="display:flex; gap:12px;">
                    <asp:Button ID="btnUpdateQuiz" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnUpdateQuiz_Click" />
                    <a href="ManageQuiz.aspx" class="btn btn-secondary">Cancel</a>
                </div>
            </div>

        </div>
    </form>
</body>
</html>