<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.questionpro.model.Student" %>

<%
    if(session.getAttribute("student") == null){
        response.sendRedirect(request.getContextPath()+"/student/studentLogin.jsp");
        return;
    }

    Student student = (Student)session.getAttribute("student");

    Integer score = (Integer)session.getAttribute("score");
    Integer total = (Integer)session.getAttribute("total");

    if(score == null) score = 0;
    if(total == null) total = 0;

    int percentage = 0;

    if(total > 0){
        percentage = (score * 100) / total;
    }

    String grade = "";
    String gradeColor = "";

    if(percentage >= 90){
        grade = "A+";
        gradeColor = "success";
    }
    else if(percentage >= 75){
        grade = "A";
        gradeColor = "primary";
    }
    else if(percentage >= 60){
        grade = "B";
        gradeColor = "info";
    }
    else if(percentage >= 50){
        grade = "C";
        gradeColor = "warning";
    }
    else{
        grade = "F";
        gradeColor = "danger";
    }
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Exam Result</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
rel="stylesheet">

<style>

body{
    background:linear-gradient(135deg,#667eea,#764ba2);
    min-height:100vh;
}

.result-card{
    border-radius:20px;
    box-shadow:0 20px 60px rgba(0,0,0,.3);
    border:none;
}

.score-circle{
    width:170px;
    height:170px;
    border-radius:50%;
    border:8px solid;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    margin:auto;
}

</style>

</head>

<body class="d-flex align-items-center justify-content-center">

<div class="container">

<div class="row justify-content-center">

<div class="col-md-6">

<div class="card result-card p-4">

<div class="card-body text-center">

<h2 class="mb-4">
<i class="fas fa-award text-warning"></i>
Exam Result
</h2>

<h4 class="mb-4">
Welcome,
<%=student.getName()%>
</h4>

<div class="score-circle border-<%=gradeColor%>">

<h2 class="text-<%=gradeColor%>">
<%=score%>/<%=total%>
</h2>

<h5 class="text-<%=gradeColor%>">
Grade : <%=grade%>
</h5>

</div>

<br>

<div class="progress mb-4" style="height:25px;">

<div class="progress-bar bg-<%=gradeColor%>"
style="width:<%=percentage%>%">

<%=percentage%>%

</div>

</div>

<div class="row text-center mb-4">

<div class="col-md-4">

<div class="card bg-success text-white">

<div class="card-body">

<h3><%=score%></h3>

Correct

</div>

</div>

</div>

<div class="col-md-4">

<div class="card bg-danger text-white">

<div class="card-body">

<h3><%=total-score%></h3>

Wrong

</div>

</div>

</div>

<div class="col-md-4">

<div class="card bg-primary text-white">

<div class="card-body">

<h3><%=total%></h3>

Total

</div>

</div>

</div>

</div>

<!-- BUTTONS -->

<div class="d-flex justify-content-center gap-3">

<a href="${pageContext.request.contextPath}/leaderboard"
class="btn btn-primary btn-lg">

<i class="fas fa-trophy"></i>
Leaderboard

</a>

<a href="${pageContext.request.contextPath}/student/categorySelect.jsp"
class="btn btn-warning btn-lg">

<i class="fas fa-redo"></i>
Try Again

</a>

</div>

</div>

</div>

</div>

</div>

</body>
</html>