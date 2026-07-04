<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    if(session.getAttribute("admin")==null){
        response.sendRedirect(request.getContextPath()+"/admin/adminLogin.jsp");
        return;
    }

    List<Map<String,Object>> leaderboard =
            (List<Map<String,Object>>)request.getAttribute("leaderboard");

    if(leaderboard==null){
        leaderboard=new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Admin Leaderboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
rel="stylesheet">

<style>

body{
    background:#f5f6fa;
}

.card{
    border:none;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,.1);
}

.table thead{
    background:#0d6efd;
    color:white;
}

.rank1{
    background:#fff3cd;
}

.rank2{
    background:#e9ecef;
}

.rank3{
    background:#f8d7da;
}

.progress{
    height:20px;
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="card p-4">

<div class="d-flex justify-content-between align-items-center mb-4">

<h3>

<i class="fas fa-trophy text-warning"></i>

Admin Leaderboard

</h3>

<a href="<%=request.getContextPath()%>/admin/dashboard.jsp"
   class="btn btn-secondary">

<i class="fas fa-arrow-left"></i>

Back to Dashboard

</a>

</div>

<div class="table-responsive">

<table class="table table-bordered table-hover align-middle text-center">

<thead>

<tr>

<th>Rank</th>

<th>Student Name</th>

<th>Score</th>

<th>Total</th>

<th>Percentage</th>

<th>Exam Date</th>

</tr>

</thead>

<tbody>

<%

int rank=1;

if(!leaderboard.isEmpty()){

for(Map<String,Object> row : leaderboard){

int score=(Integer)row.get("score");
int total=(Integer)row.get("total");

int percentage=0;

if(total>0){

percentage=(score*100)/total;

}

String rowClass="";

if(rank==1){

rowClass="rank1";

}else if(rank==2){

rowClass="rank2";

}else if(rank==3){

rowClass="rank3";

}

%>

<tr class="<%=rowClass%>">

<td>

<%

if(rank==1){

%>

🥇

<%

}else if(rank==2){

%>

🥈

<%

}else if(rank==3){

%>

🥉

<%

}else{

out.print(rank);

}

%>

</td>

<td>

<b>

<%=row.get("name")%>

</b>

</td>

<td>

<%=score%>

</td>

<td>

<%=total%>

</td>

<td>

<div class="progress">

<div class="progress-bar bg-success"

style="width:<%=percentage%>%">

<%=percentage%>%

</div>

</div>

</td>

<td>

<%=row.get("examDate")%>

</td>

</tr>

<%

rank++;

}

}else{

%>

<tr>

<td colspan="6" class="text-center text-danger">

No Results Available

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

</body>

</html>