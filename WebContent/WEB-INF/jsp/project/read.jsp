<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function back(){
		$(location).attr("href","${pageContext.request.contextPath }/project/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}");
	};
	$(function(){
		$("#startday").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' 
		});
		$("#endday").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' 
		});
	});
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
   				<li><a href="${pageContext.request.contextPath }
   					/project/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}">Project</a>
   				</li>   
   				<li class="active">Project Create</li>     
  			</ul>
			</div>
			<div class="col-md-12 borderBox" >
			<form action="${pageContext.request.contextPath }/project/register.do" method="post" id="frm">
				<input type="hidden" name="page" value="${cri.page }">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
				<input type="hidden" name="loc" value="${cri.location }">
				<table class="table table-hover" style="width: 100%;">
					<thead>
						<tr>
							<th colspan="2">Add Project</th>
						</tr>
					</thead>
					<tbody>
					<tr>
							<th width="200px">Project Name</th>
							<td>
								<input type="text" placeholder="Please Write Name" class="form-control" name="name" readonly="readonly" value="${read.name }">
							</td>
						</tr>
						<tr>
							<th>Content</th>
							<td>
								<input type="text" placeholder="Please Write Content" class="form-control" name="content" readonly="readonly" value="${read.content }">
							</td>
						</tr>
						<tr>
							<th>Start Day</th>
							<td>
								<input type="text" placeholder="Please Click And Select Date" class="form-control" name="startday" id="startday" readonly="readonly" value="${read.start }">
							</td>
						</tr>
						<tr>
							<th>End Day</th>
							<td>
								<input type="text" placeholder="Please Click And Select Date" class="form-control" name="endday" id="endday" readonly="readonly" value="${read.end }">
							</td>
						</tr>
						<tr>
							<th>Order Company</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="ordercompany" readonly="readonly" value="${read.order_company }">
							</td>
						</tr>
						<tr>
							<th>Create Skill</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="createskill" id="createskill" value="${read.create_skill }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>ETC</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="etc" value="${read.etc }" readonly="readonly">
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" align="right">
								<input type="button" class="btn btn-default" value="List" onclick="back()">
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