<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="StudentQuizList.aspx.cs"
    Inherits="Assignment.StudentQuizList" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Quiz History</title>

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="StudentQuizList.css" />
</head>

<body>

<form id="form1" runat="server">

    <uc:Header runat="server" />

    <main class="quiz-page">

        <!-- PAGE HEADER -->
        <section class="quiz-header">

            <h1>Quiz History</h1>

            <p>
                Complete quizzes from your enrolled classes and review your previous attempts.
            </p>

            <!-- SEARCH -->
            <div class="quiz-search">

                <span class="search-icon">⌕</span>

                <asp:TextBox
                    ID="searchBox"
                    runat="server"
                    CssClass="search-input"
                    placeholder="Search quizzes...">
                </asp:TextBox>

            </div>

        </section>


        <!-- ==========================================
             AVAILABLE QUIZZES
             ========================================== -->

        <section class="quiz-section">

            <h2 class="section-title">
                Available Quizzes
            </h2>

            <asp:Panel
                ID="availableEmptyPanel"
                runat="server"
                Visible="false"
                CssClass="empty-state">

                <p>No quizzes are currently available.</p>

            </asp:Panel>


            <div class="quiz-grid">

                <asp:Repeater
                    ID="availableQuizRepeater"
                    runat="server"
                    OnItemCommand="AvailableQuizRepeater_ItemCommand">

                    <ItemTemplate>

                        <div class="quiz-card">

                            <div class="quiz-card-top">

                                <span class="question-badge">
                                    <%# Eval("QuestionCount") %> Questions
                                </span>

                                <span class="quiz-duration">
                                    <%# Eval("DurationText") %>
                                </span>

                            </div>


                            <h3>
                                <%# Eval("Title") %>
                            </h3>


                            <p class="quiz-description">
                                <%# Eval("Description") %>
                            </p>


                            <div class="quiz-card-action">

                                <asp:Button
                                    ID="startQuizButton"
                                    runat="server"
                                    Text="Start Quiz"
                                    CssClass="quiz-button"
                                    CommandName="StartQuiz"
                                    CommandArgument='<%# Eval("QuizID") %>' />

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>


        <!-- ==========================================
             COMPLETED QUIZZES
             ========================================== -->

        <section class="quiz-section completed-section">

            <h2 class="section-title">
                Completed Quizzes
            </h2>


            <asp:Panel
                ID="completedEmptyPanel"
                runat="server"
                Visible="false"
                CssClass="empty-state">

                <p>You have not completed any quizzes yet.</p>

            </asp:Panel>


            <div class="quiz-grid">

                <asp:Repeater
                    ID="completedQuizRepeater"
                    runat="server"
                    OnItemCommand="CompletedQuizRepeater_ItemCommand">

                    <ItemTemplate>

                        <div class="completed-card">

                            <div class="completed-card-top">

                                <h3>
                                    <%# Eval("Title") %>
                                </h3>

                                <span class="score-badge">
                                    <%# Eval("ScoreText") %>
                                </span>

                            </div>


                            <p class="completed-info">

                                <%# Eval("QuestionCount") %> Questions
                                <br />

                                Time taken:
                                <%# Eval("TimeTakenText") %>

                            </p>


                            <div class="progress-container">

                                <div
                                    class="progress-bar"
                                    style='width: <%# Eval("ScorePercentage") %>%;'>
                                </div>

                            </div>


                            <div class="completed-action">

                                <asp:Button
                                    ID="viewResultButton"
                                    runat="server"
                                    Text="View Result"
                                    CssClass="quiz-button"
                                    CommandName="ViewResult"
                                    CommandArgument='<%# Eval("QuizID") %>' />

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>

    </main>

    <uc:Footer runat="server" />

</form>

</body>
</html>