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

<title>Add Question</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="row justify-content-center">

<div class="col-lg-8">

<div class="card shadow">

<div class="card-header bg-primary text-white d-flex justify-content-between">

<h4 class="mb-0">Add New Question</h4>

<a href="dashboard.jsp" class="btn btn-light btn-sm">
<i class="fa fa-arrow-left"></i> Dashboard
</a>

</div>

<div class="card-body">

<%
if(request.getParameter("success") != null){
%>

<div class="alert alert-success">
Question Added Successfully.
</div>

<%
}
%>

<%
if(request.getParameter("error") != null){
%>

<div class="alert alert-danger">
Unable to Add Question.
</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/addQuestion" method="post">

<div class="mb-3">

<label class="form-label">Category</label>

<select name="category" class="form-select" required>

<option value="">Select Category</option>
<option value="Aptitude">Aptitude</option>
<option value="Reasoning">Reasoning</option>
<option value="Programming">Programming</option>
<option value="General Knowledge">General Knowledge</option>
<option value="Technical">Technical</option>

</select>

</div>

<div class="mb-3">

<label class="form-label">Question</label>

<textarea
name="questionText"
class="form-control"
rows="3"
required></textarea>

</div>

<div class="mb-3">

<label>Option A</label>

<input
type="text"
name="optionA"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Option B</label>

<input
type="text"
name="optionB"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Option C</label>

<input
type="text"
name="optionC"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Option D</label>

<input
type="text"
name="optionD"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Correct Answer</label>

<select
name="correctAnswer"
class="form-select"
required>

<option value="A">A</option>
<option value="B">B</option>
<option value="C">C</option>
<option value="D">D</option>

</select>

</div>

<button class="btn btn-success">

<i class="fa fa-save"></i>

Save Question

</button>

<button type="reset"
class="btn btn-secondary">

Reset

</button>

</form>

</div>

</div>

</div>

</div>

</div>

</body>
</html>