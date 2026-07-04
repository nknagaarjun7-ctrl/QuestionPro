<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.questionpro.dao.StudentDAO"%>
<%@ page import="com.questionpro.model.Student"%>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session.getAttribute("admin")==null){
        response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
        return;
    }

    StudentDAO dao = new StudentDAO();
    List<Student> students = dao.getAllStudents();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Student List</title>

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

thead{
    background:#0d6efd;
    color:white;
}

</style>

<script>

function searchStudent(){

    let input = document.getElementById("search").value.toLowerCase();

    let table = document.getElementById("studentTable");

    let tr = table.getElementsByTagName("tr");

    for(let i=1;i<tr.length;i++){

        let td = tr[i].getElementsByTagName("td");

        let found = false;

        for(let j=0;j<td.length;j++){

            if(td[j]){

                let txt = td[j].textContent || td[j].innerText;

                if(txt.toLowerCase().indexOf(input)>-1){

                    found = true;

                }

            }

        }

        tr[i].style.display = found ? "" : "none";

    }

}

</script>

</head>

<body>

<div class="container mt-5">

<div class="card p-4">

<div class="d-flex justify-content-between align-items-center mb-4">

<h3>

<i class="fa fa-users"></i>

Student List

</h3>

<div class="d-flex">

<input
type="text"
id="search"
class="form-control me-2"
placeholder="Search Student..."
onkeyup="searchStudent()">

<a href="dashboard.jsp" class="btn btn-secondary">

<i class="fa fa-arrow-left"></i>

Dashboard

</a>

</div>

</div>

<div class="table-responsive">

<table class="table table-bordered table-hover" id="studentTable">

<thead>

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

<td colspan="4" class="text-center text-danger">

No Students Found

</td>

</tr>

<%

}else{

for(Student s : students){

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

</div>

</body>

</html>