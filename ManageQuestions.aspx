<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Questions</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="ManageQuestions.css">
</head>
<body>

    <div class="questions-container">
        
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
                    <h1 class="page-title">Manage Questions</h1>
                    <p class="page-subtitle">Review, edit, and reorder questions for Quiz – Chapter 3.</p>
                </div>
            </div>
        </header>

        <!-- Main Grid Layout -->
        <div class="questions-content-grid">
            
            <!-- Left Column: Question List Card -->
            <main class="card question-list-card">
                <h2 class="card-title">Question List</h2>

                <div class="question-items-wrapper">
                    
                    <!-- Question 1 -->
                    <div class="question-row">
                        <div class="question-info">
                            <h3 class="question-name">Question 1</h3>
                            <p class="question-meta">Multiple choice • 2 points</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Question 2 -->
                    <div class="question-row">
                        <div class="question-info">
                            <h3 class="question-name">Question 2</h3>
                            <p class="question-meta">Short answer • 3 points</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Question 3 -->
                    <div class="question-row">
                        <div class="question-info">
                            <h3 class="question-name">Question 3</h3>
                            <p class="question-meta">True / False • 1 point</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Question 4 -->
                    <div class="question-row">
                        <div class="question-info">
                            <h3 class="question-name">Question 4</h3>
                            <p class="question-meta">Multiple choice • 2 points</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                </div>

                <!-- Add Question Button -->
                <button type="button" class="btn btn-add-question">Add question</button>
            </main>

            <!-- Right Column: Question Details Card -->
            <aside class="card question-details-card">
                <h2 class="card-title">Question Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Question</span>
                        <span class="details-value">Question 1</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Type</span>
                        <span class="details-value">Multiple choice</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Points</span>
                        <span class="details-value">2</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Status</span>
                        <span class="details-value">Published</span>
                    </div>
                </div>

                <!-- Info Callout -->
                <div class="info-callout">
                    This question assesses understanding of the colonial era and its impact on the Malay states.
                </div>

                <!-- Action Buttons -->
                <div class="details-actions">
                    <button type="button" class="btn btn-primary">Edit question</button>
                    <button type="button" class="btn btn-secondary">Delete question</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>