<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Profile</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Link to external stylesheet -->
    <link rel="stylesheet" href="TeacherProfile.css">
</head>
<body>

    <div class="profile-container">
        
        <!-- Header Section with Back Arrow Button -->
        <header class="profile-header">
            <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
            </a>
            <h1 class="page-title">Teacher Profile</h1>
            <div class="header-spacer"></div>
        </header>

        <!-- Main Content Layout -->
        <div class="profile-content-grid">
            
            <!-- Left Column: Sidebar Card -->
            <aside class="card profile-summary-card">
                <div class="avatar-header">
                    <div class="avatar-circle">CN</div>
                    <div class="user-identity">
                        <h2>Cikgu Nurul</h2>
                    </div>
                </div>

                <div class="meta-details-section">
                    <span class="section-subtitle">ACCOUNT INFO</span>
                    <div class="meta-details-list">
                        <div class="meta-row">
                            <span class="meta-label">User ID</span>
                            <span class="meta-value">—</span>
                        </div>
                        <div class="meta-row">
                            <span class="meta-label">Username</span>
                            <span class="meta-value">—</span>
                        </div>
                        <div class="meta-row">
                            <span class="meta-label">Role</span>
                            <span class="meta-value">Teacher</span>
                        </div>
                        <div class="meta-row">
                            <span class="meta-label">Date Registered</span>
                            <span class="meta-value">January 2026</span>
                        </div>
                        <div class="meta-row">
                            <span class="meta-label">School</span>
                            <span class="meta-value">SMK Taman Melawati</span>
                        </div>
                        <div class="meta-row">
                            <span class="meta-label">Subject</span>
                            <span class="meta-value">Sejarah KSSM</span>
                        </div>
                    </div>
                </div>

                <!-- Upload Photo Area -->
                <div class="upload-photo-container">
                    <span class="upload-label">Profile picture</span>
                    <button type="button" class="btn btn-upload">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                            <polyline points="17 8 12 3 7 8"></polyline>
                            <line x1="12" y1="3" x2="12" y2="15"></line>
                        </svg>
                        Upload photo
                    </button>
                </div>
            </aside>

            <!-- Right Column: Settings Form -->
            <main class="card account-settings-card">
                <h2 class="settings-title">Teacher Profile</h2>
                
                <form class="settings-form" onsubmit="event.preventDefault();">
                    
                    <!-- Row 1: First Name & Last Name -->
                    <div class="form-row-two">
                        <div class="form-group">
                            <label for="firstName">First name</label>
                            <input type="text" id="firstName" class="form-control" value="Nurul" placeholder="Enter first name">
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last name</label>
                            <input type="text" id="lastName" class="form-control" placeholder="Enter last name">
                        </div>
                    </div>

                    <!-- Row 2: Username -->
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" class="form-control" placeholder="Enter username">
                    </div>

                    <!-- Row 3: Email -->
                    <div class="form-group">
                        <label for="email">Email address</label>
                        <input type="email" id="email" class="form-control" value="nurul@ncient.edu.my" placeholder="Enter email address">
                    </div>

                    <!-- Row 4: Role -->
                    <div class="form-group">
                        <label for="role">Role</label>
                        <input type="text" id="role" class="form-control" value="Teacher" placeholder="Enter role">
                    </div>

                    <!-- Row 5: School -->
                    <div class="form-group">
                        <label for="schoolInput">School</label>
                        <input type="text" id="schoolInput" class="form-control" value="SMK Taman Melawati" placeholder="Enter school name">
                    </div>

                    <!-- Sub Section: Security -->
                    <div class="form-section-group">
                        <h3 class="group-subtitle">Security</h3>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-with-button">
                                <input type="password" id="password" class="form-control" value="••••••••" placeholder="Enter password">
                                <button type="button" class="btn btn-inline">Change</button>
                            </div>
                            <span class="field-hint">Use a strong password of at least 8 characters.</span>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save changes</button>
                        <button type="button" class="btn btn-secondary">Discard</button>
                    </div>
                </form>
            </main>

        </div>

    </div>

</body>
</html>