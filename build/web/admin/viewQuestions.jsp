<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.questionpro.dao.QuestionDAO" %>
<%@ page import="com.questionpro.model.Question" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session == null || session.getAttribute("admin") == null){
        response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
        return;
    }

    List<Question> questions =
            (List<Question>)request.getAttribute("questions");

    if(questions == null){
        QuestionDAO dao = new QuestionDAO();
        questions = dao.getAllQuestions();
    }

    String keyword = (String)request.getAttribute("keyword");
    if(keyword == null){
        keyword = "";
    }
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>View Questions</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      rel="stylesheet">

<style>

body{
    background:#f5f6fa;
}

.table td{
    vertical-align:middle;
}

.question{
    max-width:500px;
    word-break:break-word;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2>Question List</h2>

<div>

<a href="addQuestion.jsp"
class="btn btn-success">

<i class="fa fa-plus"></i>
Add Question

</a>

<a href="dashboard.jsp"
class="btn btn-secondary">

<i class="fa fa-arrow-left"></i>
Dashboard

</a>

</div>

</div>


<form action="<%=request.getContextPath()%>/searchQuestion"
method="get"
class="row g-2 mb-4">

<div class="col-md-10">

<input
type="text"
name="keyword"
class="form-control"
placeholder="Search Question / Category"
value="<%=keyword%>">

</div>

<div class="col-md-2">

<button class="btn btn-primary w-100">

<i class="fa fa-search"></i>
Search

</button>

</div>

</form>


<% if(request.getParameter("msg") != null){ %>

<div class="alert alert-success alert-dismissible fade show">

Operation completed successfully.

<button class="btn-close"
data-bs-dismiss="alert"></button>

</div>

<% } %>


<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger alert-dismissible fade show">

Something went wrong.

<button class="btn-close"
data-bs-dismiss="alert"></button>

</div>

<% } %>


<div class="table-responsive">

<table class="table table-bordered table-hover table-striped">

<thead class="table-dark">

<tr>

<th>ID</th>
<th>Question</th>
<th>Category</th>
<th>Correct Answer</th>
<th width="180">Action</th>

</tr>

</thead>

<tbody>

<%

if(questions==null || questions.isEmpty()){

%>

<tr>

<td colspan="5" class="text-center text-danger">

No Questions Found

</td>

</tr>

<%

}else{

for(Question q:questions){

%>

<tr>

<td>

<%=q.getId()%>

</td>

<td class="question">

<%=q.getQuestionText()%>

</td>

<td>

<%=q.getCategory()%>

</td>

<td>

<span class="badge bg-success">

<%=q.getCorrectAnswer()%>

</span>

</td>

<td>

<a href="<%=request.getContextPath()%>/editQuestion?id=<%=q.getId()%>"
class="btn btn-warning btn-sm">

<i class="fa fa-edit"></i>

Edit

</a>

<a href="<%=request.getContextPath()%>/deleteQuestion?id=<%=q.getId()%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Are you sure you want to delete this question?');">

<i class="fa fa-trash"></i>

Delete

</a>

</td>

</tr>

<%

}

}

%>

</tbody>

</table>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>