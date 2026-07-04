<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session == null || session.getAttribute("admin") == null){
        response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Upload CSV</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      rel="stylesheet">

<style>

body{
    background:#f4f6f9;
}

.sidebar{
    width:250px;
    height:100vh;
    position:fixed;
    left:0;
    top:0;
    background:linear-gradient(180deg,#667eea,#764ba2);
    padding-top:20px;
}

.sidebar h4{
    color:white;
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:12px 20px;
}

.sidebar a:hover{
    background:rgba(255,255,255,.2);
    border-radius:8px;
}

.main{
    margin-left:260px;
    padding:30px;
}

.card{
    border:none;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.1);
}

.upload-box{
    border:2px dashed #0d6efd;
    border-radius:10px;
    padding:35px;
    text-align:center;
    background:#f8f9fa;
}

</style>

</head>

<body>

<div class="sidebar">

<h4>

<i class="fas fa-graduation-cap"></i>

QuestionPro

</h4>

<a href="<%=request.getContextPath()%>/admin/dashboard.jsp">
<i class="fas fa-home"></i>
Dashboard
</a>

<a href="<%=request.getContextPath()%>/admin/addQuestion.jsp">
<i class="fas fa-plus-circle"></i>
Add Question
</a>

<a href="<%=request.getContextPath()%>/admin/viewQuestions.jsp">
<i class="fas fa-list"></i>
View Questions
</a>

<a href="<%=request.getContextPath()%>/admin/uploadCSV.jsp">
<i class="fas fa-upload"></i>
Upload CSV
</a>

<a href="<%=request.getContextPath()%>/adminLogout">
<i class="fas fa-sign-out-alt"></i>
Logout
</a>

</div>

<div class="main">

<div class="card p-4">

<h3 class="mb-4">

<i class="fas fa-file-csv text-primary"></i>

Upload Questions using CSV

</h3>

<%
if(request.getParameter("uploaded") != null){
%>

<div class="alert alert-success">
CSV uploaded successfully.
</div>

<%
}
%>

<%
if(request.getParameter("error") != null){
%>

<div class="alert alert-danger">
CSV upload failed.
</div>

<%
}
%>

<div class="upload-box mb-4">

<i class="fas fa-file-csv fa-4x text-primary mb-3"></i>

<h5>CSV Format</h5>

<p>

question_text,
option_a,
option_b,
option_c,
option_d,
correct_answer,
category

</p>

<hr>

<p class="text-muted">

First row should contain column names.

</p>

<p class="text-muted">

Example:

<br>

What is Java?,Class,Object,Language,Compiler,C,Programming

</p>

</div>

<form
action="<%=request.getContextPath()%>/uploadCSV"
method="post"
enctype="multipart/form-data">

<div class="mb-3">

<label class="form-label">

Choose CSV File

</label>

<input
type="file"
name="csvFile"
class="form-control"
accept=".csv"
required>

</div>

<button class="btn btn-primary">

<i class="fas fa-upload"></i>

Upload CSV

</button>

<a
href="<%=request.getContextPath()%>/admin/viewQuestions.jsp"
class="btn btn-secondary">

Cancel

</a>

</form>

</div>

</div>

</body>

</html>