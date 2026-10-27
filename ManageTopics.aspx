<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Topics</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="ManageTopics.css">
</head>
<body>

    <div class="topics-container">

        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Manage Topics</h1>
                    <p class="page-subtitle">Organize your lesson structure and map topics to quizzes and notes.</p>
                </div>
            </div>
        </header>

        <div class="topics-content-grid">

            <main class="card topic-list-card">
                <h2 class="card-title">Topic List</h2>

                <div class="topic-items-wrapper">

                    <div class="topic-row">
                        <div class="topic-info">
                            <h3 class="topic-name">Topic 1 – Introduction to history</h3>
                            <p class="topic-meta">3 notes • 1 quiz</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <div class="topic-row">
                        <div class="topic-info">
                            <h3 class="topic-name">Topic 2 – Malay kingdoms</h3>
                            <p class="topic-meta">2 notes • 1 quiz</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <div class="topic-row">
                        <div class="topic-info">
                            <h3 class="topic-name">Topic 3 – Colonial era</h3>
                            <p class="topic-meta">4 notes • 2 quizzes</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <div class="topic-row">
                        <div class="topic-info">
                            <h3 class="topic-name">Topic 4 – Independence</h3>
                            <p class="topic-meta">3 notes • 1 quiz</p>
                        </div>
                        <span class="status-badge draft">Draft</span>
                    </div>

                </div>

                <button type="button" class="btn btn-add-topic">Add topic</button>
            </main>

            <aside class="card topic-details-card">
                <h2 class="card-title">Topic Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Topic</span>
                        <span class="details-value">Topic 3 – Colonial era</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Classroom</span>
                        <span class="details-value">4 Amanah • Sejarah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Status</span>
                        <span class="details-value">Published</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Updated</span>
                        <span class="details-value">Today</span>
                    </div>
                </div>

                <div class="info-callout">
                    This topic covers British and Japanese periods, with notes and quizzes mapped to the current lesson plan.
                </div>

                <div class="details-actions">
                    <button type="button" class="btn btn-primary">Edit topic</button>
                    <button type="button" class="btn btn-secondary">View notes</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>