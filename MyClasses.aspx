<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Classes</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="MyClasses.css">
</head>
<body>

    <div class="classes-container">

        <header class="classes-header">
            <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">

                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
            </a>

            <h1 class="page-title">My Classes</h1>

            <button type="button" class="btn btn-create">Create Classroom</button>
        </header>

        <div class="classes-grid">

            <article class="card classroom-card">
                <div class="card-header">
                    <div class="card-icon-box">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                        </svg>
                    </div>
                    <div class="card-title-group">
                        <h2 class="class-title">4 Amanah • Sejarah</h2>
                        <p class="class-description">Description</p>
                    </div>
                </div>

                <div class="class-stats-list">
                    <div class="stat-row">
                        <span class="stat-label">Students</span>
                        <span class="stat-value">30</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Live sessions</span>
                        <span class="stat-value">2</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Quizzes</span>
                        <span class="stat-value">4</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Notes</span>
                        <span class="stat-value">6</span>
                    </div>
                </div>

                <div class="card-actions-group">
                    <a href="#" class="btn btn-card-primary">View classroom</a>
                    <a href="#" class="btn btn-card-secondary">Edit classroom</a>
                </div>
            </article>

            <article class="card classroom-card">
                <div class="card-header">
                    <div class="card-icon-box">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                        </svg>
                    </div>
                    <div class="card-title-group">
                        <h2 class="class-title">Sejarah Revision</h2>
                        <p class="class-description">Description</p>
                    </div>
                </div>

                <div class="class-stats-list">
                    <div class="stat-row">
                        <span class="stat-label">Students</span>
                        <span class="stat-value">48</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Live sessions</span>
                        <span class="stat-value">1</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Quizzes</span>
                        <span class="stat-value">3</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Notes</span>
                        <span class="stat-value">5</span>
                    </div>
                </div>

                <div class="card-actions-group">
                    <a href="#" class="btn btn-card-primary">View classroom</a>
                    <a href="#" class="btn btn-card-secondary">Edit classroom</a>
                </div>
            </article>

            <article class="card classroom-card">
                <div class="card-header">
                    <div class="card-icon-box">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                        </svg>
                    </div>
                    <div class="card-title-group">
                        <h2 class="class-title">Sejarah KBAT Workshop</h2>
                        <p class="class-description">Description</p>
                    </div>
                </div>

                <div class="class-stats-list">
                    <div class="stat-row">
                        <span class="stat-label">Students</span>
                        <span class="stat-value">24</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Live sessions</span>
                        <span class="stat-value">1</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Quizzes</span>
                        <span class="stat-value">2</span>
                    </div>
                    <div class="stat-row">
                        <span class="stat-label">Notes</span>
                        <span class="stat-value">4</span>
                    </div>
                </div>

                <div class="card-actions-group">
                    <a href="#" class="btn btn-card-primary">View classroom</a>
                    <a href="#" class="btn btn-card-secondary">Edit classroom</a>
                </div>
            </article>

        </div>

    </div>

</body>
</html>