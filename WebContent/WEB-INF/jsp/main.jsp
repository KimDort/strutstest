<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/menu/sidebar.jsp" flush="false"/>
<jsp:include page="/WEB-INF/jsp/menu/top.jsp" flush="false"/>
	<div class="container">
		<div class="row">
			<div class="col-sm-6 borderBox">
			<label>Member</label>
			<label style="float: right"><a href="${pageContext.request.contextPath }/member/list.do?page=1&perPageNum=10">more</a></label>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Name</th>
						<th>Work</th>
						<th>Career</th>
						<th width="50px">Project History</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Gil Dong, Hong</td>
						<td>Regular</td>
						<td><a href="#">1년 2개월</a></td>
						<td><a href="#">1</a></td>
					</tr>
					<tr>
						<td>Gil Dong, Hong</td>
						<td>Regular</td>
						<td><a href="#">1년 2개월</a></td>
						<td><a href="#">1</a></td>
					</tr>
					<tr>
						<td>Gil Dong, Hong</td>
						<td>Regular</td>
						<td><a href="#">1년 2개월</a></td>
						<td><a href="#">1</a></td>
					</tr>
					<tr>
						<td>Gil Dong, Hong</td>
						<td>Regular</td>
						<td><a href="#">1년 2개월</a></td>
						<td><a href="#">1</a></td>
					</tr>
					<tr>
						<td>Gil Dong, Hong</td>
						<td>Regular</td>
						<td><a href="#">1년 2개월</a></td>
						<td><a href="#">1</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<%-- <div class="col-md-4 borderBox">
			<label>Notice / Schedule</label>
			<label style="float: right"><a href="${pageContext.request.contextPath }/bbs/list.do?page=1&perPageNum=10">more</a></label>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Title</th>
						<th width="50px">Writer</th>
						<th width="100px">Reg.</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${bbslist }" var="idx">
						<tr>
							<td>${idx.title }</td>
							<td>${idx.writer }</td>
							<td>
								<fmt:parseDate value="${idx.regdate }" var="reg" pattern="yyyy-MM-dd"/>
								<fmt:formatDate value="${reg }" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div> --%>
		<div class="col-md-4 borderBox">
			<label>Project Woring</label>
			<label style="float: right"><a href="${pageContext.request.contextPath }/jsp/project_working/list.jsp">more</a></label>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Member</th>
						<th>Join Project</th>
						<th>Position</th>
						<th width="50px">Join Day</th>
						<th width="50px">Out Day</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Gild Dong, Hong</td>
						<td>Project No.1</td>
						<td>Dev.</td>
						<td>2017-05-03</td>
						<td>2017-05-08</td>
					</tr>
					<tr>
						<td>Gild Dong, Hong</td>
						<td>Project No.1</td>
						<td>Dev.</td>
						<td>2017-05-03</td>
						<td>2017-05-08</td>
					</tr>
					<tr>
						<td>Gild Dong, Hong</td>
						<td>Project No.1</td>
						<td>Dev.</td>
						<td>2017-05-03</td>
						<td>2017-05-08</td>
					</tr>
					<tr>
						<td>Gild Dong, Hong</td>
						<td>Project No.1</td>
						<td>Dev.</td>
						<td>2017-05-03</td>
						<td>2017-05-08</td>
					</tr>
					<tr>
						<td>Gild Dong, Hong</td>
						<td>Project No.1</td>
						<td>Dev.</td>
						<td>2017-05-03</td>
						<td>2017-05-08</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-6 borderBox">
			<label>Project</label>
			<label style="float: right"><a href="${pageContext.request.contextPath }/project/list.do?page=1&perPageNum=10">more</a></label>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Name</th>
						<th width="100px">Stary Day</th>
						<th width="100px">End Day</th>
						<th width="50px">In Member</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td>Project No.1</td>
							<td>2017-01-01</td>
							<td>2018-01-01</td>
							<td>0</td>
						</tr>
						<tr>
							<td>Project No.1</td>
							<td>2017-01-01</td>
							<td>2018-01-01</td>
							<td>0</td>
						</tr>
						<tr>
							<td>Project No.1</td>
							<td>2017-01-01</td>
							<td>2018-01-01</td>
							<td>0</td>
						</tr>
						<tr>
							<td>Project No.1</td>
							<td>2017-01-01</td>
							<td>2018-01-01</td>
							<td>0</td>
						</tr>
						<tr>
							<td>Project No.1</td>
							<td>2017-01-01</td>
							<td>2018-01-01</td>
							<td>0</td>
						</tr>
					<c:forEach items="${project }" var="idx">
						<tr>
							<td>${idx.name }</td>
							<td>${idx.startday }</td>
							<td>${idx.inmember }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
	</div>
</body>
</html>