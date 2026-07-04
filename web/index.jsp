<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>QuestionPro</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#667eea,#764ba2);
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
}

.card{
border:none;
border-radius:20px;
box-shadow:0 20px 60px rgba(0,0,0,.3);
}

.btn-admin{
background:linear-gradient(135deg,#667eea,#764ba2);
border:none;
}

.btn-admin:hover{
transform:translateY(-2px);
}

.btn-student{
background:linear-gradient(135deg,#11998e,#38ef7d);
border:none;
}

.btn-student:hover{
transform:translateY(-2px);
}

.btn{
transition:.3s;
}

</style>

</head>

<body>

<div class="container">

<div class="row justify-content-center">

<div class="col-lg-4 col-md-6">

<div class="card p-5 text-center">

<i class="fas fa-graduation-cap fa-4x text-primary mb-3"></i>

<h2 class="fw-bold">
QuestionPro
</h2>

<p class="text-muted mb-4">
Online Exam Management System
</p>

<div class="d-grid gap-3">

<a href="<%=request.getContextPath()%>/admin/adminLogin.jsp"
class="btn btn-admin btn-lg text-white">

<i class="fas fa-user-shield"></i>

Admin Login

</a>

<a href="<%=request.getContextPath()%>/student/studentLogin.jsp"
class="btn btn-student btn-lg text-white">

<i class="fas fa-user-graduate"></i>

Student Login

</a>

<a href="<%=request.getContextPath()%>/student/studentRegister.jsp"
class="btn btn-outline-secondary btn-lg">

<i class="fas fa-user-plus"></i>

Student Register

</a>

</div>

</div>

</div>

</div>

</div>

</body>

</html>