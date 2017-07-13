<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
var career=new Array();
<c:forEach items="${career }" var="car">
var map={"no":"${car.period_no}","mno":"${car.member_no}","start":"${car.period_start}","end":"${car.period_end}",
				"company":"${car.period_company}", "rank":"${car.period_rank}","position":"${car.period_position}"};
career.push(map);
</c:forEach>
	function back(){
		$(location).attr("href","${pageContext.request.contextPath }/project/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}&location=${cri.location}");
	};
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
    			<li><a href="${pageContext.request.contextPath }/index.do">Home</a></li>
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
								<input type="text" placeholder="Please Write Name" class="form-control" name="name" readonly="readonly" value="${project.name }">
							</td>
						</tr>
						<tr>
							<th>Content</th>
							<td>
								<input type="text" placeholder="Please Write Content" class="form-control" name="content" readonly="readonly" value="${project.content }">
							</td>
						</tr>
						<tr>
							<th>Start Day</th>
							<td>
								<input type="text" placeholder="Please Click And Select Date" class="form-control" name="startday" id="startday" readonly="readonly" value="${project.start }">
							</td>
						</tr>
						<tr>
							<th>End Day</th>
							<td>
								<input type="text" placeholder="Please Click And Select Date" class="form-control" name="endday" id="endday" readonly="readonly" value="${project.end }">
							</td>
						</tr>
						<tr>
							<th>Order Company</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="ordercompany" readonly="readonly" value="${project.order_company }">
							</td>
						</tr>
						<tr>
							<th>Create Skill</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="createskill" id="createskill" value="${project.create_skill }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>ETC</th>
							<td>
								<input type="text" placeholder="Please Write Date" class="form-control" name="etc" value="${project.etc }" readonly="readonly">
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
				<table class="table table-default">
					<thead>
						<tr>
							<th>Name</th>
							<th>Career</th>
							<th>Have<br>Skill</th>
							<th>Position</th>
							<th>Is New</th>
							<th>Join<br>Day</th>
							<th>Out<br>Day</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${employeeList }" var="idx">
							<tr>
								<td>
									<a href="">
										${idx.name }
									</a>
								</td>
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
								<td>
									<c:set var="skill" value="${fn:split(idx.haveskill, ',') }"/>
									<select class="form-control" name="skills" id="skills">
										<c:forEach items="${skill }" var="sk">
											<option value="${sk }">${sk }</option>
										</c:forEach>
									</select>
								</td>
								<td>${idx.position }</td>
								<td>${idx.isnew }</td>
								<c:forEach items="${joinList }" var="join">
									<c:if test="${idx.no eq join.mno }">
										<td>${join.join }</td>
										<td>${join.out }</td>
									</c:if>
								</c:forEach>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
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