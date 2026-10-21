<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentQuizList.aspx.cs" Inherits="Assignment.StudentQuizList" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sejarah Quizzes</title>

    <link href="index.css" rel="stylesheet" type="text/css" />
    <link href="StudentQuizList.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <uc:Header runat="server" />

<form id="form1" runat="server">

    <main class="quiz-page">

        <!-- =========================
             PAGE HEADER
        ========================== -->

        <section class="quiz-header">

            <h1>Sejarah Quizzes</h1>

            <p>
                Test your understanding of the topics you have<br />
                learned with curated checkpoint assessments.
            </p>

            <div class="quiz-search">

                <span class="search-icon">⌕</span>

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="search-input"
                    placeholder="Search quizzes ...">
                </asp:TextBox>

            </div>

        </section>


        <!-- =========================
             AVAILABLE QUIZZES
        ========================== -->

        <section class="quiz-section">

            <h2 class="section-title">
                Available Quizzes
            </h2>

            <div class="quiz-grid">

                <!-- Quiz 1 -->

                <article class="quiz-card">

                    <div class="quiz-card-top">

                        <span class="question-badge">
                            15 Questions
                        </span>

                        <span class="quiz-duration">
                            ♧ 20 Minutes
                        </span>

                    </div>

                    <h3>
                        Chapter 3: Road to Independence
                    </h3>

                    <p class="quiz-description">
                        Covers Malayan Union opposition, CLC 1949,
                        1955 Federal Election, and Merdeka London Mission.
                    </p>

                    <div class="quiz-card-action">

                        <asp:Button
                            ID="btnStartQuiz1"
                            runat="server"
                            Text="Start Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>


                <!-- Quiz 2 -->

                <article class="quiz-card">

                    <div class="quiz-card-top">

                        <span class="question-badge">
                            15 Questions
                        </span>

                        <span class="quiz-duration">
                            ♧ 20 Minutes
                        </span>

                    </div>

                    <h3>
                        Chapter 3: Road to Independence
                    </h3>

                    <p class="quiz-description">
                        Covers Malayan Union opposition, CLC 1949,
                        1955 Federal Election, and Merdeka London Mission.
                    </p>

                    <div class="quiz-card-action">

                        <asp:Button
                            ID="btnStartQuiz2"
                            runat="server"
                            Text="Start Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>


                <!-- Quiz 3 -->

                <article class="quiz-card">

                    <div class="quiz-card-top">

                        <span class="question-badge">
                            15 Questions
                        </span>

                        <span class="quiz-duration">
                            ♧ 20 Minutes
                        </span>

                    </div>

                    <h3>
                        Chapter 3: Road to Independence
                    </h3>

                    <p class="quiz-description">
                        Covers Malayan Union opposition, CLC 1949,
                        1955 Federal Election, and Merdeka London Mission.
                    </p>

                    <div class="quiz-card-action">

                        <asp:Button
                            ID="btnStartQuiz3"
                            runat="server"
                            Text="Start Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>


                <!-- Quiz 4 -->

                <article class="quiz-card">

                    <div class="quiz-card-top">

                        <span class="question-badge">
                            15 Questions
                        </span>

                        <span class="quiz-duration">
                            ♧ 20 Minutes
                        </span>

                    </div>

                    <h3>
                        Chapter 3: Road to Independence
                    </h3>

                    <p class="quiz-description">
                        Covers Malayan Union opposition, CLC 1949,
                        1955 Federal Election, and Merdeka London Mission.
                    </p>

                    <div class="quiz-card-action">

                        <asp:Button
                            ID="btnStartQuiz4"
                            runat="server"
                            Text="Start Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>

            </div>

        </section>


        <!-- =========================
             COMPLETED QUIZZES
        ========================== -->

        <section class="quiz-section completed-section">

            <h2 class="section-title">
                Completed Quizzes
            </h2>

            <div class="quiz-grid">

                <!-- Completed Quiz 1 -->

                <article class="completed-card">

                    <div class="completed-card-top">

                        <h3>
                            Chapter 3: Road to Independence
                        </h3>

                        <span class="score-badge">
                            Score : 10 / 15
                        </span>

                    </div>

                    <p class="completed-info">
                        completed 1 day 30 min ago
                        &nbsp; | &nbsp;
                        10m 43s taken
                    </p>

                    <div class="progress-container">

                        <div
                            class="progress-bar"
                            style="width: 50%;">
                        </div>

                    </div>

                    <div class="completed-action">

                        <asp:Button
                            ID="btnReviewQuiz1"
                            runat="server"
                            Text="Review Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>


                <!-- Completed Quiz 2 -->

                <article class="completed-card">

                    <div class="completed-card-top">

                        <h3>
                            Chapter 3: Road to Independence
                        </h3>

                        <span class="score-badge">
                            Score : 10 / 15
                        </span>

                    </div>

                    <p class="completed-info">
                        completed 1 day 30 min ago
                        &nbsp; | &nbsp;
                        10m 43s taken
                    </p>

                    <div class="progress-container">

                        <div
                            class="progress-bar"
                            style="width: 50%;">
                        </div>

                    </div>

                    <div class="completed-action">

                        <asp:Button
                            ID="btnReviewQuiz2"
                            runat="server"
                            Text="Review Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>


                <!-- Completed Quiz 3 -->

                <article class="completed-card">

                    <div class="completed-card-top">

                        <h3>
                            Chapter 3: Road to Independence
                        </h3>

                        <span class="score-badge">
                            Score : 10 / 15
                        </span>

                    </div>

                    <p class="completed-info">
                        completed 1 day 30 min ago
                        &nbsp; | &nbsp;
                        10m 43s taken
                    </p>

                    <div class="progress-container">

                        <div
                            class="progress-bar"
                            style="width: 50%;">
                        </div>

                    </div>

                    <div class="completed-action">

                        <asp:Button
                            ID="btnReviewQuiz3"
                            runat="server"
                            Text="Review Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>


                <!-- Completed Quiz 4 -->

                <article class="completed-card">

                    <div class="completed-card-top">

                        <h3>
                            Chapter 3: Road to Independence
                        </h3>

                        <span class="score-badge">
                            Score : 10 / 15
                        </span>

                    </div>

                    <p class="completed-info">
                        completed 1 day 30 min ago
                        &nbsp; | &nbsp;
                        10m 43s taken
                    </p>

                    <div class="progress-container">

                        <div
                            class="progress-bar"
                            style="width: 50%;">
                        </div>

                    </div>

                    <div class="completed-action">

                        <asp:Button
                            ID="btnReviewQuiz4"
                            runat="server"
                            Text="Review Quiz →"
                            CssClass="quiz-button" />

                    </div>

                </article>

            </div>

        </section>

    </main>

</form>
    <uc:Footer runat="server" />

</body>
</html>