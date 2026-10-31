<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminViewQuiz.aspx.cs" Inherits="Assignment.AdminViewQuiz" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quiz Details</title>
    <link rel="stylesheet" href="AdminViewQuiz.css">
    <link rel="stylesheet" href="index.css">
</head>
<body>
<form id="form1" runat="server">

    <uc:Header ID="HeaderControl" runat="server" />

    <div class="container">

        <div class="page-header">
            <div>
                <h1><asp:Label ID="lblQuizTitle" runat="server" Text="Quiz Title" /></h1>
                <p>Read-only view. You cannot attempt or edit this quiz.</p>
            </div>
            <div>
                <asp:Button ID="btnBack" runat="server" Text="&larr; Back"
                    CssClass="btn" CausesValidation="false"
                    OnClick="btnBack_Click" />
            </div>
        </div>

        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="card empty">
            <asp:Label ID="lblError" runat="server" Text="Quiz not found or an error occurred." />
        </asp:Panel>

        <asp:Panel ID="pnlQuiz" runat="server" CssClass="card">
            
            <div class="quiz-info">
                <div>Class: <strong><asp:Label ID="lblClassName" runat="server" /></strong></div>
                <div>Total Marks: <strong><asp:Label ID="lblTotalMarks" runat="server" /></strong></div>
                <div>Created: <strong><asp:Label ID="lblCreatedDate" runat="server" /></strong></div>
            </div>

            <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
                <ItemTemplate>
                    <div class="question-block">
                        <div class="question-meta">
                            Question <%# Container.ItemIndex + 1 %> &middot; <%# Eval("marks") %> Marks
                        </div>
                        <div class="question-text">
                            <%#: Eval("questionText") %>
                        </div>

                        <ul class="answer-list">
                            <%-- No OnItemDataBound needed here; binding SQL-computed values directly --%>
                            <asp:Repeater ID="rptAnswers" runat="server">
                                <ItemTemplate>
                                    <li class='<%# Eval("LiClass") %>'>
                                        <span><%#: Eval("answerText") %></span>
                                        <asp:Literal ID="litBadge" runat="server" Mode="PassThrough" Text='<%# Eval("BadgeHtml") %>' />
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    <% if (rptQuestions.Items.Count == 0) { %>
                        <div class="empty">No questions have been added to this quiz yet.</div>
                    <% } %>
                </FooterTemplate>
            </asp:Repeater>

        </asp:Panel>
    </div>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>