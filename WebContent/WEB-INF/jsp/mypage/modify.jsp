<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="../../js/script.js"></script>
<link href="../../css/style.css" rel="Stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../menu/sidebar.jsp" flush="false"/>
<jsp:include page="../menu/top.jsp" flush="false"/>
<div class="container">
	<div class="row">
		<div class="col-md-12 borderBox">
			<ul class="breadcrumb">
    			<li><a href="${pageContext.request.contextPath }/jsp/main.jsp">Home</a></li>
   				<li><a href="${pageContext.request.contextPath }/jsp/mypage/projfile.jsp">Profile</a></li>
   				<li class="active">Modify Profile</li>
  			</ul>
		</div>
		<div class="col-md-12 borderBox" >
			<table class="table table-default">
				<tbody>
					<tr>
					<th width="300px">ID</th>
					<td>
						Tester<input type="button" class="btn btn-default" value="Change ID">
						Or<input type="text" class="form-control" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>Name</th>
					<td>
						<input type="text" class="form-control" value="Gil Dong, Hong">
					</td>
				</tr>
				<tr>
					<th>Phone</th>
					<td>
						<select class="form-control" style="width: 33%;float: left;">
							<option>010</option>
							<option>011</option>
							<option>012</option>
							<option>013</option>
							<option>014</option>
							<option>015</option>
							<option>016</option>
							<option>017</option>
							<option>018</option>
							<option>019</option>
						</select>
						<input type="text" class="form-control" maxlength="4" style="width: 33%;float: left;">
						<input type="text" class="form-control" maxlength="4" style="width: 33%;float: left;">						
					</td>
				</tr>
				<tr>
					<th>Email</th>
					<td>
						<div id="mailNameBox" style="width: 48%;float: left;">
							<input type="text" class="form-control" value="test">
						</div>
						<div style="width: 4%;float: left;text-align: center;">@</div>
						<div id="mailServiceBox" style="float: left; width:48%;">
						<select class="form-control" id="mailService">
							<option>gmail.com</option>
							<option>hotmail.com</option>
							<option>msn.com</option>
							<option>paran.com</option>
							<option>hanmail.net</option>
							<option>naver.com</option>
							<option value="self">Self Select</option>
						</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>Rank</th>
					<td>
						<select class="form-control">
							<option>Staff</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>Date of joining company by</th>
					<td>
						2016-05-05
					</td>
				</tr>
				<tr>
					<th>Department</th>
					<td>
						<select class="form-control">
							<option>SI</option>
							<option>SI</option>
							<option>SI</option>
							<option>SI</option>
							<option>SI</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>Have My Skills</th>
					<td>
						<input type="text" class="form-control" value="JAVA, C, C#, C++">
					</td>
				</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" align="right">
							<input type="button" class="btn btn-default" value="Complete" onclick="modifyProfile()">
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
</body>
</html>