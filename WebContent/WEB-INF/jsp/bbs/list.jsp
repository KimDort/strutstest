<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		$("#frm").attr("action", '${pageContext.request.contextPath }/bbs/registerForm.do');
		$("#frm").attr("method", "post");
		$("#frm").submit();
	}
	function deleteBoard(boardNum){
		if(confirm("정말 삭제하시겠습니까?")){
			$("#no").val(boardNum);
			$("#frm").attr("action", '${pageContext.request.contextPath }/bbs/delete.do');
			//$("#frm").attr("<input type='hidden' name='no' value='"+boardNum+"'>");
			$("#frm").attr("method", "post");
			$("#frm").submit();
		}else{
			
		}
	}
	function modifyBoard(boardNum){
		if(confirm("수정하시겠습니까?")){
			$("#no").val(boardNum);
			$("#frm").attr("action", '${pageContext.request.contextPath }/bbs/modify.do');
			//$("#frm").append("<input type='hidden' name='no' value='"+boardNum+"'>");
			$("#frm").attr("method", "post");
			$("#frm").submit();
		}else{
			
		}
	}
</script>
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
   				<li class="active">Board</li>  
  			</ul>
		</div>
		<form id="frm">
			<input type="hidden" name="no" id="no">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
		</form>
		<div class="col-md-12 borderBox" >
		<table class="table table-hover" style="width: 100%;">
			<thead>
				<tr>
					<th width="50px">No.</th>
					<th>Title</th>
					<th width="100px">Writer</th>
					<th width="150px">Regdate</th>
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
						<td colspan="6" align="center">
							This Board Is empty
						</td>
					</tr>
				</c:if>
				<c:forEach items="${list }" var="idx">
				<c:choose>
					<c:when test="${sessionScope.loginUser.id ne 'admin' and idx.tomember==0}">
					<tr>
						<td>${idx.no }</td>
						<td>
							<a href="${pageContext.request.contextPath }/bbs/read.do?read=${idx.no}&page=${cri.page}&perPageNum=${cri.perPageNum}">
								${idx.title }
							</a>
						</td>
						<td>${idx.writer }</td>
						<td>
							<fmt:parseDate value="${idx.regdate }" pattern="yyyy-MM-dd" var="reg"/>
							<fmt:formatDate value="${reg }" pattern="yyyy-MM-dd"/>
						</td>
						<c:choose>
						<c:when test="${sessionScope.loginUser.id ne 'admin'}">
						</c:when>
						<c:when test="${sessionScope.loginUser.id eq 'admin'}">
							<td><input type="button" class="btn btn-default" value="Modify"></td>
							<td><input type="button" class="btn btn-default" value="Delete" onclick="deleteMember()"></td>
						</c:when>
						</c:choose>
					</tr>
					</c:when>
					<c:when test="${sessionScope.loginUser.id eq 'admin'}">
					<tr>
						<td>${idx.no }</td>
						<td>
							<a href="${pageContext.request.contextPath }/bbs/read.do?read=${idx.no}&page=${cri.page}&perPageNum=${cri.perPageNum}">
								${idx.title }
							</a>
						</td>
						<td>${idx.writer }</td>
						<td>
							<fmt:parseDate value="${idx.regdate }" pattern="yyyy-MM-dd" var="reg"/>
							<fmt:formatDate value="${reg }" pattern="yyyy-MM-dd"/>
						</td>
						<c:choose>
						<c:when test="${sessionScope.loginUser.id ne 'admin'}">
						</c:when>
						<c:when test="${sessionScope.loginUser.id eq 'admin'}">
							<td><input type="button" class="btn btn-default" value="Modify" onclick="modifyBoard(${idx.no})"></td>
							<td><input type="button" class="btn btn-default" value="Delete" onclick="deleteBoard(${idx.no})"></td>
						</c:when>
						</c:choose>
					</tr>
					</c:when>
				</c:choose>			
				</c:forEach>
			</tbody>
			<c:choose>
				<c:when test="${sessionScope.loginUser.id ne 'admin'}">
				</c:when>
				<c:when test="${sessionScope.loginUser.id eq 'admin'}">
					<tfoot>
						<tr>
							<td colspan="12" align="right">
								<input type="button" class="btn btn-default" value="Add Notice" onclick="createItem()">
							</td>
						</tr>
				</c:when>
			</c:choose>					
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
									<a href="http://localhost:9090/ProjectManagementSystem/bbs/list.do?page=${idx }&perPageNum=10">${idx }</a>
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