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

<main class="classroom-page">
    <!-- Page Introduction -->
    <section class="classroom-intro">
        <div>
            <h1>My Classrooms</h1>
            <p>Choose a classroom to access your Sejarah lessons, quizzes and class discussions.</p>
            <span class="classroom-breadcrumb">
                Sejarah KSSM • Form 4 • SMK Taman Melawati
            </span>
        </div>

        <span class="classroom-count">3 joined classrooms</span>
    </section>


    <!-- Joined Classrooms -->
    <section class="joined-classrooms">

        <div class="section-heading">
            <h2>Joined Classrooms</h2>
            <p>Your lessons and programs are organised by classroom.</p>
        </div>


        <div class="classroom-grid">

            <!-- Classroom 1 -->
            <article class="classroom-card">

                <div class="card-top">
                    <div class="classroom-icon">
                        <span>▣</span>
                    </div>

                    <span class="classroom-tag">Last viewed</span>
                </div>

                <div class="card-content">

                    <h3>4 Amanah • Sejarah</h3>

                    <p class="classroom-info">
                        Form 4 • 4 Amanah
                    </p>

                    <p class="classroom-info">
                        Sejarah KSSM • 2026
                    </p>

                    <div class="teacher">
                        <div class="teacher-avatar">CN</div>

                        <div>
                            <span>Teacher</span>
                            <strong>Cikgu Nurul</strong>
                        </div>
                    </div>

                </div>

                <div class="card-footer">

                    <div class="classroom-stats">
                        <span>30 students</span>
                        <span>Joined January 2026</span>
                    </div>

                    <a href="#" class="view-classroom">
                        View classroom
                        <span>→</span>
                    </a>

                </div>

            </article>


            <!-- Classroom 2 -->
            <article class="classroom-card">

                <div class="card-top">
                    <div class="classroom-icon">
                        <span>▣</span>
                    </div>

                    <span class="classroom-tag">Revision group</span>
                </div>

                <div class="card-content">

                    <h3>Sejarah Revision</h3>

                    <p class="classroom-info">
                        Form 4 • 4 Amanah & 4 Bestari
                    </p>

                    <p class="classroom-info">
                        Sejarah KSSM • 2026
                    </p>

                    <div class="teacher">
                        <div class="teacher-avatar">CF</div>

                        <div>
                            <span>Teacher</span>
                            <strong>Cikgu Farid</strong>
                        </div>
                    </div>

                </div>

                <div class="card-footer">

                    <div class="classroom-stats">
                        <span>48 students</span>
                        <span>Joined August 2026</span>
                    </div>

                    <a href="#" class="view-classroom">
                        View classroom
                        <span>→</span>
                    </a>

                </div>

            </article>


            <!-- Classroom 3 -->
            <article class="classroom-card">

                <div class="card-top">
                    <div class="classroom-icon">
                        <span>▣</span>
                    </div>

                    <span class="classroom-tag">Study group</span>
                </div>

                <div class="card-content">

                    <h3>Sejarah KBAT Workshop</h3>

                    <p class="classroom-info">
                        Form 4 • Mixed classes
                    </p>

                    <p class="classroom-info">
                        Sejarah KSSM • 2026
                    </p>

                    <div class="teacher">
                        <div class="teacher-avatar">CA</div>

                        <div>
                            <span>Teacher</span>
                            <strong>Cikgu Aisyah</strong>
                        </div>
                    </div>

                </div>

                <div class="card-footer">

                    <div class="classroom-stats">
                        <span>24 students</span>
                        <span>Joined September 2026</span>
                    </div>

                    <a href="#" class="view-classroom">
                        View classroom
                        <span>→</span>
                    </a>

                </div>

            </article>

        </div>

    </section>


    <!-- Find Another Classroom -->
    <section class="find-classroom">

        <div class="find-icon">+</div>

        <div class="find-content">
            <h3>Looking for another classroom?</h3>
            <p>
                Use the invite code from your teacher in
                "Join New Classroom" on your dashboard.
            </p>
        </div>

        <a href="StudentDashboard.aspx" class="dashboard-button">
            Go to dashboard
            <span>→</span>
        </a>

    </section>

</main>
    <uc:Footer runat="server" />
</body>

</html>