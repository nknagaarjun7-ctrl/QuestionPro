<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.questionpro.model.Student"%>

<%
if(session.getAttribute("admin")==null){
    response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
    return;
}

List<Student> students=(List<Student>)request.getAttribute("students");

if(students==null){
    students=new ArrayList<>();
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Students</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<style>

body{

background:#f5f6fa;

}

.card{

border:none;

border-radius:15px;

box-shadow:0 5px 20px rgba(0,0,0,.1);

}

</style>

</head>

<body>

<div class="container mt-5">

<div class="card p-4">

<div class="d-flex justify-content-between">

<h3>

<i class="fa fa-users text-primary"></i>

Registered Students

</h3>

<a href="dashboard.jsp"

class="btn btn-secondary">

Dashboard

</a>

</div>

<hr>

<table class="table table-bordered table-hover">

<thead class="table-dark">

<tr>

<th>ID</th>

<th>Name</th>

<th>Email</th>

<th>Phone</th>

</tr>

</thead>

<tbody>

<%

if(students.isEmpty()){

%>

<tr>

<td colspan="4"

class="text-center text-danger">

No Students Found

</td>

</tr>

<%

}else{

for(Student s:students){

%>

<tr>

<td><%=s.getId()%></td>

<td><%=s.getName()%></td>

<td><%=s.getEmail()%></td>

<td><%=s.getPhone()%></td>

</tr>

<%

}

}

%>

</tbody>

</table>

</div>

</div>

</body>

</html>