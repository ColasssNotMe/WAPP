<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentQuiz.aspx.cs" Inherits="Assignment.StudentQuiz" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz</title>
     <link rel="stylesheet" href="index.css"/>
     <link rel="stylesheet" href="StudentQuiz.css"/>
</head>
<body>
    <uc:Header ID="HeaderControl" runat="server" />
<section class="session-banner" aria-label="Quiz session information">
      <div>
        <h2>Road to Independence • Class Checkpoint</h2>
        <p>Cikgu Nurul • 4 Amanah • Session code: SEJ-4A • 28 students</p>
      </div>
      <span class="connection"><span class="status-dot"></span> Connected</span>
    </section>

    <div class="quiz-layout">
      <section class="question-card">
        <div class="question-topline">
          <span class="question-badge">Question 3 of 10</span>
          <div class="timer" aria-label="Time remaining">
            <span class="timer-icon">◷</span>
            <strong id="timer">00:18</strong>
            <small>seconds left</small>
          </div>
        </div>

        <div class="progress-track" aria-label="Quiz progress">
          <div class="progress-fill question-progress"></div>
        </div>

        <h2 class="question-title">Where did Tunku Abdul Rahman announce the date of independence after returning from London in 1956?</h2>
        <p class="instruction">Choose one answer, then send it before the countdown ends.</p>

        <form id="answer-form">
          <fieldset class="answer-list">
            <legend class="visually-hidden">Choose one answer</legend>
            <label class="answer-option">
              <input type="radio" name="answer" value="A">
              <span class="option-letter">A</span>
              <span class="option-text">Stadium Merdeka, Kuala Lumpur</span>
              <span class="radio-indicator"></span>
            </label>
            <label class="answer-option selected">
              <input type="radio" name="answer" value="B" checked>
              <span class="option-letter">B</span>
              <span class="option-text">Padang Bandar Hilir, Melaka</span>
              <span class="radio-indicator"></span>
            </label>
            <label class="answer-option">
              <input type="radio" name="answer" value="C">
              <span class="option-letter">C</span>
              <span class="option-text">Istana Negara, Kuala Lumpur</span>
              <span class="radio-indicator"></span>
            </label>
            <label class="answer-option">
              <input type="radio" name="answer" value="D">
              <span class="option-letter">D</span>
              <span class="option-text">Royal Albert Hall, London</span>
              <span class="radio-indicator"></span>
            </label>
          </fieldset>

          <div class="submit-row">
            <p id="answer-status" class="answer-status">B selected • Not submitted yet</p>
            <button class="submit-button" type="submit"><span aria-hidden="true">➤</span> Send answer</button>
          </div>
        </form>
      </section>

      <aside class="sidebar">
        <section class="side-card live-progress">
          <h3>Your Live Progress</h3>
          <p class="big-number">2 <span>/ 10</span></p>
          <p class="side-caption">Questions answered</p>
          <div class="progress-track"><div class="progress-fill answered-progress"></div></div>
          <div class="side-divider"></div>
          <p class="side-note">Your score will appear when the teacher ends the quiz.</p>
        </section>

        <section class="side-card class-responses">
          <div class="side-heading">
            <h3>Class Responses</h3>
            <span aria-hidden="true" class="people-icon">♧</span>
          </div>
          <p class="big-number">19 <span>/ 28</span></p>
          <div class="progress-track"><div class="progress-fill responses-progress"></div></div>
          <p class="side-note">Students have sent an answer. Results stay hidden until the question closes.</p>
        </section>

        <section class="side-card teacher-card">
          <h3>Cikgu Nurul says</h3>
          <p>“Think back to the final event on our timeline. Read each location carefully before you answer.”</p>
        </section>
      </aside>
    </div>

    <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>
