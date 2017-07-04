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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
function addMember(){
	$("#frm").attr("action","${pageContext.request.contextPath }/projectjoin/register.do");
	$("#frm").attr("method", "POST");
	$("#frm").submit();
}
function getProjectInfo(){
	jsonUrl="${pageContext.request.contextPath }/projectjoin/selectProjectInfo.do?projectSelectNum="+$("#selectProject option:selected").val();
	$.getJSON(jsonUrl, function(date){
		$(date).each(function(){
			$("#projectInfoName").val(this.projectSelectInfo.name);
			$("#projectInfoContent").val(this.projectSelectInfo.content);
			$("#projectInfoStart").val(this.projectSelectInfo.start);
			$("#projectInfoEnd").val(this.projectSelectInfo.end);
			$("#projectInfoSkill").val(this.projectSelectInfo.create_skill);
			$("#projectInfoOrder").val(this.projectSelectInfo.order_company);
			$("#projectInfoETC").val(this.projectSelectInfo.etc);
		});
	});
}
function getShowMoreEmployee(){
	var startNum=$("#lastNum").val();
	startNum=parseInt(startNum);
	jsonUrl="${pageContext.request.contextPath }/projectjoin/moreShowMember.do?startNum="+(startNum+1)+"&endNum="+(startNum+5);
	var str;
	$.getJSON(jsonUrl, function(date){
		$(date).each(function(){
			for(var idx=0;idx<this.employeeList.length;idx++){
				var skillSplit=this.employeeList[idx].haveskill.split(",");
				str="<tr>"
				str+="<td><input type='checkbox' class='checkbox' value='"+this.employeeList[idx].no+"' name='member_no'></td>"
				str+="<td>"+this.employeeList[idx].name+"</td>"
				str+="<td>"
				for(var crd=0;crd<this.careerList.length;crd++){
					if(this.employeeList[idx].no==this.careerList[crd].member_no){
						str+=parseInt(this.careerList[crd].totalCareer);;
					}
				}
				str+="</td>"
				str+="<td><select class='form-control' id='skills'>"
				for(var skd=0;skd<skillSplit.length;skd++){
					str+="<option>"+skillSplit[skd]+"</option>"
				}
				str+="</select></td>"
				str+="<td><input type='text' class='form-control' name='position'></td>"
				str+="<td><input type='text' class='form-control' name='join' readonly='readonly'></td>"
				str+="<td><input type='text' class='form-control' name='out' readonly='readonly'></td>"
				str+="</tr>"
				$(".employeeTableList").append(str);
				setDatePicketInit();
				if(idx==this.employeeList.length-1){
					$("#lastNum").val(this.employeeList[this.employeeList.length-1].rowNum);
				}
			}
		});
	});
}
$(document).ready(function(){
	getProjectInfo();
	$("#selectProject").on("change", function(){
		getProjectInfo();
	});
	setDatePicketInit();
});
function setDatePicketInit(){
	$("input[name='join']").datepicker({
		dateFormat:'yy-mm-dd',
		changeMonth: true, 
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달' });
	$("input[name='out']").datepicker({
		dateFormat:'yy-mm-dd',
		changeMonth: true, 
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달' });
	$("#changeProject").on("click", function(){
		if(confirm("현재 선택된 프로젝트 이외의 프로젝트를 선택하시겠습니까?")){
			$("#selectProject").prop("disabled", false);
		}else{
			return;
		}
	});
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
		<input type="hidden" name="pno">
		<table class="table table-default" style="background-color: #e4e4e4">
			<thead>
				<tr>
					<th width="100px">
						Currently<br>Selected<br>Project
					</th>
					<td width="400px" colspan="12">
						<select class="form-control" disabled="disabled" id="selectProject">
							<c:forEach items="${project }" var="idx">
								<c:if test="${projectNum eq idx.no }">
									<option value="${idx.no }" selected="selected">${idx.name }</option>
								</c:if>
								<c:if test="${projectNum ne idx.no }">
									<option value="${idx.no }">${idx.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
					<td width="150px">
						<input type="button" class="btn btn-default" value="Change Porject" id="changeProject">
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="14"><h4>Project Info</h4></td>
				</tr>
				<tr>
					<th>Name</th><td><input type="text" class="form-control" id="projectInfoName" readonly="readonly"></td>
					<th>Content</th><td><input type="text" class="form-control" id="projectInfoContent" readonly="readonly"></td>
					<th>Start Day</th><td><input type="text" class="form-control" id="projectInfoStart" readonly="readonly"></td>
					<th>End Day</th><td><input type="text" class="form-control" id="projectInfoEnd" readonly="readonly"></td>
					<th>Create<br>Skill<td><input type="text" class="form-control" id="projectInfoSkill" readonly="readonly"></td>
					<th>Order<br>Company<td><input type="text" class="form-control" id="projectInfoOrder" readonly="readonly"></td>
					<th>ETC</th><td><input type="text" class="form-control" id="projectInfoETC" readonly="readonly"></td>
				</tr>
			</tbody>
			<tfoot>
			</tfoot>
		</table>
			<table class="table table-default">
				<thead>
					<tr>
						<th width="10px">
							<input type="checkbox" class="checkbox">
						</th>
						<th width="100px">Name</th>
						<th width="100px">Career</th>
						<th width="150px">Have Skills</th>
						<th>Position</th>
						<th width="150px">Start Day</th>
						<th width="150px">End Day</th>
					</tr>
				</thead>
				<tbody class="employeeTableList">
					<c:forEach items="${employee }" var="idx" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" class="checkbox" value="${idx.no }" name="member_no">
							</td>
							<td>
								${idx.name }
								<c:if test="${status.last }">
									<input type="hidden" value="${idx.rowNum }" id="lastNum">
								</c:if>
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
							<select class="form-control" id="skills">
							<c:forEach items="${skill }" var="sk">
								<option value="${sk }">${sk }</option>
							</c:forEach>
						</select>
						</td>
						<td>
							<input type="text" class="form-control" name="position">
						</td>
						<td>
							<input type="text" class="form-control" name="join" readonly="readonly">
						</td>
						<td>
							<input type="text" class="form-control" name="out" readonly="readonly">
						</td>
					</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="7" align="right">Member More Show
							<a class="btn btn-default glyphicon glyphicon-plus" onclick="getShowMoreEmployee()"></a>
						</td>
					</tr>
					<tr>
						<td colspan="7" align="right">
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