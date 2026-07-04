<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.questionpro.model.Question" %>
<%@ page import="com.questionpro.model.Student" %>

<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

if(session.getAttribute("student")==null){
    response.sendRedirect(request.getContextPath()+"/student/studentLogin.jsp");
    return;
}

Student student=(Student)session.getAttribute("student");

List<Question> questions=(List<Question>)request.getAttribute("questions");

if(questions==null){
    response.sendRedirect(request.getContextPath()+"/student/categorySelect.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Online Exam</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
rel="stylesheet">

<style>

body{
background:#f5f6fa;
}

.navbar{
background:linear-gradient(135deg,#11998e,#38ef7d);
}

.question-card{
border:none;
border-radius:15px;
box-shadow:0 5px 15px rgba(0,0,0,.1);
margin-bottom:25px;
}

.question-number{
width:40px;
height:40px;
border-radius:50%;
background:#0d6efd;
color:white;
display:flex;
align-items:center;
justify-content:center;
font-weight:bold;
}

.option-label{
display:block;
padding:10px;
border:2px solid #dee2e6;
border-radius:8px;
cursor:pointer;
margin-bottom:10px;
transition:.3s;
}

.option-label:hover{
background:#eef5ff;
border-color:#0d6efd;
}

.option-label.selected{
background:#d1f5df;
border-color:#198754;
}

.timer{
font-size:24px;
font-weight:bold;
color:white;
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

<div class="timer">

<i class="fas fa-clock"></i>

<span id="timer">

30:00

</span>

</div>

</div>

</nav>

<div class="container mt-4">

<form
action="<%=request.getContextPath()%>/exam"
method="post"
id="examForm">

<%
int no=1;

for(Question q:questions){
%>

<div class="card question-card">

<div class="card-body">

<div class="d-flex align-items-center mb-3">

<div class="question-number me-3">

<%=no++%>

</div>

<h5>

<%=q.getQuestionText()%>

</h5>

</div>

<input
type="radio"
name="q<%=q.getId()%>"
value="A"
id="a<%=q.getId()%>"
hidden>

<label
for="a<%=q.getId()%>"
class="option-label">

<b>A.</b>

<%=q.getOptionA()%>

</label>

<input
type="radio"
name="q<%=q.getId()%>"
value="B"
id="b<%=q.getId()%>"
hidden>

<label
for="b<%=q.getId()%>"
class="option-label">

<b>B.</b>

<%=q.getOptionB()%>

</label>

<input
type="radio"
name="q<%=q.getId()%>"
value="C"
id="c<%=q.getId()%>"
hidden>

<label
for="c<%=q.getId()%>"
class="option-label">

<b>C.</b>

<%=q.getOptionC()%>

</label>

<input
type="radio"
name="q<%=q.getId()%>"
value="D"
id="d<%=q.getId()%>"
hidden>

<label
for="d<%=q.getId()%>"
class="option-label">

<b>D.</b>

<%=q.getOptionD()%>

</label>

</div>

</div>

<%
}
%>

<div class="text-center mb-5">

<button
type="submit"
class="btn btn-success btn-lg px-5"
onclick="window.onbeforeunload=null; return confirm('Are you sure you want to submit the exam?');">

<i class="fas fa-paper-plane"></i>

Submit Exam

</button>

</div>

</form>

</div>

<script>

let time=30*60;

const timer=document.getElementById("timer");

const form=document.getElementById("examForm");

const interval=setInterval(function(){

let min=Math.floor(time/60);

let sec=time%60;

timer.innerHTML=min+":"+(sec<10?"0":"")+sec;

if(time<=300){

timer.style.color="red";

}

if(time<=0){

clearInterval(interval);

alert("Time Over! Exam Submitted.");

window.onbeforeunload=null;

form.submit();

}

time--;

},1000);


// Highlight Selected Option

document.querySelectorAll("input[type=radio]").forEach(function(radio){

radio.addEventListener("change",function(){

document.querySelectorAll("input[name='"+this.name+"']").forEach(function(r){

r.nextElementSibling.classList.remove("selected");

});

this.nextElementSibling.classList.add("selected");

});

});


// Prevent Back Button

history.pushState(null,null,location.href);

window.addEventListener("popstate",function(){

history.pushState(null,null,location.href);

});


// Disable Refresh

document.addEventListener("keydown",function(e){

if(e.key==="F5"){

e.preventDefault();

}

if(e.ctrlKey && (e.key==="r" || e.key==="R")){

e.preventDefault();

}

});


// Warn Before Leaving

window.onbeforeunload=function(){

return "Your exam is in progress.";

};

</script>

</body>

</html>