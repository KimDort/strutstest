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
var memberNum= new Array();
var positionText = new Array();
var startDate = new Array();
var endDate = new Array();

<c:forEach items="${member_no }" var="idx">
	memberNum.push("${idx}");
</c:forEach>
<c:forEach items="${position }" var="idx">
	positionText.push("${idx}");
</c:forEach>
<c:forEach items="${join }" var="idx">
	startDate.push("${idx}");
</c:forEach>
<c:forEach items="${out }" var="idx">
	endDate.push("${idx}");
</c:forEach>
var career=new Array();
var callMethodCount=0;
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
	$("#frm").attr("action","${pageContext.request.contextPath }/projectjoin/registerDone.do");
	$("#frm").attr("method", "POST");
	if(confirm("사원들을 등록하시겠습니까?")){
		if($("input:checkbox[name='member_no']:checked").length<=0){
			alert("사원을 한명 이상 선택해 주십시오.");
			return;
		}else{
			if($("#selectProject option:selected").val()!=""){
				var projectName=$("#selectProject option:selected").text();
				var selectedMemberNum=$("input:checkbox[name='member_no']:checked").length;
				if(confirm(projectName+"에 "+selectedMemberNum+"명을 등록하시겠습니까?")){
					$("#frm").submit();
				}else{
					return;
				}
			}else{
				alert("프로젝트를 선택하여주십시오.");
			}
		}
	}else{
		return;
	}
	
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
function getShowMoreEmployee(checkNum){
	var startNum=$("#lastNum").val();
	startNum=parseInt(startNum);
	jsonUrl="${pageContext.request.contextPath }/projectjoin/moreShowMember.do?startNum="+(startNum+1)+"&endNum="+(startNum+5);
	var str;
	$.getJSON(jsonUrl, function(date){
		$(date).each(function(){
			for(var idx=0;idx<this.employeeList.length;idx++){
				var skillSplit=this.employeeList[idx].haveskill.split(",");
				var totalCareer=0;
				str="<tr>"
				str+="<td>"
				str+="<input type='checkbox' class='checkbox' value='"+this.employeeList[idx].no+"' name='member_no'>"
				str+=""
				str+="<td>"+this.employeeList[idx].name+"</td>"
				str+="<td>"
				str+="<a data-toggle='modal' data-target='#period' onclick='period("+this.employeeList[idx].no+")'>"
				for(var crd=0;crd<this.careerList.length;crd++){
					if(this.employeeList[idx].no==this.careerList[crd].member_no){
						totalCareer = parseInt(this.careerList[crd].totalCareer);
						if(totalCareer > 0){
							if(totalCareer > 12){					
								str +=  totalCareer / 12 + "년"
								str +=  totalCareer % 12 + "개월"
							}
							if(totalCareer < 12){
								str += totalCareer + "개월"
							}
						}
						
					}
				}
				
				str+="</a></td>"
				str+="<td><select class='form-control' id='skills'>"
				for(var skd=0;skd<skillSplit.length;skd++){
					str+="<option>"+skillSplit[skd]+"</option>"
				}
				str+="</select></td>"
				str+="<td><input type='text' class='form-control' name='position' disabled='disabled'></td>"
				str+="<td><input type='text' class='form-control' name='join' readonly='readonly' disabled='disabled'></td>"
				str+="<td><input type='text' class='form-control' name='out' readonly='readonly' disabled='disabled'></td>"
				str+="</tr>"
				$(".employeeTableList").append(str);
				setDatePicketInit();
				if(idx==this.employeeList.length-1){
					$("#lastNum").val(this.employeeList[this.employeeList.length-1].rowNum);
				}
				if(checkNum!=null){
					for(var checkN=0;checkN<checkNum.length;checkN++){
						if(checkNum[checkN]==this.employeeList[idx].no){
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']").attr("checked","checked");
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']")
								.parent("td").next().next().next().next().children().prop("disabled", false);
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']")
								.parent("td").next().next().next().next().next().children().prop("disabled", false);
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']")
								.parent("td").next().next().next().next().next().next().children().prop("disabled", false);
						}
					}
					for(var checkN=0;checkN<checkNum.length;checkN++){
						if(checkNum[checkN]==this.employeeList[idx].no){
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']")
							.parent("td").next().next().next().next().children().val(positionText[checkN]);
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']")
							.parent("td").next().next().next().next().next().children().val(startDate[checkN]);
							$("input:checkbox[name='member_no'][value='"+checkNum[checkN]+"']")
							.parent("td").next().next().next().next().next().next().children().val(endDate[checkN]);
						}
					}
				}
			}
		});
		callMethodCount++;
		$("#callMemberList").val(callMethodCount);
	});
}

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
}
	$(document).ready(function(){
		getProjectInfo();
		if("${location}"=="projectjoin"){
			$("#selectProject option:eq(0)").attr("selected", "selected");
			var projectNumber=$("#selectProject option:selected").val();
			$("#projectNumber").val(projectNumber);
		}else{
			$("#projectNumber").val("${projectNum}");
		}
		$("#selectProject").on("change", function(){
			var selectVal= $("#selectProject option:selected").val();
			$("#projectNumber").val(selectVal);
			getProjectInfo();
		});
		
		if($("#selectProject").is(":disabled")){
			$("#changeProject").on("click", function(){
				if(confirm("다른 프로젝트를 선택하시겠습니까?")){
					$("#selectProject").removeAttr("disabled");
					return;
				}else{
					return;
				}
			});
		}
		
		if($("#location").val()=="projectjoin"){
			$("#selectProject").removeAttr("disabled");
		}else{
			$("#selectProject").attr("disabled", "disabled");
		}
		
		if("${val.message}"!=""){
			alert("${val.message}");
			
			for(var idx=0;idx<"${callMemberList}";idx++){
				getShowMoreEmployee(memberNum);
			}
			
			for(var idx=0;idx<"${fn:length(member_no)}";idx++){
				//체크된 값 받아서 체크하기
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']").attr("checked","checked");
				//역할 및 직무 값 받아서 입력하기
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']")
				.parent().next().next().next().next().children("input").val(positionText[idx]);	
				//시작일 값 받아서 입력하기
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']")
				.parent().next().next().next().next().next().children("input").val(startDate[idx]);	
				//종료일 값 받아서 입력하기
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']")
				.parent().next().next().next().next().next().next().children("input").val(endDate[idx]);
				//체크된 멤버 disable 해제
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']")
					.parent("td").next().next().next().next().children().prop("disabled", false);
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']")
					.parent("td").next().next().next().next().next().children().prop("disabled", false);
				$("input:checkbox[name='member_no'][value='"+memberNum[idx]+"']")
					.parent("td").next().next().next().next().next().next().children().prop("disabled", false);
			}
			if("${val.focus}"=="position"){
				$("input:checkbox[name='member_no'][value='${val.index}']")
				.parent().next().next().next().next().children().focus();
			}
			if("${val.focus}"=="join"){
				$("input:checkbox[name='member_no'][value='${val.index}']")
				.parent().next().next().next().next().next().children().focus();
			}
			if("${val.focus}"=="out"){
				$("input:checkbox[name='member_no'][value='${val.index}']")
				.parent().next().next().next().next().next().next().children().focus();
			}
		}
		
		$(document).on("click", "input:checkbox[name='member_no']",function(){
			if($(this).is(":checked")){
				removeAttrDisable(this);
			}else{
				setDisabled(this);
			}
		});
		setDatePicketInit();
	});

	function removeAttrDisable(checkbox){
		$(checkbox).parent("td").next().next().next().next().children().prop("disabled", false);
		$(checkbox).parent("td").next().next().next().next().next().children().prop("disabled", false);
		$(checkbox).parent("td").next().next().next().next().next().next().children("input").prop("disabled", false);
	}
	
	function setDisabled(checkbox){
		$(checkbox).parent().next().next().next().next().children("input").attr("disabled", "disabled");
		$(checkbox).parent().next().next().next().next().next().children("input").attr("disabled", "disabled");
		$(checkbox).parent().next().next().next().next().next().next().children("input").attr("disabled", "disabled");
	}
	$(document).on("click", "#allCheck", function(){
		if($("#allCheck").prop("checked")){
			$("input[type=checkbox]").prop("checked", true);
			removeAttrDisable($("input[type=checkbox]"));
		}else{
			$("input[type=checkbox]").prop("checked", false);
			setDisabled($("input[type=checkbox]"));
		}
	});
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
		<input type="hidden" name="location" value="${cri.location }" id="location">
		<input type="hidden" name="pno" id="projectNumber">
		<input type="hidden" name="callMemberList" id="callMemberList">
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
							<input type="checkbox" class="checkbox" id="allCheck">
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
				<c:if test="${empty employee }">
					<tr>
						<td colspan="7" align="center">
							<h4>No Participatant Available</h4>
						</td>
					</tr>
				</c:if>
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
							<input type="text" class="form-control" name="position" disabled="disabled">
						</td>
						<td>
							<input type="text" class="form-control" name="join" readonly="readonly" disabled="disabled">
						</td>
						<td>
							<input type="text" class="form-control" name="out" readonly="readonly" disabled="disabled">
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