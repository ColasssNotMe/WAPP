<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Quiz</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="CreateQuiz.css">
</head>
<body>

    <div class="create-quiz-container">
        
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
                    <h1 class="page-title">Create Quiz</h1>
                    <p class="page-subtitle">Build a new quiz and add questions for your students to complete.</p>
                </div>
            </div>
        </header>

        <!-- Main Grid Layout -->
        <div class="create-quiz-grid">
            
            <!-- Left Column: Quiz Settings Card -->
            <main class="card quiz-settings-card">
                <h2 class="card-title">Quiz Settings</h2>

                <form class="quiz-form" onsubmit="event.preventDefault();">
                    
                    <!-- Quiz Title -->
                    <div class="form-group">
                        <label for="quizTitle">Quiz title</label>
                        <input type="text" id="quizTitle" class="form-control" value="Quiz – Chapter 4" placeholder="Enter quiz title">
                    </div>

                    <!-- Topic -->
                    <div class="form-group">
                        <label for="quizTopic">Topic</label>
                        <input type="text" id="quizTopic" class="form-control" value="Topic 4 - Independence" placeholder="Select or enter topic">
                    </div>

                    <!-- Classroom -->
                    <div class="form-group">
                        <label for="quizClassroom">Classroom</label>
                        <input type="text" id="quizClassroom" class="form-control" value="4 Amanah • Sejarah" placeholder="Select classroom">
                    </div>

                    <!-- Instructions -->
                    <div class="form-group">
                        <label for="quizInstructions">Instructions</label>
                        <textarea id="quizInstructions" class="form-control text-area" rows="3" placeholder="Enter quiz instructions...">Complete all questions. Use the notes and live session materials as reference.</textarea>
                    </div>

                    <!-- Action Buttons -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Create quiz</button>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">Cancel</button>
                    </div>

                </form>
            </main>

            <!-- Right Column: Question Bank Card -->
            <aside class="card question-bank-card">
                <h2 class="card-title">Question Bank</h2>

                <div class="question-list">
                    <div class="question-row">
                        <span class="question-label">Question 1</span>
                        <span class="question-type">Multiple choice</span>
                    </div>
                    <div class="question-row">
                        <span class="question-label">Question 2</span>
                        <span class="question-type">Short answer</span>
                    </div>
                    <div class="question-row">
                        <span class="question-label">Question 3</span>
                        <span class="question-type">True / False</span>
                    </div>
                    <div class="question-row">
                        <span class="question-label">Question 4</span>
                        <span class="question-type">Multiple choice</span>
                    </div>
                </div>

                <!-- Info Callout -->
                <div class="info-callout">
                    Questions can be added, reordered, or imported from existing quizzes later.
                </div>

                <!-- Add Question Button -->
                <button type="button" class="btn btn-add-question">Add question</button>
            </aside>

        </div>

    </div>

</body>
</html>