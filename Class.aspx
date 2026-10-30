<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Class.aspx.cs"
    Inherits="Assignment.Class" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <link href="index.css" rel="stylesheet" />
    <link href="Class.css?v=2" rel="stylesheet" />

    <title>Class</title>

</head>

<body>

    <form id="form1" runat="server">

        <uc:Header ID="HeaderControl" runat="server" />

        <main class="class-page">

            <section class="class-header">

                <div class="class-header-content">

                    <h1
                        id="className"
                        runat="server"
                        class="class-title">
                    </h1>

                    <div class="teacher-info">

                        <svg
                            width="16"
                            height="16"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            aria-hidden="true">

                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />

                            <circle cx="12" cy="7" r="4" />

                        </svg>

                        <span
                            id="teacherName"
                            runat="server">
                        </span>

                    </div>

                </div>

                <a
                    href="StudentClassroom.aspx"
                    class="back-button">

                    <svg
                        width="14"
                        height="14"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        aria-hidden="true">

                        <path d="M15 18l-6-6 6-6" />

                    </svg>

                    <span>Back to Classrooms</span>

                </a>

            </section>

            <section class="section-card">

                <a
                    class="section-title section-title-link"
                    href='<%: "StudentClassLearningMaterial.aspx?classID=" + GetClassIDForLink() %>'>

                    <span>Learning Materials</span>

                    <svg
                        class="section-arrow"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        aria-hidden="true">

                        <path d="M9 5l7 7-7 7" />

                    </svg>

                </a>

                <asp:Repeater
                    ID="LearningMaterialsRepeater"
                    runat="server"
                    OnItemCommand="LearningMaterialsRepeater_ItemCommand">

                    <ItemTemplate>

                        <div class="learning-item">

                            <div class="item-icon">

                                <svg
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7">

                                    <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v15H6.5A2.5 2.5 0 0 0 4 20.5V5.5Z" />

                                    <path d="M4 5.5V20.5" />

                                    <path d="M8 7h8" />

                                    <path d="M8 10h6" />

                                </svg>

                            </div>

                            <div class="item-content">

                                <p class="item-title">
                                    <%# Eval("title") %>
                                </p>

                                <p class="item-info">
                                    <%# "Chapter " + Eval("chapter") %>
                                </p>

                            </div>

                            <div class="item-action">

                                <asp:LinkButton
                                    ID="lnkOpenMaterial"
                                    runat="server"
                                    CommandName="OpenMaterial"
                                    CommandArgument='<%# Eval("materialID") %>'
                                    CssClass="material-link">
                                    View Material
                                </asp:LinkButton>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <div
                    id="materialPlaceholder"
                    runat="server"
                    class="empty-placeholder"
                    visible="false">

                    <p class="empty-title">
                        No Learning Materials
                    </p>

                    <p class="empty-info">
                        There are currently no learning materials available for this class.
                    </p>

                </div>

            </section>

            <section class="section-card">

                <a
                    class="section-title section-title-link"
                    href='<%: "StudentClassQuizList.aspx?classID=" + GetClassIDForLink() %>'>

                    <span>Quiz</span>

                    <svg
                        class="section-arrow"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        aria-hidden="true">

                        <path d="M9 5l7 7-7 7" />

                    </svg>

                </a>

                <asp:Repeater
                    ID="QuizRepeater"
                    runat="server"
                    OnItemCommand="QuizRepeater_ItemCommand">

                    <ItemTemplate>

                        <div class="learning-item">

                            <div class="item-icon">

                                <svg
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7">

                                    <rect
                                        x="5"
                                        y="3"
                                        width="14"
                                        height="18"
                                        rx="2" />

                                    <path d="M8 7h8" />

                                    <path d="M8 11h8" />

                                    <path d="M8 15h5" />

                                </svg>

                            </div>

                            <div class="item-content">

                                <p class="item-title">
                                    <%# Eval("title") %>
                                </p>

                                <p
                                    class="item-info"
                                    runat="server"
                                    visible='<%# HasAttempt(Container.DataItem) %>'>

                                    <%# GetScoreDisplay(Container.DataItem) %>

                                </p>

                                <p
                                    class="item-info no-attempt"
                                    runat="server"
                                    visible='<%# !HasAttempt(Container.DataItem) %>'>

                                    No attempt

                                </p>

                            </div>

                            <div class="item-action">

                                <asp:LinkButton
                                    ID="lnkOpenQuiz"
                                    runat="server"
                                    CommandName="OpenQuiz"
                                    CommandArgument='<%# Eval("quizID") %>'
                                    CssClass="quiz-link">
                                    Attempt Quiz
                                </asp:LinkButton>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <div
                    id="quizPlaceholder"
                    runat="server"
                    class="empty-placeholder"
                    visible="false">

                    <p class="empty-title">
                        No Quizzes
                    </p>

                    <p class="empty-info">
                        There are currently no quizzes available for this class.
                    </p>

                </div>

            </section>

            <div
                id="errorInfo"
                runat="server"
                class="error-info"
                visible="false">
            </div>

        </main>

        <uc:Footer
            ID="FooterControl"
            runat="server" />

    </form>

</body>

</html>