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


    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <asp:HiddenField ID="quizElapsedSeconds" runat="server" ClientIDMode="Static" />

        <main class="quiz-page">

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

            <div class="classroom-label">
                &lt;Classroom Name&gt;
            </div>

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

                    <span
                        class="time-value"
                        id="timeSpentValue"
                        runat="server">⏱ 00:00</span>

                </div>

            </section>

            <div class="quiz-layout">

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

                    <div id="answerArea" runat="server">

                        <asp:Repeater ID="AnswerRepeater" runat="server">
                            <ItemTemplate>
                                <label class='answer-option<%# IsAnswerSelected((int)Eval("questionID"), (int)Eval("answerID")) ? " selected" : "" %>'>
                                    <input type="radio"
                                        name='<%# "answer_" + Eval("questionID") %>'
                                        value='<%# Eval("answerID") %>'
                                        <%# GetCheckedAttribute((int)Eval("questionID"), (int)Eval("answerID")) %>
                                        onchange="selectAnswer(this)" />
                                    <span class="answer-letter"><%# GetAnswerLetter(Container.ItemIndex) %></span>
                                    <span class="answer-text"><%#: GetAnswerText(Container.DataItem) %></span>
                                    <span class="answer-radio"></span>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Label
                            ID="NoAnswersMessage"
                            runat="server"
                            CssClass="question-instruction"
                            Text="No answer options are available for this question."
                            Visible="false" />

                    </div>

                    <div class="answer-status">
                        ✓&nbsp; Answer saved automatically · Just now
                    </div>

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

                    <asp:Button
                        ID="SubmitQuizButton"
                        runat="server"
                        Text="Submit quiz"
                        CssClass="submit-quiz-button"
                        OnClick="SubmitQuizButton_Click" />

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

        <asp:Panel
            ID="ResultsModal"
            runat="server"
            CssClass="results-overlay"
            Visible="false"
            EnableViewState="false">

            <div class="results-dialog" role="dialog" aria-modal="true" aria-labelledby="resultsTitle">

                <div class="results-header">

                    <h2 id="resultsTitle">Quiz Results</h2>

                    <p>
                        <asp:Literal ID="ResultsSummary" runat="server" />
                    </p>

                </div>

                <div class="results-body">

                    <asp:Repeater ID="ResultsRepeater" runat="server">

                        <ItemTemplate>

                            <div class="result-question">

                                <div class="result-question-title">

                                    <span class="result-number"><%# Container.ItemIndex + 1 %>.</span>

                                    <span class="result-question-text"><%#: Eval("QuestionText") %></span>

                                    <span class='result-status <%# Eval("StatusClass") %>'><%#: Eval("StatusText") %></span>

                                </div>

                                <asp:Repeater
                                    ID="ResultOptionsRepeater"
                                    runat="server"
                                    DataSource='<%# Eval("Options") %>'>

                                    <ItemTemplate>

                                        <div class='<%# Eval("CssClass") %>'>

                                            <span class="result-option-text"><%#: Eval("AnswerText") %></span>

                                            <span class="result-option-tag"><%#: Eval("Tag") %></span>

                                        </div>

                                    </ItemTemplate>

                                </asp:Repeater>

                                <asp:PlaceHolder
                                    runat="server"
                                    Visible='<%# !(bool)Eval("IsAnswered") %>'>

                                    <p class="result-unanswered">Not answered</p>

                                </asp:PlaceHolder>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>

                </div>

                <div class="results-footer">

                    <button type="button" class="results-close-button" onserverclick="CloseResult" runat="server">
                        Return to Class
                    </button>

                </div>

            </div>

        </asp:Panel>

        <uc:Footer runat="server" />
    </form>


    <script>
        function selectAnswer(input) {
            var options = document.querySelectorAll('input[name="' + input.name + '"]');

            for (var i = 0; i < options.length; i++) {
                options[i].closest('.answer-option').classList.remove('selected');
            }

            input.closest('.answer-option').classList.add('selected');
        }

        // function closeResults() {
        //     var modal = document.querySelector('.results-overlay');

        //     if (modal) {
        //         modal.classList.add('hidden');
        //     }
        // }

        var quizStartTime = Date.now() -
            (parseInt(document.getElementById('quizElapsedSeconds').value, 10) || 0) * 1000;

        function padTime(value) {
            return value < 10 ? '0' + value : '' + value;
        }

        function updateTimeSpent() {
            var element = document.getElementById('timeSpentValue');

            if (!element) {
                return;
            }

            var totalSeconds = Math.max(0, Math.floor((Date.now() - quizStartTime) / 1000));
            var hours = Math.floor(totalSeconds / 3600);
            var minutes = Math.floor((totalSeconds % 3600) / 60);
            var seconds = totalSeconds % 60;

            element.textContent = (hours > 0 ? hours + ':' : '') + padTime(minutes) + ':' + padTime(seconds);
        }

        updateTimeSpent();
        setInterval(updateTimeSpent, 1000);
    </script>

</body>
</html>
