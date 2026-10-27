<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create / Edit Question</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="CreateEditQuestions.css">
</head>
<body>

    <div class="question-container">

        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Create / Edit Question</h1>
                    <p class="page-subtitle">Build a new question or update an existing one for Quiz – Chapter 3.</p>
                </div>
            </div>
        </header>

        <div class="question-content-grid">

            <main class="card question-settings-card">
                <h2 class="card-title">Question Settings</h2>

                <form class="question-form" onsubmit="event.preventDefault();">

                    <div class="form-group">
                        <label for="questionType">Question type</label>
                        <input type="text" id="questionType" class="form-control" value="Multiple choice" placeholder="Select question type">
                    </div>

                    <div class="form-group">
                        <label for="questionText">Question text</label>
                        <textarea id="questionText" class="form-control text-area" rows="3" placeholder="Enter question text...">What was the main impact of British rule on the Malay states during the colonial era?</textarea>
                    </div>

                    <div class="form-group">
                        <label for="points">Points</label>
                        <input type="number" id="points" class="form-control" value="2" placeholder="Enter points">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save question</button>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">Cancel</button>
                    </div>

                </form>
            </main>

            <aside class="card options-card">
                <h2 class="card-title">Options</h2>

                <div class="options-list">
                    <div class="option-row">
                        <span class="option-label">Option A</span>
                        <span class="option-value">Economic growth</span>
                    </div>
                    <div class="option-row">
                        <span class="option-label">Option B</span>
                        <span class="option-value">Administrative control</span>
                    </div>
                    <div class="option-row">
                        <span class="option-label">Option C</span>
                        <span class="option-value">Cultural exchange</span>
                    </div>
                    <div class="option-row">
                        <span class="option-label">Option D</span>
                        <span class="option-value">Military expansion</span>
                    </div>
                </div>

                <div class="info-callout">
                    Mark Option B as the correct answer for this multiple-choice question.
                </div>

                <button type="button" class="btn btn-add-option">Add option</button>
            </aside>

        </div>

    </div>

</body>
</html>
