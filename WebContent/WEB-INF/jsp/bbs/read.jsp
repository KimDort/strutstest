<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/menu/sidebar.jsp" flush="false"/>
	<jsp:include page="/WEB-INF/jsp/menu/top.jsp" flush="false"/>
	<div class="container">
	<div class="row">
		<div class="col-md-12 borderBox">
			<ul class="breadcrumb">
    			<li><a href="${pageContext.request.contextPath }/main.do">Home</a></li>
   				<li><a href="${pageContext.request.contextPath }/bbs/list.do?page=${cri.page }&perPageNum=${cri.perPageNum}">Board</a></li>
   				<li class="active">Detail Board Content</li>
  			</ul>
		</div>
		<div class="col-md-12 borderBox">
			<table class="table table-default">
				<tbody>
					<tr>
						<th width="200px">No.</th>
						<td>${read.no}</td>
					</tr>
					<tr>
						<th>Title</th>
						<td>${read.title}</td>
					</tr>
					<tr>
						<th>Content</th>
						<td>${read.content }</td>
					</tr>
					<tr>
						<th>Writer</th>
						<td>${read.writer }</td>
					</tr>
					<tr>
						<th>To Message</th>
						<td>${read.tomember}</td>
					</tr>
					<tr>
						<th>Regdate</th>
						<td>
							<fmt:parseDate value="${read.regdate}" pattern="yyyy-MM-dd" var="reg"/>
							<fmt:formatDate value="${reg }" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					<tr>
						<th>File</th>
						<td>
							<a href="${pageContext.request.contextPath }/bbs/download?fileName=${read.file_copyname }">
								${read.file_copyname }
							</a>
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
	</div>
</body>
</html>