<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session.getAttribute("admin") != null){
        response.sendRedirect(request.getContextPath()+"/admin/dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Admin Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

body{
    background:linear-gradient(135deg,#667eea,#764ba2);
    min-height:100vh;
}

.login-card{
    border:none;
    border-radius:20px;
    box-shadow:0 15px 40px rgba(0,0,0,.25);
}

</style>

</head>

<body class="d-flex justify-content-center align-items-center">

<div class="container">

<div class="row justify-content-center">

<div class="col-md-5 col-lg-4">

<div class="card login-card">

<div class="card-body p-4">

<div class="text-center mb-4">

<i class="fas fa-user-shield fa-4x text-primary"></i>

<h3 class="mt-3">Admin Login</h3>

<p class="text-muted">QuestionPro Admin Panel</p>

</div>

<%
if(request.getParameter("error") != null){
%>

<div class="alert alert-danger">

Invalid Username or Password.

</div>

<%
}
%>

<%
if(request.getParameter("logout") != null){
%>

<div class="alert alert-success">

Logged out successfully.

</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/adminLogin" method="post">

<div class="mb-3">

<label class="form-label">

Username

</label>

<div class="input-group">

<span class="input-group-text">

<i class="fas fa-user"></i>

</span>

<input
type="text"
name="username"
class="form-control"
placeholder="Enter Username"
autocomplete="username"
required>

</div>

</div>

<div class="mb-4">

<label class="form-label">

Password

</label>

<div class="input-group">

<span class="input-group-text">

<i class="fas fa-lock"></i>

</span>

<input
type="password"
name="password"
class="form-control"
placeholder="Enter Password"
autocomplete="current-password"
required>

</div>

</div>

<button class="btn btn-primary w-100">

<i class="fas fa-sign-in-alt"></i>

Login

</button>

<div class="text-center mt-3">

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