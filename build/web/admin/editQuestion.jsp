<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.questionpro.model.Question" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session == null || session.getAttribute("admin") == null){
        response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
        return;
    }

    Question q = (Question)request.getAttribute("question");

    if(q == null){
        response.sendRedirect(request.getContextPath()+"/admin/viewQuestions.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Edit Question</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

body{
    background:#f4f6f9;
}

.sidebar{
    width:250px;
    position:fixed;
    top:0;
    left:0;
    height:100vh;
    background:linear-gradient(180deg,#667eea,#764ba2);
    padding-top:20px;
}

.sidebar h4{
    color:white;
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    color:white;
    text-decoration:none;
    display:block;
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

<i class="fas fa-edit text-warning"></i>

Edit Question

</h3>

<form action="<%=request.getContextPath()%>/editQuestion" method="post">

<input type="hidden" name="id" value="<%=q.getId()%>">

<div class="mb-3">

<label>Question</label>

<textarea
name="questionText"
class="form-control"
rows="3"
required><%=q.getQuestionText()%></textarea>

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label>Option A</label>

<input
type="text"
name="optionA"
class="form-control"
value="<%=q.getOptionA()%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Option B</label>

<input
type="text"
name="optionB"
class="form-control"
value="<%=q.getOptionB()%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Option C</label>

<input
type="text"
name="optionC"
class="form-control"
value="<%=q.getOptionC()%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Option D</label>

<input
type="text"
name="optionD"
class="form-control"
value="<%=q.getOptionD()%>"
required>

</div>

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label>Correct Answer</label>

<select
name="correctAnswer"
class="form-select">

<option value="A" <%=q.getCorrectAnswer().equals("A")?"selected":""%>>A</option>

<option value="B" <%=q.getCorrectAnswer().equals("B")?"selected":""%>>B</option>

<option value="C" <%=q.getCorrectAnswer().equals("C")?"selected":""%>>C</option>

<option value="D" <%=q.getCorrectAnswer().equals("D")?"selected":""%>>D</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label>Category</label>

<select
name="category"
class="form-select">

<option value="Aptitude" <%=q.getCategory().equals("Aptitude")?"selected":""%>>Aptitude</option>

<option value="Reasoning" <%=q.getCategory().equals("Reasoning")?"selected":""%>>Reasoning</option>

<option value="Programming" <%=q.getCategory().equals("Programming")?"selected":""%>>Programming</option>

<option value="General Knowledge" <%=q.getCategory().equals("General Knowledge")?"selected":""%>>General Knowledge</option>

<option value="Technical" <%=q.getCategory().equals("Technical")?"selected":""%>>Technical</option>

</select>

</div>

</div>

<button class="btn btn-warning">
<i class="fas fa-save"></i>
Update Question
</button>

<a href="<%=request.getContextPath()%>/admin/viewQuestions.jsp"
class="btn btn-secondary">
Cancel
</a>

</form>

</div>

</div>

</body>
</html>