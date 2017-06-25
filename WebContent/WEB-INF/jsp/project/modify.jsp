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
	function submit(){
		$("#frm").submit();
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
			<form id="frm" action="${pageContext.request.contextPath }/project/modifyDone.do" method="post">
				<input type="hidden" name="page" value="${cri.page }">
				<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
				<input type="hidden" name="loc" value="${cri.location }">
				<input type="hidden" name="no" value="${project.no}">
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
								<input type="text" placeholder="Please Write Name" class="form-control" name="name" value="${project.name }">
							</td>
						</tr>
						<tr>
							<th>Content</th>
							<td>
								<input type="text" placeholder="Please Write Content" class="form-control" name="content" value="${project.content }">
							</td>
						</tr>
						<tr>
							<th>Start Day</th>
							<td>
								<input type="text" placeholder="Please Click And Select Date" class="form-control" name="start" id="startday" readonly="readonly" value="${project.start }">
							</td>
						</tr>
						<tr>
							<th>End Day</th>
							<td>
								<input type="text" placeholder="Please Click And Select Date" class="form-control" name="end" id="endday" readonly="readonly" value="${project.end }">
							</td>
						</tr>
						<tr>
							<th>Order Company</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="order_company" value="${project.order_company }">
							</td>
						</tr>
						<tr>
							<th>Create Skill</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="create_skill" id="createskill" value="${project.create_skill }">
							</td>
						</tr>
						<tr>
							<th>ETC</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="etc" value="${project.etc }">
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" align="right">
								<input type="button" class="btn btn-default" value="Submit" onclick="submit()">
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