<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.questionpro.dao.QuestionDAO" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session.getAttribute("admin") == null){
        response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
        return;
    }

    QuestionDAO dao = new QuestionDAO();

    int qCount = dao.getQuestionCount();
    int sCount = dao.getStudentCount();
    int rCount = dao.getResultCount();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

body{
    background:#f5f6fa;
}

.sidebar{
    position:fixed;
    left:0;
    top:0;
    width:250px;
    height:100%;
    background:linear-gradient(180deg,#667eea,#764ba2);
    padding-top:20px;
}

.sidebar h3{
    color:white;
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:12px 20px;
    transition:.3s;
}

.sidebar a:hover{
    background:rgba(255,255,255,.2);
}

.main{
    margin-left:250px;
    padding:30px;
}

.card-box{
    border:none;
    border-radius:15px;
    color:white;
    box-shadow:0 5px 20px rgba(0,0,0,.2);
}

</style>

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">

<h3>

<i class="fas fa-graduation-cap"></i>

QuestionPro

</h3>

<a href="dashboard.jsp">
<i class="fas fa-home"></i>
Dashboard
</a>

<a href="addQuestion.jsp">
<i class="fas fa-plus-circle"></i>
Add Question
</a>

<a href="viewQuestions.jsp">
<i class="fas fa-list"></i>
View Questions
</a>

<a href="studentList.jsp">
<i class="fas fa-users"></i>
View Students
</a>

<a href="uploadCSV.jsp">
<i class="fas fa-file-upload"></i>
Upload CSV
</a>

<a href="${pageContext.request.contextPath}/adminLeaderboard">
<i class="fas fa-trophy"></i>
Leaderboard
</a>

<a href="${pageContext.request.contextPath}/adminLogout">
<i class="fas fa-sign-out-alt"></i>
Logout
</a>

</div>

<!-- Main -->

<div class="main">

<div class="mb-4">

<h2>

Welcome,

<%=session.getAttribute("admin")%>

👋

</h2>

<p class="text-muted">

Online Exam Management Dashboard

</p>

</div>

<div class="row">

<div class="col-md-4 mb-4">

<div class="card card-box p-4 bg-primary text-center">

<i class="fas fa-question-circle fa-3x mb-3"></i>

<h2><%=qCount%></h2>

<h5>Total Questions</h5>

</div>

</div>

<div class="col-md-4 mb-4">

<div class="card card-box p-4 bg-success text-center">

<i class="fas fa-user-graduate fa-3x mb-3"></i>

<h2><%=sCount%></h2>

<h5>Total Students</h5>

</div>

</div>

<div class="col-md-4 mb-4">

<div class="card card-box p-4 bg-danger text-center">

<i class="fas fa-chart-line fa-3x mb-3"></i>

<h2><%=rCount%></h2>

<h5>Total Results</h5>

</div>

</div>

</div>

<div class="card shadow border-0">

<div class="card-body">

<h4 class="mb-4">

Quick Actions

</h4>

<div class="row">

<div class="col-md-2 mb-3">

<a href="addQuestion.jsp" class="btn btn-primary w-100">

<i class="fas fa-plus-circle"></i><br>

Add Question

</a>

</div>

<div class="col-md-2 mb-3">

<a href="viewQuestions.jsp" class="btn btn-success w-100">

<i class="fas fa-list"></i><br>

Questions

</a>

</div>

<div class="col-md-2 mb-3">

<a href="studentList.jsp" class="btn btn-dark w-100">

<i class="fas fa-users"></i><br>

Students

</a>

</div>

<div class="col-md-2 mb-3">

<a href="uploadCSV.jsp" class="btn btn-warning w-100">

<i class="fas fa-file-upload"></i><br>

CSV Upload

</a>

</div>

<div class="col-md-2 mb-3">

<a href="${pageContext.request.contextPath}/adminLeaderboard" class="btn btn-info w-100 text-white">

<i class="fas fa-trophy"></i><br>

Leaderboard

</a>

</div>

<div class="col-md-2 mb-3">

<a href="${pageContext.request.contextPath}/adminLogout" class="btn btn-danger w-100">

<i class="fas fa-sign-out-alt"></i><br>

Logout

</a>

</div>

</div>

</div>

</div>

</div>

</body>

</html>