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
			<label style="float: right"><a href="${pageContext.request.contextPath }/employee/list.do?page=1&perPageNum=10">more</a></label>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Name</th>
						<th>Work</th>
						<th>Career</th>
						<th>Is Project<br>Join</th>
						<th>Rank</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${employeeList }" var="idx">
						<tr>
							<td>${idx.name }</td>
							<td>${idx.isnew}</td>
							<td>
								<c:set var="totalCareer" value="0"/>
								<c:forEach items="${career }" var="car" varStatus="status">
									<c:if test="${idx.no eq car.member_no }">
										<c:if test="${car.totalCareer > 12 }">
											<c:set var="totalCareer" value="${totalCareer + car.totalCareer }"/>
										</c:if>	
										<c:if test="${car.totalCareer < 12 }">
											<c:set var="totalCareer" value="${totalCareer + car.totalCareer }"/>
										</c:if>
									</c:if>
								</c:forEach>
								<c:if test="${totalCareer > 0 }">
									<c:if test="${totalCareer > 12}">
									<fmt:formatNumber value="${totalCareer/12 }" pattern="0"/>년
									<fmt:formatNumber value="${totalCareer%12 }" pattern="0"/>개월
									</c:if>
									<c:if test="${totalCareer < 12 }">
										<fmt:formatNumber value="${totalCareer }" pattern="0"/>개월
									</c:if>
								</c:if>
							</td>
							<td>
								${idx.projecthistory }
							</td>
							<td>${idx.rank }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-4 borderBox">
			<label>Project Join</label>
			<label style="float: right"><a href="${pageContext.request.contextPath }/projectjoin/list.do?page=1&perPageNum=10&location=projectjoin">more</a></label>
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
					<c:forEach items="${projectJoinList }" var="idx">
						<tr>
							<td>${idx.member }</td>
							<td>${idx.name }</td>
							<td>${idx.position }</td>
							<td>${idx.join }</td>
							<td>${idx.out }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-sm-6 borderBox">
			<label>Project</label>
			<label style="float: right"><a href="${pageContext.request.contextPath }/project/list.do?page=1&perPageNum=10&location=project">more</a></label>
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
					<c:forEach items="${projectList }" var="idx">
						<tr>
							<td>${idx.name }</td>
							<td>${idx.start }</td>
							<td>${idx.end }</td>
							<td align="center">${idx.member_count }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
	</div>
</body>
</html>