<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.questionpro.dao.QuestionDAO" %>
<%@ page import="com.questionpro.model.Question" %>
<%@ page import="com.questionpro.model.Student" %>
<%@ page import="java.util.*" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session.getAttribute("student")==null){
        response.sendRedirect(request.getContextPath()+"/student/studentLogin.jsp");
        return;
    }

    Student student=(Student)session.getAttribute("student");

    QuestionDAO dao=new QuestionDAO();
    List<Question> questions=dao.getAllQuestions();

    Set<String> categories=new LinkedHashSet<>();

    for(Question q:questions){
        categories.add(q.getCategory());
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Select Category</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#11998e,#38ef7d);
min-height:100vh;
}

.navbar{
background:#198754;
}

.card{
border:none;
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,.2);
}

.category-card{
cursor:pointer;
border:2px solid #dee2e6;
border-radius:15px;
padding:25px;
transition:.3s;
}

.category-card:hover{
border-color:#198754;
transform:translateY(-4px);
}

.selected{
border-color:#198754;
background:#d1f5df;
}

</style>

</head>

<body>

<nav class="navbar navbar-dark">

<div class="container">

<span class="navbar-brand">

<i class="fas fa-graduation-cap"></i>

QuestionPro

</span>

<span class="text-white">

Welcome,

<%=student.getName()%>

</span>

<a href="<%=request.getContextPath()%>/studentLogout"
class="btn btn-light btn-sm">

Logout

</a>

</div>

</nav>

<div class="container mt-5">

<div class="card p-4">

<h3 class="text-center mb-4">

Select Exam Category

</h3>

<form action="<%=request.getContextPath()%>/exam" method="get">

<div class="row">

<%
for(String c:categories){
%>

<div class="col-md-4 mb-3">

<div class="category-card text-center"
onclick="choose(this,'<%=c%>')">

<i class="fas fa-book fa-2x text-success mb-2"></i>

<h5>

<%=c%>

</h5>

</div>

</div>

<%
}
%>

<div class="col-md-4 mb-3">

<div class="category-card text-center"
onclick="choose(this,'all')">

<i class="fas fa-globe fa-2x text-primary mb-2"></i>

<h5>

All Categories

</h5>

</div>

</div>

</div>

<input type="hidden"
id="category"
name="category">

<div class="text-center mt-4">

<button
class="btn btn-success btn-lg"
id="startBtn"
disabled>

<i class="fas fa-play"></i>

Start Exam

</button>

</div>

</form>

</div>

</div>

<script>

function choose(card,value){

document.querySelectorAll(".category-card").forEach(function(c){

c.classList.remove("selected");

});

card.classList.add("selected");

document.getElementById("category").value=value;

document.getElementById("startBtn").disabled=false;

}

</script>

</body>

</html>