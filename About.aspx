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

<body class="about-page">

    <div class="page-progress" aria-hidden="true"><span></span></div>

    <form id="form1" runat="server">
    <uc:Header runat="server" />
        <section class="about-section reveal-section">

            <div class="about-container">

                <div class="about-content">

                    <h1>About Ncient</h1>

                    <p class="about-description">
                        Making Sejarah learning more interactive, accessible,
                    and deeply engaging for secondary students across
                    all 14 states of Malaysia.
                    </p>

                    <div class="about-tags">
                        <span class="tag">
                            <svg class="tag-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M2 9l10-5 10 5-10 5z" /><path d="M6 11.5V16c0 1.5 3 3 6 3s6-1.5 6-3v-4.5M22 9v6" /></svg>
                            F1 - F5
                        </span>
                        <span class="tag">
                            <svg class="tag-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6z" /><path d="M9 12l2 2 4-4" /></svg>
                            Teacher-curated Content
                        </span>
                    </div>

                    <div class="about-mini-cards">

                        <div class="mini-card stat-card" tabindex="0">
                            <svg class="mini-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6z" /><path d="M9 12l2 2 4-4" /></svg>
                            <strong class="count count-100"><span class="sr-only">100%</span></strong>
                            <span>KSSM Patuh</span>
                        </div>

                        <div class="mini-card stat-card" tabindex="0">
                            <svg class="mini-icon" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9" /><path d="M9.5 9.5a2.5 2.5 0 1 1 3.5 2.3c-.7.4-1 .9-1 1.7M12 17h.01" /></svg>
                            <strong class="count count-5000"><span class="sr-only">5000+</span></strong>
                            <span>Soalan KBAT &amp; Objektif</span>
                        </div>

                        <div class="mini-card stat-card" tabindex="0">
                            <svg class="mini-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3l9 5-9 5-9-5z" /><path d="M3 12l9 5 9-5M3 16l9 5 9-5" /></svg>
                            <strong>T1 - T5</strong>
                            <span>Litupan Lengkap</span>
                        </div>

                    </div>
                </div>

                <div class="about-image art art-hero">
                    <svg viewBox="0 0 240 208" role="img" aria-label="Open Sejarah book in front of the A Famosa gate under a rising sun">
                        <defs>
                            <linearGradient id="heroSky" x1="0" y1="0" x2="0" y2="1">
                                <stop offset="0" stop-color="#FFF0E7" />
                                <stop offset="1" stop-color="#FBD9C0" />
                            </linearGradient>
                        </defs>
                        <rect width="240" height="208" fill="url(#heroSky)" />

                        <circle class="art-sun" cx="168" cy="64" r="26" fill="#C5A059" />
                        <circle class="art-sun-ring" cx="168" cy="64" r="34" fill="none" stroke="#C5A059" stroke-width="1.5" />

                        <g class="art-float">
                            <path d="M38 36a15 15 0 1 0 15 21 12 12 0 1 1-15-21z" fill="#08749C" />
                            <polygon points="62,30 64.5,37 72,37 66,41.5 68.2,48.5 62,44.3 55.8,48.5 58,41.5 52,37 59.5,37" fill="#08749C" />
                        </g>

                        <path d="M44 162V98h12v-8h8v8h10v-8h8v8h10v-8h8v8h12v64z" fill="#1C2541" />
                        <path d="M70 162v-30a14 14 0 0 1 28 0v30z" fill="#FBD9C0" />
                        <path d="M70 162v-30a14 14 0 0 1 28 0v30z" fill="none" stroke="#C5A059" stroke-width="2" />
                        <rect x="52" y="108" width="6" height="12" rx="3" fill="#C5A059" opacity=".7" />
                        <rect x="110" y="108" width="6" height="12" rx="3" fill="#C5A059" opacity=".7" />

                        <rect y="162" width="240" height="46" fill="#1C2541" />
                        <rect y="162" width="240" height="3" fill="#C5A059" />

                        <g class="art-book">
                            <path d="M112 150q28-10 56 0v36q-28-8-56 0z" fill="#fff" stroke="#C5A059" stroke-width="2" />
                            <path d="M168 150q28-10 56 0v36q-28-8-56 0z" fill="#fff" stroke="#C5A059" stroke-width="2" />
                            <path d="M122 160q18-5 36 0M122 168q18-5 36 0M122 176q12-3 24 0" stroke="#1C2541" stroke-width="2" stroke-linecap="round" fill="none" opacity=".35" />
                            <path d="M178 160q18-5 36 0M178 168q18-5 36 0M178 176q12-3 24 0" stroke="#1C2541" stroke-width="2" stroke-linecap="round" fill="none" opacity=".35" />
                            <line x1="168" y1="150" x2="168" y2="186" stroke="#C5A059" stroke-width="2" />
                        </g>

                        <g class="art-float art-float-slow" fill="none" stroke="#1C2541" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M196 96h20l-8 14 8 14h-20l8-14z" />
                            <path d="M202 120h8" stroke="#C5A059" />
                        </g>
                    </svg>
                </div>

            </div>

        </section>

        <section class="story-section reveal-section">

            <div class="story-container">

                <div class="section-label">
                    OUR MISSION &amp; STORY
                </div>

                <div class="story-content">

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

                        <div class="material-list">

                            <div class="material-card interactive-card" tabindex="0">

                                <div class="material-icon art">
                                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6z" /><path d="M9 12l2 2 4-4" /></svg>
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

                                    <div class="material-more"><span>Every topic is mapped to the official KSSM standards, so you only study what is examined.</span></div>

                                </div>

                                <svg class="material-chevron" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9l6 6 6-6" /></svg>

                            </div>

                            <div class="material-card interactive-card" tabindex="0">

                                <div class="material-icon art">
                                    <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="4" width="18" height="12" rx="1.5" /><path d="M8 20l4-4 4 4M7 9h6M7 12h4" /></svg>
                                </div>

                                <div class="material-info">

                                    <h3>Teacher-curated Content
                                    </h3>

                                    <p>
                                        Notes, quizzes and live lessons are prepared
                                    and reviewed by real Sejarah teachers who know
                                    what students struggle with.
                                    </p>

                                    <div class="material-more"><span>Teachers can upload materials, set quizzes and run live sessions from one place.</span></div>

                                </div>

                                <svg class="material-chevron" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9l6 6 6-6" /></svg>

                            </div>

                            <div class="material-card interactive-card" tabindex="0">

                                <div class="material-icon art">
                                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9 18h6M10 21h4M12 3a6 6 0 0 0-3.5 10.9c.6.5 1 1.2 1 2.1h5c0-.9.4-1.6 1-2.1A6 6 0 0 0 12 3z" /></svg>
                                </div>

                                <div class="material-info">

                                    <h3>Learn Through Understanding
                                    </h3>

                                    <p>
                                        Chronological stories and timelines replace
                                    rote memorisation, so events connect into one
                                    story of nationhood.
                                    </p>

                                    <div class="material-more"><span>Mind maps and timelines show cause and effect, which is exactly what KBAT questions test.</span></div>

                                </div>

                                <svg class="material-chevron" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9l6 6 6-6" /></svg>

                            </div>

                        </div>

                    </div>

                    <div class="story-image art art-story">
                        <svg viewBox="0 0 240 248" role="img" aria-label="Timeline from Melaka in 1400 to Merdeka in 1957">
                            <line class="tl-line" x1="48" y1="40" x2="48" y2="208" />

                            <g>
                                <circle cx="48" cy="40" r="9" class="tl-node" />
                                <text x="70" y="38" class="tl-year">1400</text>
                                <text x="70" y="54" class="tl-text">Melaka founded</text>
                            </g>
                            <g>
                                <circle cx="48" cy="96" r="9" class="tl-node" />
                                <text x="70" y="94" class="tl-year">1511</text>
                                <text x="70" y="110" class="tl-text">Fall of Melaka</text>
                            </g>
                            <g>
                                <circle cx="48" cy="152" r="9" class="tl-node" />
                                <text x="70" y="150" class="tl-year">1941</text>
                                <text x="70" y="166" class="tl-text">Japanese occupation</text>
                            </g>
                            <g>
                                <circle cx="48" cy="208" r="16" class="tl-pulse" />
                                <circle cx="48" cy="208" r="10" class="tl-node tl-node-final" />
                                <text x="70" y="206" class="tl-year">1957</text>
                                <text x="70" y="222" class="tl-text">Merdeka!</text>
                            </g>
                        </svg>
                    </div>

                </div>

            </div>

        </section>

        <section class="purpose-section reveal-section">

            <div class="purpose-container">

                <div class="section-label purpose-label">
                    OUR PURPOSE
                </div>

                <p class="purpose-description">
                    A clear, evidence-based pedagogical cycle built to
                empower every Malaysian student.
                </p>

                <div class="feature-grid">

                    <div class="feature-card reveal-item">

                        <div class="feature-image art art-notes">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 6c-2-1.5-5-2-9-2v14c4 0 7 .5 9 2 2-1.5 5-2 9-2V4c-4 0-7 .5-9 2z" /><path d="M12 6v14" /></svg>
                        </div>

                        <h3>Learning Materials</h3>

                        <p>
                            Access Sejarah notes and structured materials.
                        Comprehensive chapter summaries, mind maps,
                        and historical chronologies designed for
                        rapid revision.
                        </p>

                        <a href="StudentLearningMaterial.aspx" class="feature-link">Explore More&nbsp; →
                        </a>

                    </div>

                    <div class="feature-card reveal-item">

                        <div class="feature-image art art-quiz">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="5" y="4" width="14" height="17" rx="2" /><path d="M9 4h6v3H9z" /><path d="M9 14l2 2 4-4" /></svg>
                        </div>

                        <h3>Interactive Quizzes</h3>

                        <p>
                            Test knowledge with available historical quizzes.
                        Guided topical drills, PA KSSM question patterns,
                        and direct feedback on solutions.
                        </p>

                        <a href="StudentQuizList.aspx" class="feature-link">Attempt Quizzes&nbsp; →
                        </a>

                    </div>

                    <div class="feature-card reveal-item">

                        <div class="feature-image art art-live">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="6" width="13" height="12" rx="2" /><path d="M16 10l5-3v10l-5-3" /><circle class="live-dot" cx="6.5" cy="9.5" r="1.2" /></svg>
                        </div>

                        <h3>Live Session</h3>

                        <p>
                            Join classroom live sessions and learn directly
                        with teachers. Ask questions in real-time,
                        clarify confusing concepts, and review past recordings.
                        </p>

                        <a href="LiveSession.aspx" class="feature-link">Join Schedule&nbsp; →
                        </a>

                    </div>

                    <div class="feature-card reveal-item">

                        <div class="feature-image art art-progress">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 20h18" /><rect class="bar bar-1" x="5" y="12" width="3" height="8" /><rect class="bar bar-2" x="10.5" y="8" width="3" height="12" /><rect class="bar bar-3" x="16" y="4" width="3" height="16" /></svg>
                        </div>

                        <h3>Learning Progress</h3>

                        <p>
                            Track quiz results and syllabus mastery.
                        Get granular breakdowns of weak topics before
                        national examinations and assessments.
                        </p>

                        <a href="StudentProgess.aspx" class="feature-link">View Progress&nbsp; →
                        </a>

                    </div>

                </div>

            </div>

        </section>

        <section class="cta-section reveal-section">

            <div class="cta-container">

                <div class="cta-content">

                    <h2>Ready to Start Learning Sejarah
                    </h2>

                    <p>
                        Join thousands of Malaysian secondary school students
                    who use Ncient to ace their historical concepts,
                    conquer KBAT, and score an A+ in Sejarah SP M.
                    </p>

                    <a href="Register.aspx" class="cta-button">Get Started&nbsp; →
                    </a>

                </div>

                <div class="cta-image art art-cta">
                    <svg viewBox="0 0 128 88" aria-hidden="true">
                        <circle cx="64" cy="46" r="34" fill="#C5A059" opacity=".18" />
                        <g class="cta-cap" fill="none" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M24 38l40-20 40 20-40 20z" fill="#C5A059" />
                            <path d="M42 49v15c0 5 10 10 22 10s22-5 22-10V49" />
                            <path d="M104 38v22" />
                        </g>
                        <g class="cta-spark" fill="#fff">
                            <path d="M16 14l2 5 5 2-5 2-2 5-2-5-5-2 5-2z" />
                            <path d="M110 10l1.5 4 4 1.5-4 1.5-1.5 4-1.5-4-4-1.5 4-1.5z" />
                        </g>
                    </svg>
                </div>

            </div>

        </section>

    <uc:Footer runat="server" />
    </form>

</body>
</html>
