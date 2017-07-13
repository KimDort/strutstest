<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<script>
	function createItem(){
		$("#frm").attr("action", '${pageContext.request.contextPath }/project/register.do');
		$("#frm").attr("method", "post");
		$("#frm").submit();
	}
	function deleteProject(boardNum){
		if(confirm("정말 삭제하시겠습니까?")){
			$("#no").val(boardNum);
			$("#frm").attr("action", '${pageContext.request.contextPath }/project/remove.do');
			$("#frm").attr("method", "post");
			$("#frm").submit();
		}else{
			
		}
	}
	function modifyProject(boardNum){
		if(confirm("수정하시겠습니까?")){
			$("#no").val(boardNum);
			$("#frm").attr("action", '${pageContext.request.contextPath }/project/modify.do');
			$("#frm").attr("method", "post");
			$("#frm").submit();
		}else{
			
		}
	}
	function changeLink(inmemberNum,projectNum){
		if(inmemberNum==0){
			if(confirm("표시할 인원이 없습니다.\n인원을 추가하시겠습니까?")){
				var str="${pageContext.request.contextPath }/projectjoin/register.do?"
						+"page=${cri.page}&perPageNum=${cri.perPageNum}&projectNum="+projectNum
						+"&location=project";
				$(location).attr("href",str);
			}else{
				
			}
		}else{
			
		}
	}
	
	function addMember(projectNum){
		if(confirm("인원을 추가 하시겠습니까?")){
			var str="${pageContext.request.contextPath }/projectjoin/register.do?"
				+"page=${cri.page}&perPageNum=${cri.perPageNum}&projectNum="+projectNum
				+"&location=project";
				
				$(location).attr("href",str);
		}else{
			return;
		}
	}
	$(document).ready(function(){
		$("#searchProject").on("change", function(){
			if($("#searchProject option:selected").val()=="searcgDate"){
				var str="<div class='form-inline'>"
						+"<input type='text' name='startDay' class='form-control' style='width:45%'>"
						+"~<input type='text' name='endDay' class='form-control' style='width:45%'></div>";
				$("#searchProjectBox").html(str);
				$("input[name='startDay']").datepicker({
					dateFormat:'yy-mm-dd',
					changeMonth: true, 
			        changeYear: true,
			        nextText: '다음 달',
			        prevText: '이전 달' 
				});
				$("input[name='endDay']").datepicker({
					dateFormat:'yy-mm-dd',
					changeMonth: true, 
			        changeYear: true,
			        nextText: '다음 달',
			        prevText: '이전 달' 
				});
			}
		});
	});
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
   				<li class="active">Project</li>  
  			</ul>
		</div>
		<form id="frm">
			<input type="hidden" name="no" id="no">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
			<input type="hidden" name="location" value="project">
		</form>
		<div class="col-md-12 borderBox" >
		<table class="table table-default" style="width:100%;">
			<thead>
				<tr>
					<th colspan="3">Search Project</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td width="200px">
						<select class="form-control" id="searchProject">
							<option value="searchName">Name</option>
							<option value="searchCompany">Company</option>
							<option value="searcgDate">Date</option>
						</select>
					</td>
					<td id="searchProjectBox">
						<input type="text" class="form-control">
					</td>
					<td width="100px">
						<input type="button" class="form-control" value="Search">
					</td>
				</tr>
			</tbody>
		</table>
		<table class="table table-hover" style="width: 100%;">
			<thead>
				<tr>
					<th width="50px">No.</th>
					<th>Project Name</th>
					<th width="50px">In Member</th>
					<th width="150px">Start Day</th>
					<th width="150px">End Day</th>
					<th width="200px">Order Company</th>
					<th width="100px">Create Skill</th>
					<th width="100px">Add Member</th>
					<th width="100px">Modify</th>
					<th width="100px" align="right">Delete</th>
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
				<c:forEach items="${list }" var="idx">
					<tr>
						<td>${idx.no }</td>
						<td>
							<a href="${pageContext.request.contextPath }/project/read.do?pno=${idx.no}&page=${cri.page}&perPageNum=${cri.perPageNum}&location=project">
								${idx.name }
							</a>
						</td>
						<td align="center">${idx.member_count }</td>
						<td>
							${idx.start }
						</td>
						<td>
							${idx.end }
						</td>
						<td>
							${idx.order_company }
						</td>
						<td>
							${idx.create_skill }
						</td>
						<td><input type="button" class="btn btn-default" value="Add" onclick="addMember(${idx.no})"></td>
						<td><input type="button" class="btn btn-default" value="Modify" onclick="modifyProject(${idx.no})"></td>
						<td><input type="button" class="btn btn-default" value="Delete" onclick="deleteProject(${idx.no})"></td>
					</tr>		
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="12" align="right">
						<input type="button" class="btn btn-default" value="Add Project" onclick="createItem()">
					</td>
				</tr>
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
									<a href="http://localhost:8080/ProjectManagementSystem/project/list.do?page=${idx }&perPageNum=10">${idx }</a>
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