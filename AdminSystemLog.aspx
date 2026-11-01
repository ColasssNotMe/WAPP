<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSystemLog.aspx.cs" Inherits="Assignment.AdminSystemLog" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>System Activity Logs</title>
    <link rel="stylesheet" href="AdminSystemLog.css">
    <link rel="stylesheet" href="index.css">
</head>
<body>
<form id="form1" runat="server">

    <uc:Header ID="HeaderControl" runat="server" />

    <div class="container">

        <div class="page-header">
            <div>
                <h1>System Activity Log</h1>
                <p>Monitor all system activities and events across the platform.</p>
            </div>
            <span class="count-pill" id="totalLogs" runat="server">0 logs</span>
        </div>

        <div class="card">
            
            <div class="toolbar">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" 
                    placeholder="Search by description..." />
                
                <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn primary" 
                    OnClick="btnSearch_Click" CausesValidation="false" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" 
                    OnClick="btnReset_Click" CausesValidation="false" />
            </div>

            <div class="table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 220px;">Time</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptLogs" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td style="white-space: nowrap; color: var(--secondary-color);">
                                        <%# Convert.ToDateTime(Eval("createdAt")).ToString("dd MMM yyyy, hh:mm tt") %>
                                    </td>
                                    <td>
                                        <%#: Eval("description") %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <% if (rptLogs.Items.Count == 0) { %>
                                    <tr>
                                        <td colspan="2" class="empty">No activity logs found.</td>
                                    </tr>
                                <% } %>
                            </FooterTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <span class="pagination-note">
                    Showing 
                    <asp:Label ID="lblShowing" runat="server" Text="0" /> 
                    to 
                    <asp:Label ID="lblEndRecord" runat="server" Text="0" /> 
                    of 
                    <asp:Label ID="lblTotalRecords" runat="server" Text="0" /> 
                    logs
                </span>
                
                <div class="pagination-controls">
                    <asp:Button ID="btnPrevPage" runat="server" Text="&larr; Prev" 
                        CssClass="page-btn" OnClick="btnPrevPage_Click" CausesValidation="false" />
                    
                    <asp:Label ID="lblPageInfo" runat="server" CssClass="page-info" Text="Page 1 of 1" />
                    
                    <asp:Button ID="btnNextPage" runat="server" Text="Next &rarr;" 
                        CssClass="page-btn" OnClick="btnNextPage_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>