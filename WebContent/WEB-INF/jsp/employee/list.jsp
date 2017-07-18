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
	var career=new Array();
	<c:forEach items="${career }" var="car">
	var map={"no":"${car.period_no}","mno":"${car.member_no}","start":"${car.period_start}","end":"${car.period_end}",
					"company":"${car.period_company}", "rank":"${car.period_rank}","position":"${car.period_position}"};
	career.push(map);
	</c:forEach>
	
	function period(no){
		$("#period_modal_body").empty();
		var str="<table class='table table-default'>"
			+"<thead><tr><th colspan='12'><h3>Experience</h3></th></tr></thead><tbody>";
		for(var idx=0;idx<career.length;idx++){
			if(no==career[idx].mno){
					str+="<tr><th width='50px'>Period Start</th>"
						+"<td><input type='text' class='form-control' value='"+career[idx].start+"' style='width:100px;' readonly='readonly'></td>"
						+"<th width='50px'>Period End</th>"
						+"<td><input type='text' class='form-control' value='"+career[idx].end+"' style='width:100px;' readonly='readonly'></td>"
						+"<th width='50px'>Company</th>"
						+"<td><input type='text' class='form-control' value='"+career[idx].company+"' style='width:100px;' readonly='readonly'></td>"
						+"<th width='50px'>Rank</th>"
						+"<td><input type='text' class='form-control' value='"+career[idx].rank+"' style='width:50px;' readonly='readonly'></td>"
						+"<th width='50px'>Position</th>"
						+"<td><input type='text' class='form-control' value='"+career[idx].position+"' style='width:100px;' readonly='readonly'></td>"
						+"</tr>";
			}
		}
		str+="</tbody></table>";
		$("#period_modal_body").append(str);	
	}
	function modifyMember(no){
		$(location).attr("href",'${pageContext.request.contextPath }/employee/modify.do?page=${cri.page}&perPageNum=${cri.perPageNum}&no='+no);
	}
	function createMember(){
		$(location).attr('href','${pageContext.request.contextPath }/employee/register.do?page=${cri.page}&perPageNum=${cri.perPageNum}');
	}
	function deleteMember(no){
		if(confirm("정말 삭제하시겠습니까?")){
			if(confirm("삭제 하시면 되돌릴 수 없습니다.\n정말 삭제하시겠습니까?")){
				$(location).attr('href','${pageContext.request.contextPath }/employee/remove.do?page=${cri.page}&perPageNum=${cri.perPageNum}&no='+no);
			}else{
				
			}
		}else{
			
		}
	}
	
	$(document).ready(function(){
		var listUrl="${pageContext.request.contextPath }/employee/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}";
		
		if("${param.isnew}"!=""){
			$("#search_option").val("${param.isnew}").attr("selected","selected");
		}else{
			$("#search_option option").eq(0).attr("selected","selected");
		}
		if("${param.name}"!=""){
			$("#search_name").val("${param.name}");
		}else{
			$("#search_name").val("");
		}
		if("${param.haveskill}"!=""){
			$("#skill_search").val("${param.haveskill}").attr("selected", "selected");
		}
		$("#search_option").on("change",function(){	
			if($("#search_name").val()!=""){
				listUrl+="&name="+$("#search_name").val();
			}
			if($("#search_option").val()=="All"){
				$(location).attr('href',listUrl);
			}
			if($("#search_option").val()=="New"){
				$(location).attr('href',listUrl+"&isnew=New");
			}
			if($("#search_option").val()=="Career"){
				$(location).attr('href',listUrl+"&isnew=Career");	
			}			
		});
		$("#skill_search").on("change", function(){
			listUrl+="&haveskill="+$("#skill_search").val();
		});
		
		$("#search_option_detail").on("change", function(){
			if($("#search_option_detail").val()=="All"){
				$(location).attr('href',listUrl+"&work=Contract");
			}else{
				$(location).attr('href',listUrl+"&work=Contract&work_detail="+$("#search_option_detail").val());
			}
		});
		
		$("#btn_search").on("click", function(){	
			listUrl+="&name="+$("#search_name").val();
			$(location).attr('href',listUrl);
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
   				<li class="active">Member</li>  
  			</ul>
		</div>
		<form id="frm">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
		</form>
		<div class="col-md-12 borderBox" >
		<table class="table table-default">
			<thead>
				<tr>
					<th colspan="2">Search Name</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>
						<input type="text" class="form-control" name="search" id="search_name">
					</th>
					<td width="100px">
						<select class="form-control" name="search_option" id="search_option">
							<option value="All">All</option>
							<option value="New">New</option>
							<option value="Career">Career</option>
						</select>
					</td>
					<td width="100px">
						<select class="form-control" name="skill_search" id="skill_search">
							<option value=""></option>
							<c:forEach items="${searchSkill }" var="idx">
								<option value="${idx }">${idx }</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<input type="button" class="btn btn-default" value="Search" id="btn_search">
					</td>	
				</tr>
			</tbody>
		</table>
		<table class="table table-hover" style="width: 100%;">
			<thead>
				<tr>
					<th>Name</th>
					<th width="50px">Career</th>
					<th width="50px">Project History</th>
					<th width="150px">Have<br>Skill</th>
					<th width="50px">Rank</th>
					<th width="100px">Join<br>Company</th>
					<th width="50px">Gender</th>
					<th width="100px">Work</th>
					<th width="100px">Modify</th>
					<th width="100px" align="right">Delete</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr>
						<td colspan="10" align="center">
							This Board List Empty
						</td>
					</tr>
				</c:if>
				<c:forEach items="${list }" var="idx" varStatus="status">
				<c:set var="skill" value="${fn:split(idx.haveskill, ',') }"/>
				<tr>
					<td>
						<a href="${pageContext.request.contextPath }/employee/read.do?page=${cri.page}&perPageNum=${cri.perPageNum}&no=${idx.no}">${idx.name }</a>
					</td>
					<td align="center">
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
						<a data-toggle="modal" data-target="#period" onclick="period(${idx.no})">
							<c:if test="${totalCareer > 0 }">
								<c:if test="${totalCareer > 12}">
								<fmt:formatNumber value="${totalCareer/12 }" pattern="0"/>년
								<fmt:formatNumber value="${totalCareer%12 }" pattern="0"/>개월
								</c:if>
								<c:if test="${totalCareer < 12 }">
									<fmt:formatNumber value="${totalCareer }" pattern="0"/>개월
								</c:if>
							</c:if>
						</a>
					</td>
					<td align="center"><a href="#"></a></td>
					<td>
						<select class="form-control" name="skills" id="skills">
							<c:forEach items="${skill }" var="sk">
								<option value="${sk }">${sk }</option>
							</c:forEach>
						</select>
					</td>
					<td>${idx.rank }</td>
					<td>${idx.join }</td>
					<td>
						<c:set var="number" value="${idx.idnumber2 }"/>
						<c:if test="${number.substring(0,1) eq '1' or number.substring(0,1) eq '3'}">
							Man
						</c:if>
						<c:if test="${number.substring(0,1) eq '2' or number.substring(0,1) eq '4'}">
							Woman
						</c:if>
					</td>
					<td>${idx.isnew }</td>
					<td><input type="button" class="btn btn-default" value="Modify" onclick="modifyMember(${idx.no})"></td>
					<td><input type="button" class="btn btn-default" value="Delete" onclick="deleteMember(${idx.no})"></td>
				</tr>
				</c:forEach>
			</tbody>
			<tfoot>		
			<tr>
				<td colspan="11" align="right">
					<input type="button" class="btn btn-default" value="Add Member" onclick="createMember()">
				</td>
			</tr>		
				<tr align="center">
					<td colspan="11">
						<div class="text-center">
							<ul class="pagination">
								<c:if test="${pageMaker.prev }">
     					 		<li>
     					 			<a href="list${pageMaker.startPage - 1 }">&laquo;</a>
     					 		</li>
								</c:if>
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li>
									<a href="${pageContext.request.contextPath }/member/list.do?page=${idx }&perPageNum=10">${idx }</a>
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
<!-- Modal -->
 	<div class="modal fade" id="period" role="dialog">
 		<div class="modal-dialog modal-lg">
 			<div class="modal-content">
 				<div class="modal-header">
 					<button type="button" class="close" data-dismiss="modal">&times;</button>
 					<h4 class="modal-title">Member Career</h4>
 				</div>
				<div class="modal-body" id="period_modal_body">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>