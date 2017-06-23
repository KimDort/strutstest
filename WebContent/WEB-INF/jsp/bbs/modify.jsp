<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function modify(boardNum){
		$("#no").val(boardNum);
		$("#frm").attr("action", "${pageContext.request.contextPath }/bbs/modify.do");
		$("#frm").attr("method", "post");
		$("#frm").submit();
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/menu/sidebar.jsp" flush="false" />
	<jsp:include page="/WEB-INF/jsp/menu/top.jsp" flush="false" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 borderBox">
			<ul class="breadcrumb">
    			<li><a href="${pageContext.request.contextPath }/main.do">Home</a></li>
   				<li><a href="${pageContext.request.contextPath }/bbs/list.do">Board</a></li>   
   				<li class="active">Board Modify</li>     
  			</ul>
			</div>
			<div class="col-md-12 borderBox" >
			<form id="frm">
				<input type="hidden" name="no">
				<input type="hidden" name="page" value="${cri.page }">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
				<table class="table table-hover" style="width: 100%;">
					<thead>
						<tr>
							<th colspan="2">Add Notice</th>
						</tr>
					</thead>
					<tbody>
					<tr>
							<th width="200px">Title</th>
							<td>
								<input type="text" placeholder="Please Write ID" class="form-control" value="${read.title }">
							</td>
						</tr>
						<tr>
							<th>Content</th>
							<td>
								<textarea class="form-control"> ${read.content }</textarea>
							</td>
						</tr>
						<tr>
							<th>Writer</th>
							<td>
								<input type="text" class="form-control" readonly="readonly" value="${read.writer }">
							</td>
						</tr>
						<tr>
							<th>To Message</th>
							<td>
								<select class="form-control" name="tomember">
									<c:forEach items="${member }" var="idx">
										<option value="${idx.no }"
										<c:out value="${idx.name eq read.tomember ?'selected=selected':'' }"/>>
										${idx.name }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>File</th>
							<td>
								<input type="file" class="form-control" name="file">
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" align="right">
								<input type="button" class="btn btn-default" value="Submit" onclick="modify(${read.no})">
								<input type="reset" class="btn btn-default" value="Reset">
								<input type="button" class="btn btn-default" value="Cancel">
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
			</div>
		</div>
	</div>
</body>
</html>