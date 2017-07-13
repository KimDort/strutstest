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
var employeeArray = new Array();
var addMoreEmplyee = new Array();
 
<c:forEach items="${careerList }" var="car">
	var map={"no":"${car.period_no}","mno":"${car.member_no}","start":"${car.period_start}","end":"${car.period_end}",
			"company":"${car.period_company}", "rank":"${car.period_rank}","position":"${car.period_position}", 
			"totalCareer":"${car.totalCareer}"};
career.push(map);
</c:forEach>

<c:forEach items="${employeeList }" var="idx">
var map={"no":"${idx.no}","name":"${idx.name}", "rank":"${idx.rank}","position":"${idx.position}",
		"haveskill":"${idx.haveskill}" ,"isnew":"${idx.isnew}"};
employeeArray.push(map);
</c:forEach>

<c:forEach items="${addMoreEmployeeList }" var="idx">
var map={"no":"${idx.no}","name":"${idx.name}", "rank":"${idx.rank}","position":"${idx.position}",
		"haveskill":"${idx.haveskill}" ,"isnew":"${idx.isnew}"};

addMoreEmplyee.push(map);
</c:forEach>
function addMoreMember(){
	var str;
	if(addMoreEmplyee.length<=0){
		str="<table class='table table-default'>"
		+"<tr><td>Member Empty</td></tr>"
		+"<table>";
		$("#addMember_modal_body").append(str);
	}else{
		str="<table class='table table-default'>"
			+"<thead><tr>"
			+"<th><input type='checkbox' class='checkbox' id='allCheck'></th>"
			+"<th>Name</th>"
			+"<th>Career</th>"
			+"<th>Is New</th>"
			+"<th>Company</th>"
			+"</tr></thead>";
		for(var idx=0; idx<addMoreEmplyee.length;idx++){	
			str+="<tr>"
				+"<td><input type='checkbox' class='checkbox' name='addMember' value='"+addMoreEmplyee[idx].no+"'></td>"
				+"<td>"+addMoreEmplyee[idx].name+"</td>"
				+"<td>1년</td>"
				+"<td>"+addMoreEmplyee[idx].isnew+"</td>"
				+"<td>"+addMoreEmplyee[idx].company+"</td>"
				+"</tr>"
		}
		str+="<table>";
		$("#addMember_modal_body").append(str);
	}
}
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
		$("a[id='removeMember']").on("click", function(){
			if(confirm("해당 인원이 삭제 됩니다.\n진행하시겠습니까?")){
				$(this).parent().parent().remove();
			}
		});
		$("#allRemoveMenber").on("click", function(){
			if(confirm("인원 전체를 삭제하시겠습니까?")){
				$("a[id='removeMember']").parent().parent().remove();
			}else{
				
			}
		});
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
    			<li><a href="${pageContext.request.contextPath }/index.do">Home</a></li>
   				<li><a href="${pageContext.request.contextPath }/project/list.do?page=1&perPageNum=10&location=project">Project</a></li>  
   				<li><a href="${pageContext.request.contextPath }/projectjoin/list.do?page=1&perPageNum=10&location=projectjoin">Project Join</a></li>
   				<li class="active">Add Member</li>
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
						<input type="text" class="form-control" value="${project.name }" disabled="disabled">
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="14"><h4>Project Info</h4></td>
				</tr>
				<tr>
					<th>Content</th>
						<td><input type="text" class="form-control" id="projectInfoContent" readonly="readonly" value="${project.content }"></td>
					<th>Start Day</th>
						<td><input type="text" class="form-control" id="projectInfoStart" readonly="readonly" value="${project.start }"></td>
					<th>End Day</th>
						<td><input type="text" class="form-control" id="projectInfoEnd" readonly="readonly" value=${project.end }></td>
					<th>Create<br>Skill</th>
						<td><input type="text" class="form-control" id="projectInfoSkill" readonly="readonly" value="${project.create_skill }"></td>
					<th>Order<br>Company</th>
						<td><input type="text" class="form-control" id="projectInfoOrder" readonly="readonly" value=${project.order_company }></td>
					<th>ETC</th>
						<td><input type="text" class="form-control" id="projectInfoETC" readonly="readonly" value="${project.etc }"></td>
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
						<th width="50px">
							<a class="btn btn-default glyphicon glyphicon-minus" id="allRemoveMenber"></a>
						</th>
					</tr>
				</thead>
				<tbody class="employeeTableList">
					<c:forEach items="${employeeList }" var="idx" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" class="checkbox" value="${idx.no }" name="member_no">
							</td>
							<td>
								${idx.name }
							</td>
							<td>
								<c:set var="totalCareer" value="0"/>
								<c:forEach items="${careerList }" var="car" varStatus="status">
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
						<c:forEach items="${projectJoinList }" var="joinList">
							<c:if test="${idx.no eq joinList.mno }">
								<td>
									<input type="text" class="form-control" name="position" disabled="disabled" value="${joinList.position }">
								</td>
								<td>
									<input type="text" class="form-control" name="join" readonly="readonly" disabled="disabled" value="${joinList.join }">
								</td>
								<td>
									<input type="text" class="form-control" name="out" readonly="readonly" disabled="disabled" value="${joinList.out }">
								</td>
							</c:if>
						</c:forEach>
						<td>
							<a class="btn btn-default glyphicon glyphicon-minus" id="removeMember"></a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="8" align="right">
							<input type="button" value="Add Member" class="btn btn-default" onclick="addMoreMember()"
							data-toggle="modal" data-target="#addMember" onclick="">
							<input type="button" value="Modify" class="btn btn-default" onclick="Modify()">
							<input type="reset" value="List" class="btn btn-default">
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
	<!-- Modal -->
 	<div class="modal fade" id="addMember" role="dialog">
 		<div class="modal-dialog modal-lg">
 			<div class="modal-content">
 				<div class="modal-header">
 					<button type="button" class="close" data-dismiss="modal">&times;</button>
 					<h4 class="modal-title">Add Member</h4>
 				</div>
				<div class="modal-body" id="addMember_modal_body">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>