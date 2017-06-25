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

<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function addMember(){
	$("#frm").attr("action","${pageContext.request.contextPath }/projectwork/register.do");
	$("#frm").attr("method", "POST");
	$("#frm").submit();
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/menu/sidebar.jsp" flush="false"/>
<jsp:include page="/WEB-INF/jsp/menu/top.jsp" flush="false"/>
<div class="container">
	<div class="row">
		<div class="col-md-12 borderBox">
			<ul class="breadcrumb">
    			<li><a href="${pageContext.request.contextPath }/main.do">Home</a></li>
   				<li><a href="${pageContext.request.contextPath }/jsp/project/list.jsp">Project</a></li>  
   				<li><a href="${pageContext.request.contextPath }/jsp/project_working/list.jsp">Project Working</a></li>
   				<li class="active">Add Working</li>
  			</ul>
		</div>
		<div class="col-md-12 borderBox">
		<div class="col-md-12"><h3>Project Add Member</h3></div>
		<form id="frm">
		<input type="hidden" name="page" value="${cri.page }">
		<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
		<input type="hidden" name="loc" value="${cri.location }">
		<input type="hidden" name="pno" value="${project }">
			<table class="table table-default">
				<tbody>
					<c:if test="${cri.location eq 'projectwork' }">
						<tr>
							<th>Project List</th>
							<td>
								<select class="form-control" name="pno">
									<%-- <c:forEach items="${projectList }" var="idx">
										<option value="${idx.no }">${idx.name }</option>
									</c:forEach> --%>
								</select>
							</td>
						</tr>
					</c:if>
					<tr>
						<th>Member</th>
						<td>
							<select class="form-control" name="mno">
								<c:forEach items="${member }" var="idx">
									<option value="${idx.no }">${idx.name }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>Position</th>
						<td>
							<select class="form-control" name="position">
								<option>PM</option>
								<option>Dev.</option>
								<option>Q&A</option>
								<option>Etc</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>Join Day</th>
						<td>
							<input type="text" class="form-control" placeholder="ex) yyyy-MM-dd" name="joinday">
						</td>
					</tr>
					<tr>
						<th>Out Day</th>
						<td>
							<input type="text" class="form-control" placeholder="ex) yyyy-MM-dd" name="outday">
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" align="right">
							<input type="button" value="Add Member" class="btn btn-default" onclick="addMember()">
							<input type="reset" value="reset" class="btn btn-default">
							<input type="button" value="cancel" class="btn btn-default">
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