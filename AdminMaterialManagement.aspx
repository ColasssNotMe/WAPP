<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminMaterialManagement.aspx.cs" Inherits="Assignment.AdminMaterialManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Learning Materials Management | Ncient</title>
      <link rel="stylesheet" href="AdminMaterialManagement.css">
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <uc:Header ID="HeaderControl" runat="server" />
  <main class="dashboard">
    <header class="page-header">
      <div>
        <h1>Learning Materials Management</h1>
        <p>Manage learning notes, revision resources, and teacher uploads across the Sejarah syllabus.</p>
      </div>
      <span class="overview-pill">218 materials</span>
    </header>

    <section class="content-grid" aria-label="Material library and details">
      <section class="panel">
        <h2 class="panel-heading">Material library</h2>
        <p class="panel-description">90 materials · 72 published · 18 drafts</p>


        <div class="filter-row">
          <label class="search-field">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
            <input type="search" placeholder="Search material title" aria-label="Search material title" />
          </label>
          <button class="select-button" type="button">
            Category: All
            <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m6 9 6 6 6-6"/></svg>
          </button>
        </div>

        <div class="table-wrap">
          <table class="data-table">
            <thead>
              <tr><th>Title</th><th>Category</th><th>Optional Topic</th><th>Created By</th><th>Last Updated</th><th>Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
              <tr aria-selected="true"><td class="material-title">Nota Kebangkitan Nasionalisme</td><td>Tingkatan 4</td><td class="material-topic">Nasionalisme</td><td>Siti Hajar</td><td class="nowrap">14 Oct 2026</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Asas Perlembagaan Persekutuan</td><td>Tingkatan 5</td><td class="material-topic">Perlembagaan</td><td>Ahmad Farid</td><td class="nowrap">13 Oct 2026</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Pembentukan Malaysia: Garis Masa</td><td>Tingkatan 5</td><td class="material-topic">Pembentukan Malaysia</td><td>Siti Hajar</td><td class="nowrap">14 Oct 2026</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Warisan Kesultanan Melayu Melaka</td><td>Tingkatan 4</td><td class="material-topic">Kesultanan Melayu Melaka</td><td>Ahmad Farid</td><td class="nowrap">11 Oct 2026</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Sistem Demokrasi Berparlimen</td><td>Tingkatan 5</td><td class="material-topic">—</td><td>Ahmad Farid</td><td class="nowrap">14 Oct 2026</td><td class="status status--draft">Draft</td><td class="row-actions"><a href="#">Edit</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Penentangan Dol Said di Naning</td><td>Tingkatan 3</td><td class="material-topic">Tokoh Pejuang Tempatan</td><td>Siti Hajar</td><td class="nowrap">10 Oct 2026</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Ringkasan Malayan Union</td><td>Tingkatan 4</td><td class="material-topic">Malayan Union</td><td>Siti Hajar</td><td class="nowrap">09 Oct 2026</td><td class="status status--published">Published</td><td class="row-actions"><a href="#">View</a> · <span class="more">•••</span></td></tr>
              <tr><td class="material-title">Latihan Kemerdekaan Negara</td><td>Tingkatan 4</td><td class="material-topic">Kemerdekaan</td><td>Ahmad Farid</td><td class="nowrap">08 Oct 2026</td><td class="status status--draft">Draft</td><td class="row-actions"><a href="#">Edit</a> · <span class="more">•••</span></td></tr>
            </tbody>
          </table>
        </div>

        <div class="pagination">
          <span class="pagination-note">Showing 1–8 of 90 materials</span>
          <div class="pagination-controls">
            <button class="page-button" type="button">Previous</button>
            <button class="page-button" type="button" aria-current="page">1</button>
            <button class="page-button" type="button">Next</button>
          </div>
        </div>
      </section>

      <aside class="panel">
        <h2 class="panel-heading">Material Details</h2>
        <dl class="detail-list">
          <dt>Material</dt><dd>Pendudukan Jepun</dd>
          <dt>Teacher</dt><dd>Cikgu Nurul</dd>
          <dt>Form / Chapter</dt><dd>Form 4 • Chapter 3</dd>
          <dt>Format</dt><dd>PDF • 2.4 MB</dd>
          <dt>Uploaded</dt><dd>2 Oct 2026</dd>
          <dt>Status</dt><dd class="status--published">Published</dd>
        </dl>
        <p class="detail-note">Timeline of the Japanese occupation, key events, and revision notes. Available to students in 4 Amanah.</p>
        <div class="detail-actions">
          <button class="primary-button" type="button">View material</button>
          <button class="secondary-button" type="button">Unpublish</button>
        </div>
      </aside>
    </section>
  </main>
  <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>

