<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminClassroomManagement.aspx.cs" Inherits="Assignment.AdminClassroomManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Classroom Management</title>
    <link rel="stylesheet" href="AdminClassroomManagement.css">
    <link rel="stylesheet" href="index.css">
</head>
<body>
<uc:Header ID="HeaderControl" runat="server" />
<div class="container">

  <div class="page-header">
    <div>
      <h1>Classroom Management</h1>
      <p>Oversee classrooms, teacher assignments, enrolment, and classroom access codes.</p>
    </div>
    <span class="count-pill" id="totalClassrooms" runat="server">142 classrooms</span>
  </div>

  <main class="layout">

    <!-- Directory -->
    <section class="card" aria-labelledby="dir-title">
      <h2 id="dir-title">Classroom directory</h2>
      <p class="meta">24 classrooms · 22 active · 2 inactive</p>

      <div class="tabs" role="tablist">
        <button class="tab" role="tab" aria-selected="true">Classrooms</button>
        <button class="tab" role="tab" aria-selected="false">Live Sessions</button>
      </div>

      <div class="toolbar">
        <label class="search">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
          <input type="search" placeholder="Search classroom or teacher" aria-label="Search classroom or teacher">
        </label>
        <button class="select" type="button">
          Status: All
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m6 9 6 6 6-6"/></svg>
        </button>
      </div>

      <div class="table-wrap">
        <table id="classroomTable">
          <thead>
            <tr>
              <th>Classroom Name</th>
              <th>Teacher</th>
              <th>Student Count</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody id="rows">
            <asp:Repeater ID="rptClassrooms" runat="server">
              <ItemTemplate>
                <tr>
                  <td class="name"><%#: Eval("ClassName") %></td>
                  <td class="teacher"><%#: Eval("TeacherName") %></td>
                  <td><%#: Eval("StudentCount") %></td>
                  <td class='status <%# Eval("Status").ToString().ToLower() %>'><%#: Eval("Status") %></td>
                  <td class="actions">
                    <a href='AdminClassroomDetails.aspx?classID=<%# Eval("ClassID") %>'>View</a>
                    <span class="dot"> · </span>
                    <button type="button" aria-label="More actions">•••</button>
                  </td>
                </tr>
              </ItemTemplate>
            </asp:Repeater>
          </tbody>
        </table>
      </div>

      <div class="table-footer">
        <span>Showing 1–7 of 24 classrooms</span>
        <div class="pager">
          <button class="btn-page" type="button">Previous</button>
          <button class="btn-page current" type="button" aria-current="page">1</button>
          <button class="btn-page" type="button">Next</button>
        </div>
      </div>
    </section>

    <!-- Details -->
    <aside class="card details" aria-labelledby="det-title">
      <h2 id="det-title">Classroom Details</h2>
      <dl>
        <div class="row"><dt>Classroom</dt><dd>4 Amanah</dd></div>
        <div class="row"><dt>Teacher</dt><dd>Cikgu Nurul</dd></div>
        <div class="row"><dt>School</dt><dd>SMK Taman Melawati</dd></div>
        <div class="row"><dt>Subject</dt><dd>Form 4 • Sejarah KSSM</dd></div>
        <div class="row"><dt>Students</dt><dd>30</dd></div>
        <div class="row"><dt>Invite code</dt><dd>AMANAH26</dd></div>
        <div class="row"><dt>Status</dt><dd class="ok">Active</dd></div>
      </dl>
      <p class="note">12 quizzes and 18 learning materials are assigned. Reset the invite code if classroom access needs to be restricted.</p>
      <div class="btn-row">
        <button class="btn primary" type="button">Edit classroom</button>
        <button class="btn danger" type="button">Archive class</button>
      </div>
    </aside>

  </main>
</div>
    <uc:Footer ID="FooterControl" runat="server" />
</body>
</html>

