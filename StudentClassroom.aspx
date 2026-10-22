<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentClassroom.aspx.cs" Inherits="Assignment.StudentClassroom" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>My Classrooms</title>

    <link href="index.css" rel="stylesheet" type="text/css" />
    <link href="StudentClassroom.css" rel="stylesheet" type="text/css" />

</head>

<body>

    <uc:Header runat="server" />

    <form id="form1" runat="server">

        <main class="classroom-page">

            <!-- ==========================================
                 PAGE INTRODUCTION
            =========================================== -->

            <section class="classroom-intro">

                <div>

                    <h1>My Classrooms</h1>

                    <p>
                        Choose a classroom to access your Sejarah
                        lessons, quizzes and class discussions.
                    </p>


                </div>


                <span
                    class="classroom-count"
                    id="classroomCount"
                    runat="server">
                    0 joined classrooms
                </span>

            </section>


            <!-- ==========================================
                 JOINED CLASSROOMS
            =========================================== -->

            <section class="joined-classrooms">

                <div class="section-heading">

                    <h2>Joined Classrooms</h2>

                    <p>
                        Your lessons and programs are organised by classroom.
                    </p>

                </div>


                <!-- ==========================================
                     CLASSROOM GRID
                =========================================== -->

                <div class="classroom-grid">

                    <asp:Repeater
                        ID="ClassroomRepeater"
                        runat="server"
                        OnItemCommand="ClassroomRepeater_ItemCommand">

                        <ItemTemplate>

                            <!-- ==========================================
                                 CLASSROOM CARD
                            =========================================== -->

                            <article class="classroom-card">


                                <!-- Card Top -->

                                <div class="card-top">

                                    <div class="classroom-icon">
                                        <span>▣</span>
                                    </div>

                                </div>


                                <!-- Card Content -->

                                <div class="card-content">

                                    <!-- Classroom Name -->

                                    <h3>
                                        <%# Eval("className") %>
                                    </h3>


                                    <!-- Classroom Description -->

                                    <p class="classroom-info">
                                        <%# Eval("description") %>
                                    </p>


                                    <!-- Subject -->

                                    <p class="classroom-info">
                                        <%# Eval("subject") %>
                                    </p>


                                    <!-- Teacher -->

                                    <div class="teacher">

                                        <div class="teacher-avatar">

                                            <asp:Image
                                                ID="TeacherProfilePic"
                                                runat="server"
                                                ImageUrl='<%# Eval("profilePic") %>'
                                                AlternateText="Teacher profile picture" />

                                        </div>


                                        <div>

                                            <span>Teacher</span>

                                            <strong>
                                                <%# Eval("lastName") %>
                                            </strong>

                                        </div>

                                    </div>

                                </div>


                                <!-- Card Footer -->

                                <div class="card-footer">


                                    <!-- Classroom Statistics -->

                                    <div class="classroom-stats">

                                        <span>
                                            <%# Eval("studentCount") %> students
                                        </span>

                                        <span>
                                            Joined
                                            <%# Eval("enrollDate", "{0:MMMM yyyy}") %>
                                        </span>

                                    </div>


                                    <!-- View Classroom -->

                                    <asp:LinkButton
                                        ID="ViewClassroomButton"
                                        runat="server"
                                        CssClass="view-classroom"
                                        CommandName="ViewClassroom"
                                        CommandArgument='<%# Eval("classID") %>'>

                                        View classroom
                                        <span>→</span>

                                    </asp:LinkButton>


                                </div>

                            </article>

                        </ItemTemplate>

                    </asp:Repeater>


                    <!-- ==========================================
                         EMPTY CLASSROOM MESSAGE
                    =========================================== -->

                    <asp:Panel
                        ID="emptyClassroomPanel"
                        runat="server"
                        CssClass="empty-classroom"
                        Visible="false">

                        <h3>No classrooms joined</h3>

                        <p>
                            You have not joined any classrooms yet.
                            Ask your teacher for an invite code.
                        </p>


                    </asp:Panel>

                </div>

            </section>


            <!-- ==========================================
                 FIND ANOTHER CLASSROOM
            =========================================== -->

            <section class="find-classroom">

                <div class="find-icon">
                    +
                </div>


                <div class="find-content">

                    <h3>
                        Looking for another classroom?
                    </h3>

                    <p>
                        Use the invite code from your teacher in
                        "Join New Classroom" on your dashboard.
                    </p>

                </div>


                <a
                    href="StudentDashboard.aspx"
                    class="dashboard-button">

                    Go to dashboard
                    <span>→</span>

                </a>

            </section>

        </main>

    </form>


    <uc:Footer runat="server" />

</body>

</html>
