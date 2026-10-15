<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Assignment.About" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About Ncient</title>

    <link href="index.css" rel="stylesheet" />
    <link href="About.css" rel="stylesheet" />
</head>

<body>

    <uc:Header runat="server" />
    <form id="form1" runat="server">

        <!-- ==============================
         ABOUT SECTION
         ============================== -->

        <section class="about-section">

            <div class="about-container">

                <!-- Left Content -->
                <div class="about-content">

                    <h1>About Ncient</h1>

                    <p class="about-description">
                        Making Sejarah learning more interactive, accessible,
                    and deeply engaging for secondary students across
                    all 14 states of Malaysia.
                    </p>

                    <!-- Tags -->
                    <div class="about-tags">
                        <span class="tag">F1 - F5</span>
                        <span class="tag">Teacher-curated Content</span>
                    </div>

                    <!-- Small cards -->
                    <div class="about-mini-cards">

                        <div class="mini-card">
                            <strong>100%</strong>
                            <span>KSSM Patuh</span>
                        </div>

                        <div class="mini-card">
                            <strong>5,000+</strong>
                            <span>Soalan KBAT &amp; Objektif</span>
                        </div>

                        <div class="mini-card">
                            <strong>T1 - T5</strong>
                            <span>Litupan Lengkap</span>
                        </div>

                    </div>
                </div>


                <!-- Right Image -->
                <div class="about-image placeholder">
                    <span></span>
                </div>

            </div>

        </section>


        <!-- ==============================
         MISSION & STORY
         ============================== -->

        <section class="story-section">

            <div class="story-container">

                <!-- Section Label -->
                <div class="section-label">
                    OUR MISSION &amp; STORY
                </div>


                <div class="story-content">

                    <!-- Left -->
                    <div class="story-text">

                        <h2>What is Ncient?</h2>

                        <p class="story-intro">
                            Ncient is a web-based Sejarah learning platform
                        designed to help secondary school students learn
                        History through structured learning materials,
                        interactive quizzes, and live classroom sessions.
                        </p>

                        <p>
                            For decades, Malaysian students have regarded
                        Sejarah as an exhaustive chore of rote memorization,
                        incurring major discipline as an interconnected
                        story of nationhood. By weaving chronological
                        narratives from the olden age of Kesultanan Melayu
                        Melaka straight to the dawn of Hari Kebangsaan
                        1957, we dismantle cognitive anxiety and cultivate
                        genuine historical curiosity.
                        </p>


                        <!-- Learning Material Items -->

                        <div class="material-list">

                            <div class="material-card">

                                <div class="material-icon placeholder">
                                    <span></span>
                                </div>

                                <div class="material-info">

                                    <h3>Strict KSSM Syllabus Adherence
                                    </h3>

                                    <p>
                                        Still strictly conforming to the latest
                                    Kementerian Pendidikan Malaysia (KPM)
                                    Kurikulum Standard Sekolah Menengah
                                    framework for Tingkatan 1 through Tingkatan 5.
                                    </p>

                                </div>

                            </div>


                            <div class="material-card">

                                <div class="material-icon placeholder">
                                    <span></span>
                                </div>

                                <div class="material-info">

                                    <h3>Strict KSSM Syllabus Adherence
                                    </h3>

                                    <p>
                                        Still strictly conforming to the latest
                                    Kementerian Pendidikan Malaysia (KPM)
                                    Kurikulum Standard Sekolah Menengah
                                    framework for Tingkatan 1 through Tingkatan 5.
                                    </p>

                                </div>

                            </div>


                            <div class="material-card">

                                <div class="material-icon placeholder">
                                    <span></span>
                                </div>

                                <div class="material-info">

                                    <h3>Strict KSSM Syllabus Adherence
                                    </h3>

                                    <p>
                                        Still strictly conforming to the latest
                                    Kementerian Pendidikan Malaysia (KPM)
                                    Kurikulum Standard Sekolah Menengah
                                    framework for Tingkatan 1 through Tingkatan 5.
                                    </p>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- Right Image -->
                    <div class="story-image placeholder">
                        <span></span>
                    </div>

                </div>

            </div>

        </section>


        <!-- ==============================
         OUR PURPOSE
         ============================== -->

        <section class="purpose-section">

            <div class="purpose-container">

                <div class="section-label purpose-label">
                    OUR PURPOSE
                </div>

                <p class="purpose-description">
                    A clear, evidence-based pedagogical cycle built to
                empower every Malaysian student.
                </p>


                <!-- Feature Cards -->

                <div class="feature-grid">

                    <!-- Learning Materials -->
                    <div class="feature-card">

                        <div class="feature-image placeholder">
                            <span></span>
                        </div>

                        <h3>Learning Materials</h3>

                        <p>
                            Access Sejarah notes and structured materials.
                        Comprehensive chapter summaries, mind maps,
                        and historical chronologies designed for
                        rapid revision.
                        </p>

                        <a href="#" class="feature-link">Explore More&nbsp; →
                        </a>

                    </div>


                    <!-- Interactive Quizzes -->
                    <div class="feature-card">

                        <div class="feature-image placeholder">
                            <span></span>
                        </div>

                        <h3>Interactive Quizzes</h3>

                        <p>
                            Test knowledge with available historical quizzes.
                        Guided topical drills, PA KSSM question patterns,
                        and direct feedback on solutions.
                        </p>

                        <a href="#" class="feature-link">Attempt Quizzes&nbsp; →
                        </a>

                    </div>


                    <!-- Live Session -->
                    <div class="feature-card">

                        <div class="feature-image placeholder">
                            <span></span>
                        </div>

                        <h3>Live Session</h3>

                        <p>
                            Join classroom live sessions and learn directly
                        with teachers. Ask questions in real-time,
                        clarify confusing concepts, and review past recordings.
                        </p>

                        <a href="#" class="feature-link">Join Schedule&nbsp; →
                        </a>

                    </div>


                    <!-- Learning Progress -->
                    <div class="feature-card">

                        <div class="feature-image placeholder">
                            <span></span>
                        </div>

                        <h3>Learning Progress</h3>

                        <p>
                            Track quiz results and syllabus mastery.
                        Get granular breakdowns of weak topics before
                        national examinations and assessments.
                        </p>

                        <a href="#" class="feature-link">View Progress&nbsp; →
                        </a>

                    </div>

                </div>

            </div>

        </section>


        <!-- ==============================
         CTA
         ============================== -->

        <section class="cta-section">

            <div class="cta-container">

                <div class="cta-content">

                    <h2>Ready to Start Learning Sejarah
                    </h2>

                    <p>
                        Join thousands of Malaysian secondary school students
                    who use Ncient to ace their historical concepts,
                    conquer KBAT, and score an A+ in Sejarah SP M.
                    </p>

                    <a href="#" class="cta-button">Get Started&nbsp; →
                    </a>

                </div>


                <div class="cta-image placeholder">
                    <span></span>
                </div>

            </div>

        </section>


    </form>

    <uc:Footer runat="server" />
</body>
</html>
