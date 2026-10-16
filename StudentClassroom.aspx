<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentClassroom.aspx.cs" Inherits="Assignment.StudentClassroom" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>My Classrooms</title>

    <link href="index.css" rel="stylesheet" type="text/css" />
    <link href="StudentClassroom.css" rel="stylesheet" type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <main class="classrooms-page">

        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <section class="classrooms-header">

            <div class="header-left">

                <h1>My Classrooms</h1>

                <p>
                    Choose a classroom to access your Sejarah lessons,
                    quizzes and class discussions.
                </p>

            </div>

            <div class="classroom-count">
                3 joined classrooms
            </div>

        </section>


        <!-- =====================================
             CLASS / USER INFORMATION
        ====================================== -->

        <div class="classroom-meta">

            <span>
                Sejarah KSSM • Form 4 • SMK Taman Melawati
            </span>

            <span>
                Aiman bin Abdullah • user001
            </span>

        </div>


        <!-- =====================================
             JOINED CLASSROOMS HEADER
        ====================================== -->

        <section class="joined-section">

            <div class="section-heading">

                <h2>
                    Joined Classrooms
                </h2>

                <span>
                    Your lessons and progress are organised by classroom.
                </span>

            </div>


            <!-- =====================================
                 CLASSROOM CARDS
            ====================================== -->

            <div class="classroom-grid">


                <!-- CLASSROOM 1 -->

                <article class="classroom-card">

                    <div class="card-top">

                        <div class="book-icon">
                            ♧
                        </div>

                        <span class="classroom-tag">
                            Last viewed
                        </span>

                    </div>


                    <div class="classroom-content">

                        <h3>
                            4 Amanah • Sejarah
                        </h3>

                        <p class="classroom-subtitle">
                            Form 4 • 4 Amanah
                        </p>

                        <p class="classroom-subtitle">
                            Sejarah KSSM • 2026
                        </p>


                        <!-- Teacher -->

                        <div class="teacher-info">

                            <div class="teacher-avatar">
                                CN
                            </div>

                            <div>

                                <span class="teacher-label">
                                    Teacher
                                </span>

                                <strong>
                                    Cikgu Nurul
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="card-divider"></div>


                    <div class="card-footer-info">

                        <span>
                            30 students
                        </span>

                        <span>
                            Joined January 2026
                        </span>

                    </div>


                    <asp:Button
                        ID="btnClassroom1"
                        runat="server"
                        Text="View classroom   →"
                        CssClass="view-classroom-button" />

                </article>


                <!-- CLASSROOM 2 -->

                <article class="classroom-card">

                    <div class="card-top">

                        <div class="book-icon">
                            ♧
                        </div>

                        <span class="classroom-tag">
                            Revision group
                        </span>

                    </div>


                    <div class="classroom-content">

                        <h3>
                            Sejarah Revision
                        </h3>

                        <p class="classroom-subtitle">
                            Form 4 • 4 Amanah &amp; 4 Bestari
                        </p>

                        <p class="classroom-subtitle">
                            Sejarah KSSM • 2026
                        </p>


                        <div class="teacher-info">

                            <div class="teacher-avatar">
                                CF
                            </div>

                            <div>

                                <span class="teacher-label">
                                    Teacher
                                </span>

                                <strong>
                                    Cikgu Farid
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="card-divider"></div>


                    <div class="card-footer-info">

                        <span>
                            48 students
                        </span>

                        <span>
                            Joined August 2026
                        </span>

                    </div>


                    <asp:Button
                        ID="btnClassroom2"
                        runat="server"
                        Text="View classroom   →"
                        CssClass="view-classroom-button" />

                </article>


                <!-- CLASSROOM 3 -->

                <article class="classroom-card">

                    <div class="card-top">

                        <div class="book-icon">
                            ♧
                        </div>

                        <span class="classroom-tag">
                            Study group
                        </span>

                    </div>


                    <div class="classroom-content">

                        <h3>
                            Sejarah KBAT Workshop
                        </h3>

                        <p class="classroom-subtitle">
                            Form 4 • Mixed classes
                        </p>

                        <p class="classroom-subtitle">
                            Sejarah KSSM • 2026
                        </p>


                        <div class="teacher-info">

                            <div class="teacher-avatar">
                                CA
                            </div>

                            <div>

                                <span class="teacher-label">
                                    Teacher
                                </span>

                                <strong>
                                    Cikgu Aisyah
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="card-divider"></div>


                    <div class="card-footer-info">

                        <span>
                            24 students
                        </span>

                        <span>
                            Joined September 2026
                        </span>

                    </div>


                    <asp:Button
                        ID="btnClassroom3"
                        runat="server"
                        Text="View classroom   →"
                        CssClass="view-classroom-button" />

                </article>


            </div>

        </section>


        <!-- =====================================
             JOIN ANOTHER CLASSROOM
        ====================================== -->

        <section class="another-classroom">

            <div class="another-classroom-left">

                <div class="plus-icon">
                    +
                </div>

                <div>

                    <h3>
                        Looking for another classroom?
                    </h3>

                    <p>
                        Use the invite code from your teacher in
                        “Join New Classroom” on your dashboard.
                    </p>

                </div>

            </div>


            <asp:Button
                ID="btnDashboard"
                runat="server"
                Text="Go to dashboard   →"
                CssClass="dashboard-button" />

        </section>


    </main>

</form>

</body>

</html>