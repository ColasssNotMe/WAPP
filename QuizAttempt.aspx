<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizAttempt.aspx.cs" Inherits="Assignment.QuizAttempt" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz Attempt</title>

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="QuizAttempt.css" />
</head>

<body>

    <uc:Header runat="server" />

    <form id="form1" runat="server">

        <main class="quiz-page">

            <!-- =========================
                 PAGE HEADING
            ========================== -->

            <div class="quiz-heading">

                <div>
                    <h1>Quiz Attempt</h1>

                    <p>
                        Work at your own pace and review your answers before submitting.
                    </p>
                </div>

                <asp:HyperLink
                    ID="BackToQuizzes"
                    runat="server"
                    NavigateUrl="StudentQuizList.aspx"
                    CssClass="back-button">
                    ←&nbsp; Back to quizzes
                </asp:HyperLink>

            </div>


            <!-- =========================
                 CLASSROOM
            ========================== -->

            <div class="classroom-label">
                &lt;Classroom Name&gt;
            </div>


            <!-- =========================
                 QUIZ INFORMATION
            ========================== -->

            <section class="quiz-info-card">

                <div>
                    <span
                        class="quiz-title"
                        id="quizTitle"
                        runat="server"></span>
                </div>

                <div class="time-section">

                    <span class="time-label">Time Spent
                    </span>

                    <span class="time-value">⏱&nbsp; 14:32
                    </span>

                </div>

            </section>


            <!-- =========================
                 QUIZ AREA
            ========================== -->

            <div class="quiz-layout">


                <!-- =========================
                     QUESTION
                ========================== -->

                <section class="question-card">

                    <div class="question-top">

                        <span
                            class="question-number"
                            id="questionNumber"
                            runat="server"></span>

                        <span
                            class="question-mark"
                            id="questionMark"
                            runat="server"></span>

                    </div>


                    <h2
                        class="question-title"
                        id="questionTitle"
                        runat="server"></h2>


                    <p class="question-instruction">
                        Choose one answer.
                    </p>


                    <!-- =========================
                         ANSWER AREA

                         Keep your existing answer
                         controls here for now.
                    ========================== -->

                    <div id="answerArea" runat="server">

                        <!--
                            Your answer options can be
                            dynamically loaded here later
                            once the Answer table structure
                            is available.
                        -->

                    </div>


                    <!-- =========================
                         AUTO SAVE
                    ========================== -->

                    <div class="answer-status">
                        ✓&nbsp; Answer saved automatically · Just now
                    </div>


                    <!-- =========================
                         NAVIGATION
                    ========================== -->

                    <div class="question-navigation">

                        <asp:Button
                            ID="PreviousButton"
                            runat="server"
                            Text="←  Previous"
                            CssClass="previous-button"
                            OnClick="PreviousButton_Click" />

                        <asp:Button
                            ID="NextButton"
                            runat="server"
                            Text="Next question  →"
                            CssClass="next-button"
                            OnClick="NextButton_Click" />

                    </div>

                </section>


                <!-- =========================
                     QUESTION NAVIGATOR
                ========================== -->

                <aside class="navigator-card">

                    <h3>Question Navigator
                    </h3>


                    <div class="navigator-progress">

                        <div class="progress-info">

                            <span id="answeredText" runat="server">0 of 0 answered
                            </span>

                            <strong id="progressPercentage" runat="server">0%
                            </strong>

                        </div>

                        <div class="progress-bar">

                            <div
                                class="progress-value"
                                id="progressValue"
                                runat="server">
                            </div>

                        </div>

                    </div>


                    <!-- =========================
                         DYNAMIC QUESTION BUTTONS
                    ========================== -->

                    <div class="question-grid">

                        <asp:Repeater
                            ID="QuestionNavigatorRepeater"
                            runat="server"
                            OnItemCommand="QuestionNavigatorRepeater_ItemCommand">

                            <ItemTemplate>

                                <asp:LinkButton
                                    ID="QuestionButton"
                                    runat="server"
                                    Text='<%# Container.ItemIndex + 1 %>'
                                    CommandName="GoToQuestion"
                                    CommandArgument='<%# Container.ItemIndex %>'
                                    CssClass='<%# GetQuestionButtonClass(Container.ItemIndex) %>'>
                                </asp:LinkButton>

                            </ItemTemplate>

                        </asp:Repeater>
                    </div>


                    <!-- =========================
                         LEGEND
                    ========================== -->

                    <div class="navigator-legend">

                        <p>
                            Filled: answered
                        </p>

                        <p>
                            ○ Outlined: unanswered
                        </p>

                        <p>
                            Current question:
                            <strong id="currentQuestionLegend" runat="server">1
                            </strong>
                        </p>

                    </div>


                    <!-- =========================
                         SUBMIT
                    ========================== -->

                    <asp:Button
                        ID="SubmitQuizButton"
                        runat="server"
                        Text="Submit quiz"
                        CssClass="submit-quiz-button" />


                    <p
                        class="remaining-text"
                        id="remainingText"
                        runat="server">
                        0 questions are still unanswered.
                        You can review them before submitting.
                    </p>

                </aside>

            </div>

        </main>

    </form>

    <uc:Footer runat="server" />

</body>
</html>
