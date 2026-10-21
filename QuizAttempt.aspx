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



        <!-- =========================
         MAIN CONTENT
    ========================== -->

        <main class="quiz-page">

            <!-- Page heading -->

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
                    NavigateUrl="Quizzes.aspx"
                    CssClass="back-button">
                ←&nbsp; Back to quizzes
                </asp:HyperLink>

            </div>


            <!-- Classroom -->

            <div class="classroom-label">
                &lt;Classroom Name&gt;
            </div>


            <!-- =========================
             QUIZ INFORMATION
        ========================== -->

            <section class="quiz-info-card">

                <div>

                    <span class="quiz-title">Road to Independence
                    </span>

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

                        <span class="question-number">Question 4 of 15
                        </span>

                        <span class="question-mark">1 mark
                        </span>

                    </div>


                    <h2 class="question-title">What was the main purpose of the Merdeka Mission to London in 1956?
                    </h2>


                    <p class="question-instruction">
                        Choose one answer.
                    </p>


                    <!-- Option A -->

                    <label class="answer-option">

                        <input
                            type="radio"
                            name="question4"
                            value="A" />

                        <span class="answer-letter">A
                        </span>

                        <span class="answer-text">To introduce the Malaysian Union
                        </span>

                        <span class="answer-radio"></span>

                    </label>


                    <!-- Option B -->

                    <label class="answer-option selected">

                        <input
                            type="radio"
                            name="question4"
                            value="B"
                            checked="checked" />

                        <span class="answer-letter">B
                        </span>

                        <span class="answer-text">To negotiate independence with the British government
                        </span>

                        <span class="answer-radio"></span>

                    </label>


                    <!-- Option C -->

                    <label class="answer-option">

                        <input
                            type="radio"
                            name="question4"
                            value="C" />

                        <span class="answer-letter">C
                        </span>

                        <span class="answer-text">To establish the Communities Liaison Committee
                        </span>

                        <span class="answer-radio"></span>

                    </label>


                    <!-- Option D -->

                    <label class="answer-option">

                        <input
                            type="radio"
                            name="question4"
                            value="D" />

                        <span class="answer-letter">D
                        </span>

                        <span class="answer-text">To organise the first Federal Legislative Council election
                        </span>

                        <span class="answer-radio"></span>

                    </label>


                    <!-- Auto save -->

                    <div class="answer-status">
                        ✓&nbsp; Answer saved automatically · Just now
                    </div>


                    <!-- Navigation -->

                    <div class="question-navigation">

                        <asp:Button
                            ID="PreviousButton"
                            runat="server"
                            Text="←  Previous"
                            CssClass="previous-button" />

                        <asp:Button
                            ID="NextButton"
                            runat="server"
                            Text="Next question  →"
                            CssClass="next-button" />

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

                            <span>4 of 15 answered
                            </span>

                            <strong>27%
                            </strong>

                        </div>

                        <div class="progress-bar">

                            <div class="progress-value"></div>

                        </div>

                    </div>


                    <!-- Question buttons -->

                    <div class="question-grid">

                        <button type="button" class="nav-question answered">
                            01
                        </button>

                        <button type="button" class="nav-question answered">
                            02
                        </button>

                        <button type="button" class="nav-question answered">
                            03
                        </button>

                        <button type="button" class="nav-question current">
                            04
                        </button>

                        <button type="button" class="nav-question">
                            05
                        </button>

                        <button type="button" class="nav-question">
                            06
                        </button>

                        <button type="button" class="nav-question">
                            07
                        </button>

                        <button type="button" class="nav-question">
                            08
                        </button>

                        <button type="button" class="nav-question">
                            09
                        </button>

                        <button type="button" class="nav-question">
                            10
                        </button>

                        <button type="button" class="nav-question">
                            11
                        </button>

                        <button type="button" class="nav-question">
                            12
                        </button>

                        <button type="button" class="nav-question">
                            13
                        </button>

                        <button type="button" class="nav-question">
                            14
                        </button>

                        <button type="button" class="nav-question">
                            15
                        </button>

                    </div>


                    <!-- Legend -->

                    <div class="navigator-legend">

                        <p>
                            Filled: answered
                        </p>

                        <p>
                            ○ Outlined: unanswered
                        </p>

                        <p>
                            Current question: <strong>4</strong>
                        </p>

                    </div>


                    <asp:Button
                        ID="SubmitQuizButton"
                        runat="server"
                        Text="Submit quiz"
                        CssClass="submit-quiz-button" />


                    <p class="remaining-text">
                        11 questions are still unanswered.
                    You can review them before submitting.
                    </p>

                </aside>

            </div>

        </main>


    </form>

    <uc:Footer runat="server" />

</body>
</html>
