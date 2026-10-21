<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminQuizManagement.aspx.cs" Inherits="Assignment.AdminQuizManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quiz Management | Ncient</title>
      <link rel="stylesheet" href="AdminQuizManagement.css">
  <link rel="stylesheet" href="index.css">
</head>
<body>
    <uc:Header ID="HeaderControl" runat="server" />
  <main class="dashboard">
    <header class="page-header">
      <div>
        <h1>Quiz Management</h1>
        <p>Review, publish, and manage Sejarah quizzes across all teachers and classrooms.</p>
      </div>
      <button class="primary-button" type="button">Create Quiz +</button>
    </header>

    <section class="content-grid" aria-label="Quiz library and details">
      <section class="panel">
        <h2 class="panel-heading">Quiz library</h2>
        <p class="panel-description">64 quizzes · 48 published · 16 drafts</p>

        <div class="tab-list" role="tablist">
          <button class="tab" type="button" role="tab" aria-selected="true">Quizzes</button>
          <button class="tab" type="button" role="tab" aria-selected="false">Questions</button>
        </div>

        <div class="filter-row">
          <label class="search-field">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
            <input type="search" placeholder="Search quiz title" aria-label="Search quiz title" />
          </label>
          <button class="select-button" type="button">
            Status: All
            <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m6 9 6 6 6-6"/></svg>
          </button>
        </div>

        <div class="table-wrap">
          <table class="data-table">
            <thead>
              <tr><th>Quiz Title</th><th>Category</th><th>Topic</th><th>Created By</th><th>Number of Questions</th><th>Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
              <tr aria-selected="true"><td class="quiz-title">Kebangkitan Nasionalisme</td><td>Tingkatan 4</td><td class="quiz-topic">Nasionalisme</td><td>Siti Hajar</td><td class="quiz-count">20</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Perlembagaan Persekutuan</td><td>Tingkatan 5</td><td class="quiz-topic">Perlembagaan</td><td>Ahmad Farid</td><td class="quiz-count">15</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Pembentukan Malaysia</td><td>Tingkatan 5</td><td class="quiz-topic">Pembentukan Malaysia</td><td>Siti Hajar</td><td class="quiz-count">20</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Warisan Negara Bangsa</td><td>Tingkatan 4</td><td class="quiz-topic">Kesultanan Melayu Melaka</td><td>Ahmad Farid</td><td class="quiz-count">15</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Penentangan Masyarakat Tempatan</td><td>Tingkatan 3</td><td class="quiz-topic">Tokoh Pejuang Tempatan</td><td>Siti Hajar</td><td class="quiz-count">2</td><td class="status status--draft">Draft</td><td class="row-actions"><a href="#">Edit</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Sistem Demokrasi Berparlimen</td><td>Tingkatan 5</td><td class="quiz-topic">—</td><td>Ahmad Farid</td><td class="quiz-count">10</td><td class="status status--draft">Draft</td><td class="row-actions"><a href="#">Edit</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Malayan Union 1946</td><td>Tingkatan 4</td><td class="quiz-topic">Malayan Union</td><td>Siti Hajar</td><td class="quiz-count">12</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="quiz-title">Kemerdekaan Negara</td><td>Tingkatan 4</td><td class="quiz-topic">Kemerdekaan</td><td>Ahmad Farid</td><td class="quiz-count">18</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
            </tbody>
          </table>
        </div>

        <div class="pagination">
          <span class="pagination-note">Showing 1–8 of 64 quizzes</span>
          <div class="pagination-controls">
            <button class="page-button" type="button">Previous</button>
            <button class="page-button" type="button" aria-current="page">1</button>
            <button class="page-button" type="button">Next</button>
          </div>
        </div>
      </section>

      <aside class="panel">
        <h2 class="panel-heading">Quiz Details</h2>
        <dl class="detail-list">
          <dt>Quiz</dt><dd>Quiz – Chapter 3</dd>
          <dt>Teacher</dt><dd>Cikgu Nurul</dd>
          <dt>Form</dt><dd>Form 4</dd>
          <dt>Classroom</dt><dd>4 Amanah • Sejarah</dd>
          <dt>Questions</dt><dd>15</dd>
          <dt>Status</dt><dd class="status--published">Published</dd>
        </dl>
        <p class="detail-note">Covers world conflicts and the Japanese occupation in our country, including KBAT application questions.</p>
        <div class="detail-actions">
          <button class="primary-button" type="button">Edit quiz</button>
          <button class="secondary-button" type="button">Unpublish quiz</button>
        </div>
      </aside>
    </section>
  </main>
    <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>

