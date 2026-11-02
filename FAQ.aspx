<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="Assignment.FAQ" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Frequently Asked Questions | Ncient Education</title>
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="FAQ.css">
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header ID="HeaderControl" runat="server" />

        <main class="faq-page-container">

            <!-- Page Header -->
            <header class="page-header">
                <h1>Frequently Asked Questions</h1>
                <p>Quick answers to the most common questions from students, teachers, and parents using Ncient.</p>
            </header>

            <!-- Category Filter Pills -->
            <nav class="faq-filter" aria-label="FAQ categories">
                <button type="button" class="filter-pill active" data-category="all">All</button>
                <button type="button" class="filter-pill" data-category="getting-started">Getting Started</button>
                <button type="button" class="filter-pill" data-category="account">Account &amp; Security</button>
                <button type="button" class="filter-pill" data-category="learning">Learning &amp; Quizzes</button>
                <button type="button" class="filter-pill" data-category="classroom">Classrooms</button>
                <button type="button" class="filter-pill" data-category="teacher">For Teachers</button>
            </nav>

            <!-- Getting Started -->
            <section class="faq-group" data-category="getting-started">
                <div class="faq-group-header">
                    <div class="faq-group-icon" aria-hidden="true">
                        <!-- Lucide Rocket -->
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4.5 16.5c-1.5 1.26-2 5-2 5s3.74-.5 5-2c.71-.84.7-2.13-.09-2.91a2.18 2.18 0 0 0-2.91-.09z"></path>
                            <path d="m12 15-3-3a22 22 0 0 1 2-3.95A12.88 12.88 0 0 1 22 2c0 2.72-.78 7.5-6 11a22.35 22.35 0 0 1-4 2z"></path>
                            <path d="M9 12H4s.55-3.03 2-4c1.62-1.08 5 0 5 0"></path>
                            <path d="M12 15v5s3.03-.55 4-2c1.08-1.62 0-5 0-5"></path>
                        </svg>
                    </div>
                    <h2>Getting Started</h2>
                </div>

                <div class="faq-list">
                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>What is Ncient Education?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Ncient Education is a Malaysian online learning platform designed to help secondary school students master the <strong>Sejarah (History)</strong> subject. It offers structured reading materials, gamified chapter quizzes, teacher-led live sessions, and classroom management tools — all in one place.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Who can register on Ncient?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Ncient supports two user roles: <strong>Students</strong> and <strong>Teachers</strong>. Students can self-register and immediately access learning materials and quizzes. Teachers register with pending approval — an administrator verifies teaching credentials before activating the account.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Is Ncient free to use?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Yes. All core features — reading materials, quizzes, classroom enrolment, and live sessions — are freely accessible to registered students and approved teachers.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Which subjects or syllabuses does Ncient cover?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Ncient currently focuses on <strong>Malaysian Sejarah</strong> for secondary school (Form 1–5). Content is structured by chapter and aligned to the national Kementerian Pendidikan Malaysia (KPM) curriculum.
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Account & Security -->
            <section class="faq-group" data-category="account">
                <div class="faq-group-header">
                    <div class="faq-group-icon" aria-hidden="true">
                        <!-- Lucide ShieldCheck -->
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            <polyline points="9 12 11 14 15 10"></polyline>
                        </svg>
                    </div>
                    <h2>Account &amp; Security</h2>
                </div>

                <div class="faq-list">
                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I register a new account?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Click <strong>Register</strong> in the top navigation. Fill in your full name, a unique username, your email address, and a strong password. Select your role (Student or Teacher) and submit the form. Student accounts are activated immediately; Teacher accounts require admin approval first.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>What are the password requirements?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Your password must be at least 8 characters long and include all of the following: an <strong>uppercase letter</strong>, a <strong>lowercase letter</strong>, a <strong>number</strong>, and a <strong>special character</strong> (e.g. !, @, #, $). This applies to both registration and password reset.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I reset a forgotten password?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                On the Login page, click <strong>Forgot Password?</strong>. Enter your registered email address and a secure 6-digit verification code will be sent to you. Enter the code within 5 minutes, then set your new password immediately.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Why is my Teacher account showing "Pending Approval"?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                To maintain platform safety, all teacher accounts are reviewed by an administrator before activation. This process typically takes 1–2 business days. Once approved, you will be able to log in and access your Teacher Dashboard.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Can I change my username or email after registration?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Profile updates including display name and profile picture can be managed from your Dashboard. For email or username changes, please contact support through the <a href="ContactUs.aspx">Contact Us</a> page as these are linked to your account identity.
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Learning & Quizzes -->
            <section class="faq-group" data-category="learning">
                <div class="faq-group-header">
                    <div class="faq-group-icon" aria-hidden="true">
                        <!-- Lucide BookOpen -->
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                        </svg>
                    </div>
                    <h2>Learning &amp; Quizzes</h2>
                </div>

                <div class="faq-list">
                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I access learning materials?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Once logged in, click <strong>Learning Materials</strong> in the navigation bar. Materials are organised by chapter and form level. Click any material card to start reading. Your progress is tracked automatically.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How are quiz scores calculated?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Each question carries a specific mark. After you submit a quiz attempt, your total score and percentage are calculated instantly and stored in your profile. You can view your quiz history and results from your Student Dashboard.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Can I retake a quiz?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Quiz retake policies are set by your teacher. If retakes are allowed, the option will appear on the quiz result page. All attempts are recorded and visible to your teacher.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I track my learning progress?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Your Student Dashboard displays a progress bar for each material you have started. Completed chapters are marked, and quiz completion is shown alongside your scores. Progress updates in real time as you study.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>What happens if I close the browser mid-quiz?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                If you close the browser without submitting, your current quiz attempt will not be saved. You will need to start the quiz again from the beginning. Always click <strong>Submit</strong> before closing to record your score.
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Classrooms -->
            <section class="faq-group" data-category="classroom">
                <div class="faq-group-header">
                    <div class="faq-group-icon" aria-hidden="true">
                        <!-- Lucide GraduationCap -->
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                            <path d="M6 12v5c3 3 9 3 12 0v-5"></path>
                        </svg>
                    </div>
                    <h2>Classrooms</h2>
                </div>

                <div class="faq-list">
                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I join a classroom?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                From your <strong>Student Dashboard</strong>, find the "Join Classroom" section. Enter the 6-character invite code given by your teacher and click <strong>Join</strong>. The classroom's materials and quizzes will appear in your dashboard immediately upon successful enrolment.
                            </div>  
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Where do I find my classroom invite code?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Your teacher will share the classroom invite code with you directly — usually via school messaging, email, or during class. Do not share this code publicly; it is intended only for students in that class.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Can I be in more than one classroom?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Yes. You can enrol in multiple classrooms simultaneously using different invite codes. Each classroom's content appears separately in your dashboard.
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- For Teachers -->
            <section class="faq-group" data-category="teacher">
                <div class="faq-group-header">
                    <div class="faq-group-icon" aria-hidden="true">
                        <!-- Lucide Users -->
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                        </svg>
                    </div>
                    <h2>For Teachers</h2>
                </div>

                <div class="faq-list">
                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I create a classroom?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                From your <strong>Teacher Dashboard</strong>, click <strong>Create Classroom</strong>. Give your classroom a name and description. A unique invite code is generated automatically — share this with your students so they can enrol.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I upload learning materials?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                In your Teacher Dashboard, select <strong>Materials</strong> and click <strong>Add Material</strong>. You can create and publish structured reading content organised by chapter. Published materials are immediately visible to enrolled students.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>How do I create and publish a quiz?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Go to <strong>Quiz</strong> in your Teacher Dashboard and click <strong>Create Quiz</strong>. Add questions with multiple-choice answers and assign marks per question. When ready, set the quiz status to <strong>Published</strong> to make it visible to students in your class.
                            </div>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button type="button" class="faq-question" onclick="toggleFaq(this)">
                            <span>Can I view my students' quiz results?</span>
                            <span class="faq-chevron" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
                            </span>
                        </button>
                        <div class="faq-answer-wrapper">
                            <div class="faq-answer">
                                Yes. From your Teacher Dashboard, navigate to <strong>Student Progress</strong> to view individual scores, completion rates, and quiz history for all enrolled students in your classroom.
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Still need help banner -->
            <section class="help-banner">
                <div class="help-banner-text">
                    <h3>Didn't find your answer?</h3>
                    <p>Our support team is ready to help you Monday through Friday.</p>
                </div>
                <div class="banner-actions">
                    <a href="ContactUs.aspx" class="btn-contact">Contact Support &rarr;</a>
                </div>
            </section>

        </main>

        <uc:Footer ID="FooterControl" runat="server" />
    </form>

    <script>
        // Accordion toggle
        function toggleFaq(btn) {
            const item = btn.closest('.faq-item');
            item.classList.toggle('open');
        }

        // Category filter
        document.querySelectorAll('.filter-pill').forEach(function (pill) {
            pill.addEventListener('click', function () {
                document.querySelectorAll('.filter-pill').forEach(function (p) { p.classList.remove('active'); });
                this.classList.add('active');

                var cat = this.dataset.category;
                document.querySelectorAll('.faq-group').forEach(function (group) {
                    if (cat === 'all' || group.dataset.category === cat) {
                        group.style.display = '';
                    } else {
                        group.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>
