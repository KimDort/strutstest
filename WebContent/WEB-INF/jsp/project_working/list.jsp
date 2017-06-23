<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<script>
	function createItem(){
		var str="${pageContext.request.contextPath }/projectwork/registerForm.do"
				+"?page=${cri.page}&perPageNum=${cri.perPageNum}&loc=${cri.location}";
		$(location).attr("href",str);
	};
	function deleteProject(ProjectNum){
		if(confirm("정말 삭제하시겠습니까?")){
			
		}else{
			
		}
	};
	function userInfo(memberNum){
		$(".modal-header").empty();
		$(".modal-body").empty();
		var url="${pageContext.request.contextPath }/member/userInfo.do?no="+memberNum;
		$.getJSON(url, function(data){
			$.each(data, function(key, value){
				if(key=='userInfo'){
					$(".modal-header").append("<h3>"+value.name+" Info</h3>");
					$(".modal-body").append("<div class='form-inline'><label>Name&nbsp;:&nbsp;</label>"+value.name+"</div>");
					$(".modal-body").append("<div class='form-inline'><label>Career&nbsp;:&nbsp;</label>"+value.career+"</div>");
					$(".modal-body").append("<div class='form-inline'><label>Pay Step&nbsp;:&nbsp;</label>"+value.paystep+"</div>");
					$(".modal-body").append("<div class='form-inline'><label>Department&nbsp;:&nbsp;</label>"+value.department+"</div>");
					$(".modal-body").append("<div class='form-inline'><label>E-mail&nbsp;:&nbsp;</label>"+value.email+"</div>");
				}
				if(key=='skills'){
					$(".modal-body").append("<div class='form-inline'><label>----------------------------------------------------</label></div>");
					$(".modal-body").append("<div class='form-inline'><label>Skill&nbsp;:&nbsp;</label>"+value.name+"/"+value.skilllevel+"</div>");
				}
			});
		});
	};
</script>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/menu/sidebar.jsp" flush="false"/>
<jsp:include page="/WEB-INF/jsp/menu/top.jsp" flush="false"/>
<div class="container">
	<div class="row">
	<!-- Modal -->
	<div class="modal fade" id="userInfoModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
 				<div class="modal-body"></div>
 				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
 		</div>
	</div>
		<div class="col-md-12 borderBox">
			<ul class="breadcrumb">
    			<li><a href="${pageContext.request.contextPath }/main.do">Home</a></li>
   				<li class="active">Project</li>  
  			</ul>
		</div>
		<form id="frm">
			<input type="hidden" name="no" id="no">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
			<input type="hidden" name="loc" value="project">
		</form>
		<div class="col-md-12 borderBox" >
		<table class="table table-hover" style="width: 100%;">
			<thead>
				<tr>
					<th width="300px">Project Name</th>
					<th width="150px">Join Member</th>
					<th width="80px">Position</th>
					<th width="100px">Join Day</th>
					<th width="100px">Out Day</th>
					<c:choose>
						<c:when test="${sessionScope.loginUser.id ne 'admin'}">
						</c:when>
						<c:when test="${sessionScope.loginUser.id eq 'admin'}">
							<th width="100px">Modify</th>
							<th width="100px" align="right">Delete</th>
						</c:when>
					</c:choose>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="9" align="center">
							This Board Is empty
						</td>
					</tr>
				</c:if>
				<c:forEach items="${list }" var="idx" varStatus="status">
					<tr>
						<td>${idx.name eq list[status.index+1].name ?'':idx.name}</td>
						<td><a href="#" onclick="userInfo(${idx.mno})"
						data-toggle="modal" data-target="#userInfoModal">${idx.member }</a></td>
						<td>${idx.position}</td>
						<td>${idx.joinday }</td>
						<td>${idx.outday }</td>
						<c:choose>
						<c:when test="${sessionScope.loginUser.id ne 'admin'}">
						</c:when>
						<c:when test="${sessionScope.loginUser.id eq 'admin'}">
							<td><input type="button" class="btn btn-default" value="Modify"></td>
							<td><input type="button" class="btn btn-default" value="Delete" onclick="deleteMember()"></td>
						</c:when>
						</c:choose>
					</tr>		
				</c:forEach>			
			<c:choose>
				<c:when test="${sessionScope.loginUser.id ne 'admin'}">
				</c:when>
				<c:when test="${sessionScope.loginUser.id eq 'admin'}">
						<tr>
							<td colspan="12" align="right">
								<input type="button" class="btn btn-default" value="Add Member" onclick="createItem()">
							</td>
						</tr>
				</c:when>
			</c:choose>	
			</tbody>
			<tfoot>				
				<tr align="center">
					<td colspan="12">
						<div class="text-center">
							<ul class="pagination">
								<c:if test="${pageMaker.prev }">
     					 		<li>
     					 			<a href="list${pageMaker.startPage - 1 }">&laquo;</a>
     					 		</li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li>
									<a href="http://localhost:9090/ProjectManagementSystem/project/list.do?page=${idx }&perPageNum=10">${idx }</a>
								</li>
      							</c:forEach>
								<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
								<li>
									<a href="list${pageMaker.endPage+1 }">&raquo;</a>
								</li>
								</c:if>
							</ul>
						</div>
					</td>			
				</tr>
			</tfoot>
		</table>
		</div>
	</div>
</div>
</body>
</html>