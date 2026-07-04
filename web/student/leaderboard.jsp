<%-- 
    Document   : leaderboard
    Created on : 12 Jun 2026, 12:24:55 pm
    Author     : NAGA ARJUN
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    if(session.getAttribute("student") == null && session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/student/studentLogin.jsp");
        return;
    }
    List<Map<String, Object>> leaderboard = (List<Map<String, Object>>) request.getAttribute("leaderboard");
    if(leaderboard == null) leaderboard = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Leaderboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .navbar { background: linear-gradient(135deg, #667eea, #764ba2) !important; }
        .card { border-radius: 15px; border: none; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .table th { background: linear-gradient(135deg, #667eea, #764ba2); color: white; }
        .rank-1 { background: #ffd700 !important; }
        .rank-2 { background: #c0c0c0 !important; }
        .rank-3 { background: #cd7f32 !important; }
        .trophy-1 { color: #ffd700; }
        .trophy-2 { color: #c0c0c0; }
        .trophy-3 { color: #cd7f32; }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark mb-4">
        <div class="container">
            <span class="navbar-brand">
                <i class="fas fa-trophy"></i> Leaderboard
            </span>
            <% if(session.getAttribute("student") != null) { %>
            <a href="${pageContext.request.contextPath}/exam" class="btn btn-light btn-sm">
                <i class="fas fa-redo"></i> Take Exam
            </a>
            <% } else { %>
            <a href="dashboard.jsp" class="btn btn-light btn-sm">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <% } %>
        </div>
    </nav>

    <div class="container">
        <div class="card p-4">
            <h4 class="text-center mb-4">
                <i class="fas fa-crown text-warning"></i> Top 10 Students
            </h4>
            <div class="table-responsive">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Student Name</th>
                            <th>Score</th>
                            <th>Total</th>
                            <th>Percentage</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int rank = 1; for(Map<String, Object> row : leaderboard) {
                            int sc = (int) row.get("score");
                            int tot = (int) row.get("total");
                            int pct = tot > 0 ? (sc * 100) / tot : 0;
                        %>
                        <tr class="<%= rank == 1 ? "rank-1" : rank == 2 ? "rank-2" : rank == 3 ? "rank-3" : "" %>">
                            <td>
                                <% if(rank == 1) { %><i class="fas fa-trophy trophy-1"></i>
                                <% } else if(rank == 2) { %><i class="fas fa-trophy trophy-2"></i>
                                <% } else if(rank == 3) { %><i class="fas fa-trophy trophy-3"></i>
                                <% } else { %><%= rank %>
                                <% } %>
                            </td>
                            <td><strong><%= row.get("name") %></strong></td>
                            <td><%= sc %></td>
                            <td><%= tot %></td>
                            <td>
                                <div class="progress" style="height:15px; border-radius:8px;">
                                    <div class="progress-bar bg-success" style="width:<%= pct %>%">
                                        <%= pct %>%
                                    </div>
                                </div>
                            </td>
                            <td><small><%= row.get("examDate") %></small></td>
                        </tr>
                        <% rank++; } %>
                        <% if(leaderboard.isEmpty()) { %>
                        <tr><td colspan="6" class="text-muted">No results yet!</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>