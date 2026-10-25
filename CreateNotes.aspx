﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateNotes.aspx.cs" Inherits="Assignment.CreateNotes" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Note</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="CreateNotes.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="create-quiz-container">
            
            <!-- Header Section -->
            <header class="page-header">
                <div class="header-left">
                    <a href="ManageNotes.aspx" class="back-btn" aria-label="Go Back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <div class="title-group">
                        <h1 class="page-title">Add Note</h1>
                        <p class="page-subtitle">Publish new structured notes, summaries, or reference materials for your students.</p>
                    </div>
                </div>
            </header>

            <!-- Main Grid Layout -->
            <div class="create-quiz-grid">
                
                <main class="card quiz-settings-card">
                    <h2 class="card-title">Note Details</h2>

                    <div class="quiz-form">
                        <!-- Note Title -->
                        <div class="form-group">
                            <label for="txtTitle">Note title</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter note title (e.g. Chapter 1 - Introduction to History)" />
                        </div>

                        <!-- Classroom Dropdown -->
                        <div class="form-group">
                            <label for="ddlClassroom">Classroom</label>
                            <asp:DropDownList ID="ddlClassroom" runat="server" CssClass="form-control" />
                        </div>

                        <!-- File URL / Document Path -->
                        <div class="form-group">
                            <label for="txtFileURL">File URL / Resource Path</label>
                            <asp:TextBox ID="txtFileURL" runat="server" CssClass="form-control" placeholder="https://example.com/notes/ch1.pdf" />
                        </div>

                        <!-- Estimated Reading Duration (Minutes) -->
                        <div class="form-group">
                            <label for="txtDurationMins">Duration (Minutes)</label>
                            <asp:TextBox ID="txtDurationMins" runat="server" CssClass="form-control" TextMode="Number" Text="15" />
                        </div>

                        <!-- Status Dropdown -->
                        <div class="form-group">
                            <label for="ddlStatus">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Published" Value="Published" Selected="True" />
                                <asp:ListItem Text="Draft" Value="Draft" />
                            </asp:DropDownList>
                        </div>

                        <!-- Action Buttons -->
                        <div class="form-actions">
                            <asp:Button ID="btnSubmitNote" runat="server" Text="Add note" CssClass="btn btn-primary" OnClick="btnSubmitNote_Click" />
                            <a href="ManageNotes.aspx" class="btn btn-secondary">Cancel</a>
                        </div>
                    </div>
                </main>

                <aside class="card question-bank-card">
                    <h2 class="card-title">Note Tips</h2>
                    <div class="info-callout">
                        Provide clean external resource links or relative file paths for your PDF/document materials so students can view them directly.
                    </div>
                </aside>

            </div>

        </div>
    </form>
</body>
</html>