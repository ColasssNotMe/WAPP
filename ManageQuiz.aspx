<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Quizzes</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="ManageQuiz.css">
</head>
<body>

    <div class="quizzes-container">
        
        <!-- Header Section with Left Back Arrow -->
        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Manage Quizzes</h1>
                    <p class="page-subtitle">Create, assign, and review quizzes for your students across all classrooms.</p>
                </div>
            </div>
        </header>

        <!-- Main Grid Layout -->
        <div class="quizzes-content-grid">
            
            <!-- Left Column: Quiz Library Card -->
            <main class="card quiz-library-card">
                <h2 class="card-title">Quiz Library</h2>

                <div class="quiz-items-wrapper">
                    
                    <!-- Quiz 1 -->
                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Quiz – Chapter 1</h3>
                            <p class="quiz-meta">Topic 1 • 10 questions</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Quiz 2 -->
                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Quiz – Chapter 2</h3>
                            <p class="quiz-meta">Topic 2 • 12 questions</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Quiz 3 -->
                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Quiz – Chapter 3</h3>
                            <p class="quiz-meta">Topic 3 • 15 questions</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Quiz 4 -->
                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Mid-term review quiz</h3>
                            <p class="quiz-meta">Mixed topics • 20 questions</p>
                        </div>
                        <span class="status-badge draft">Draft</span>
                    </div>

                </div>

                <!-- Create Quiz Button -->
                <button type="button" class="btn btn-create-quiz">Create quiz</button>
            </main>

            <!-- Right Column: Quiz Details Card -->
            <aside class="card quiz-details-card">
                <h2 class="card-title">Quiz Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Quiz</span>
                        <span class="details-value">Quiz – Chapter 3</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Topic</span>
                        <span class="details-value">Topic 3</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Classroom</span>
                        <span class="details-value">4 Amanah • Sejarah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Questions</span>
                        <span class="details-value">15</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Status</span>
                        <span class="details-value">Published</span>
                    </div>
                </div>

                <!-- Info Callout -->
                <div class="info-callout">
                    This quiz covers the colonial era, key events, and KBAT-style application questions for review.
                </div>

                <!-- Action Buttons -->
                <div class="details-actions">
                    <button type="button" class="btn btn-primary">Edit quiz</button>
                    <button type="button" class="btn btn-secondary">Assign quiz</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>
