<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard</title>
    <!-- Google Fonts & Lucide Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- Link to external stylesheet -->
    <link rel="stylesheet" href="TeacherDashboard.css">
</head>
<body>

    <div class="dashboard-container">
        
        <!-- Header Section -->
        <header class="dashboard-header">
            <div class="header-title-group">
                <h1>Teacher Dashboard</h1>
                <p>Welcome back, <span>Cikgu Nurul</span>. Here's what's happening in your classrooms today.</p>
            </div>
            <div class="active-classrooms-badge">
                <span class="status-dot"></span>
                <span>3 active classrooms</span>
            </div>
        </header>

        <!-- Metric Cards Grid -->
        <section class="metrics-grid">
            <!-- Card 1: Students -->
            <div class="metric-card">
                <div class="metric-card-header">
                    <span class="metric-label">Students</span>
                    <div class="metric-icon-box">
                        <i data-lucide="users" style="width: 18px; height: 18px;"></i>
                    </div>
                </div>
                <div class="metric-value">102</div>
                <div class="metric-subtitle">Across all classes</div>
            </div>

            <!-- Card 2: Live sessions -->
            <div class="metric-card gold-card">
                <div class="metric-card-header">
                    <span class="metric-label">Live sessions</span>
                    <div class="metric-icon-box">
                        <i data-lucide="video" style="width: 18px; height: 18px;"></i>
                    </div>
                </div>
                <div class="metric-value">3</div>
                <div class="metric-subtitle">
                    <span class="metric-subtitle-dot"></span> Scheduled this week
                </div>
            </div>

            <!-- Card 3: Quizzes -->
            <div class="metric-card red-card">
                <div class="metric-card-header">
                    <span class="metric-label">Quizzes</span>
                    <div class="metric-icon-box">
                        <i data-lucide="help-circle" style="width: 18px; height: 18px;"></i>
                    </div>
                </div>
                <div class="metric-value">12</div>
                <div class="metric-subtitle">Ready for review</div>
            </div>

            <!-- Card 4: Notes -->
            <div class="metric-card green-card">
                <div class="metric-card-header">
                    <span class="metric-label">Notes</span>
                    <div class="metric-icon-box">
                        <i data-lucide="file-text" style="width: 18px; height: 18px;"></i>
                    </div>
                </div>
                <div class="metric-value">18</div>
                <div class="metric-subtitle">Published this month</div>
            </div>
        </section>

        <!-- Main Content Grid -->
        <div class="main-content-grid">
            
            <!-- Left Column: Activity Feed -->
            <div class="left-column">
                
                <!-- Material Section Card -->
                <div class="dashboard-section-card">
                    <div class="section-header">
                        <h2 class="section-title">Material</h2>
                        <span class="section-tag">Today</span>
                    </div>
                    <div class="activity-list">
                        <!-- Activity 1 -->
                        <div class="activity-item">
                            <div class="activity-icon-wrapper">
                                <i data-lucide="book-open" style="width: 18px; height: 18px;"></i>
                            </div>
                            <div class="activity-details">
                                <div class="activity-title">Published Chapter 3 notes</div>
                                <div class="activity-meta">
                                    <span>4 Amanah</span>
                                    <span class="meta-divider">•</span>
                                    <span>10:20 AM</span>
                                </div>
                            </div>
                        </div>

                        <!-- Activity 2 -->
                        <div class="activity-item">
                            <div class="activity-icon-wrapper">
                                <i data-lucide="clipboard-check" style="width: 18px; height: 18px;"></i>
                            </div>
                            <div class="activity-details">
                                <div class="activity-title">Quiz – Chapter 2 is ready</div>
                                <div class="activity-meta">
                                    <span>Sejarah Revision</span>
                                    <span class="meta-divider">•</span>
                                    <span>9:45 AM</span>
                                </div>
                            </div>
                        </div>

                        <!-- Activity 3 -->
                        <div class="activity-item">
                            <div class="activity-icon-wrapper">
                                <i data-lucide="user-plus" style="width: 18px; height: 18px;"></i>
                            </div>
                            <div class="activity-details">
                                <div class="activity-title">5 new students joined</div>
                                <div class="activity-meta">
                                    <span>Sejarah KBAT Workshop</span>
                                    <span class="meta-divider">•</span>
                                    <span>Yesterday</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quiz Section Card -->
                <div class="dashboard-section-card">
                    <div class="section-header">
                        <h2 class="section-title">Quiz</h2>
                        <span class="section-tag">Today</span>
                    </div>
                    <div class="activity-list">
                        <!-- Activity 1 -->
                        <div class="activity-item">
                            <div class="activity-icon-wrapper">
                                <i data-lucide="book-open" style="width: 18px; height: 18px;"></i>
                            </div>
                            <div class="activity-details">
                                <div class="activity-title">Published Chapter 3 notes</div>
                                <div class="activity-meta">
                                    <span>4 Amanah</span>
                                    <span class="meta-divider">•</span>
                                    <span>10:20 AM</span>
                                </div>
                            </div>
                        </div>

                        <!-- Activity 2 -->
                        <div class="activity-item">
                            <div class="activity-icon-wrapper">
                                <i data-lucide="clipboard-check" style="width: 18px; height: 18px;"></i>
                            </div>
                            <div class="activity-details">
                                <div class="activity-title">Quiz – Chapter 2 is ready</div>
                                <div class="activity-meta">
                                    <span>Sejarah Revision</span>
                                    <span class="meta-divider">•</span>
                                    <span>9:45 AM</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Right Column: Classroom Summary Card -->
            <div class="right-column">
                <div class="dashboard-section-card sticky-card">
                    <div class="section-header" style="border-bottom: none; padding-bottom: 0; margin-bottom: 12px;">
                        <h2 class="section-title">Classroom Summary</h2>
                    </div>
                    <div class="summary-list">
                        <div class="summary-row">
                            <span class="class-name">4 Amanah</span>
                            <span class="student-count">30 <span class="student-label">students</span></span>
                        </div>
                        <div class="summary-row">
                            <span class="class-name">Sejarah Revision</span>
                            <span class="student-count">48 <span class="student-label">students</span></span>
                        </div>
                        <div class="summary-row">
                            <span class="class-name">Sejarah KBAT Workshop</span>
                            <span class="student-count">24 <span class="student-label">students</span></span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <!-- Render Icons Script -->
    <script>
        lucide.createIcons();
    </script>
</body>
</html>