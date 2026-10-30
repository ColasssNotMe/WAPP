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


    <form id="form1" runat="server">

        <uc:Header runat="server" />
        <main class="classroom-page">

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
                    runat="server">0 joined classrooms
                </span>

            </section>


            <section class="joined-classrooms">

                <div class="section-heading">

                    <h2>Joined Classrooms</h2>

                    <p>
                        Your lessons and programs are organised by classroom.
                    </p>

                </div>

                <div class="classroom-grid">

                    <asp:Repeater
                        ID="ClassroomRepeater"
                        runat="server"
                        OnItemCommand="ClassroomRepeater_ItemCommand">

                        <ItemTemplate>
                            <article class="classroom-card">

                                <div class="card-top">


                                </div>

                                <div class="card-content">

                                    <h3>
                                        <%# Eval("className") %>
                                    </h3>

                                    <p class="classroom-info">
                                        <%# Eval("description") %>
                                    </p>

                                    <div class="teacher">

                                        <div class="teacher-avatar">

                                            <asp:Image
                                                ID="TeacherProfilePic"
                                                runat="server"
                                                ImageUrl='<%# GetTeacherProfilePic(Eval("profilePic")) %>'
                                                AlternateText="Teacher profile picture" />

                                        </div>

                                        <div>
                                            <span>Teacher</span>

                                            <strong>
                                                <%# GetTeacherName(Eval("firstName"), Eval("lastName")) %>
                                            </strong>

                                        </div>
                                    </div>
                                </div>

                                <div class="card-footer">
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



            <section class="find-classroom">

                <div class="find-icon">
                    +
                </div>


                <div class="find-content">

                    <h3>Looking for another classroom?
                    </h3>

                    <p>
                        Use the invite code from your teacher in
                        "Join New Classroom" on your dashboard.
                    </p>

                </div>


                <a
                    href="StudentDashboard.aspx"
                    class="dashboard-button">Go to dashboard
                    <span>→</span>

                </a>

            </section>

        </main>

        <uc:Footer runat="server" />
    </form>



</body>

</html>
