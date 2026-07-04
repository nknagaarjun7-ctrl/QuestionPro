<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session.getAttribute("student") != null){
        response.sendRedirect(request.getContextPath()+"/student/categorySelect.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Student Registration</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

body{
    background:linear-gradient(135deg,#11998e,#38ef7d);
    min-height:100vh;
}

.register-card{
    border:none;
    border-radius:20px;
    box-shadow:0 15px 40px rgba(0,0,0,.25);
}

</style>

</head>

<body class="d-flex justify-content-center align-items-center py-5">

<div class="container">

<div class="row justify-content-center">

<div class="col-md-6 col-lg-5">

<div class="card register-card">

<div class="card-body p-4">

<div class="text-center mb-4">

<i class="fas fa-user-plus fa-4x text-success"></i>

<h3 class="mt-3">Student Registration</h3>

<p class="text-muted">Create your QuestionPro account</p>

</div>

<%
if(request.getParameter("error") != null){
%>

<div class="alert alert-danger">
Registration Failed.
</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/studentRegister" method="post">

<div class="mb-3">

<label class="form-label">Full Name</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-user"></i>
</span>

<input
type="text"
name="name"
class="form-control"
placeholder="Enter Full Name"
required>

</div>

</div>

<div class="mb-3">

<label class="form-label">Email</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-envelope"></i>
</span>

<input
type="email"
name="email"
class="form-control"
placeholder="Enter Email"
autocomplete="email"
required>

</div>

</div>

<div class="mb-3">

<label class="form-label">Phone</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-phone"></i>
</span>

<input
type="tel"
name="phone"
class="form-control"
placeholder="9876543210"
pattern="[0-9]{10}"
maxlength="10"
required>

</div>

</div>

<div class="mb-4">

<label class="form-label">Password</label>

<div class="input-group">

<span class="input-group-text">
<i class="fas fa-lock"></i>
</span>

<input
type="password"
name="password"
class="form-control"
placeholder="Minimum 6 characters"
minlength="6"
autocomplete="new-password"
required>

</div>

</div>

<button class="btn btn-success w-100">

<i class="fas fa-user-plus"></i>

Register

</button>

<div class="text-center mt-3">

Already have an account?

<a href="<%=request.getContextPath()%>/student/studentLogin.jsp">

Login Here

</a>

</div>

<div class="text-center mt-2">

<a href="<%=request.getContextPath()%>/index.html">

← Back to Home

</a>

</div>

</form>

</div>

</div>

</div>

</div>

</div>

</body>

</html>