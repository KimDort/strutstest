<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="${pageContext.request.contextPath }/js/employee.js"></script>
<script src="${pageContext.request.contextPath }/js/address.js"></script>
<script src="${pageContext.request.contextPath }/js/memberValidate.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<script>
$(window).load(function(){
	$("select[name='employee.rank']").val("${employee.rank}").prop("selected", true);
	$("select[name='employee.isnew']").val("${employee.isnew}").prop("selected", true);
	if($("select[name='employee.isnew']").val()=="Career"){
		$("#career-group").show();
	}
	parameterInit();
});
function parameterInit(){
	if("${val}"!=""){
		alert("${val.message}");
		var focusVal="${val.focus}".split(".")[1];
		if(focusVal=="rank" || focusVal=="period_rank"){
			$("select[name='${val.focus}']").eq("${val.index}").focus();
		}else{
			$("input[name='${val.focus}']").eq("${val.index}").focus();
		}
	}
	<c:if test="${not empty careerList}">
	<c:forEach items="${careerList }" var="idx" varStatus="status">
		<c:if test="${status.index eq 0}">
		$("select[name='base_rank']").val("${idx.period_rank}").attr("selected","selected");
		</c:if>
		<c:if test="${status.index ne 0}">
		$("select[name='career.period_rank']").eq(("${status.index}"*1)-1).val("${idx.period_rank}").attr("selected","selected");
		</c:if>
	</c:forEach>	
	</c:if>
};
$(document).ready(function(){
	$("#submititem").on("click", function(){
		if(confirm("Would you like to modify?")){
			$("#frm").submit();
		}else{
			return;
		}	
	});	
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/menu/sidebar.jsp" flush="false" />
	<jsp:include page="/WEB-INF/jsp/menu/top.jsp" flush="false" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 borderBox">
			<ul class="breadcrumb">
    			<li><a href="${pageContext.request.contextPath }/main.do">Home</a></li>
   				<li><a href="${pageContext.request.contextPath }/employee/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}">Member</a></li>   
   				<li class="active">Member Create</li>     
  			</ul>
			</div>
			<div class="col-md-12 borderBox" >
			<form class="form-inline" id="frm" action="${pageContext.request.contextPath }/employee/modifyDone.do" method="post">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
			<input type="hidden" name="no" value="${employee.no }">
				<table class="table table-hover" style="width: 100%;">
					<thead>
						<tr>
							<th colspan="4"><h3>Add Member Basic</h3></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th width="200px">Name</th>
							<td>
								<input type="text" placeholder="Please Write Name" class="form-control" name="employee.name" id="name" value="${employee.name }">
							</td>
							<th>Company</th>
							<td>
								<input type="text" name="employee.company" class="form-control" id="company" value="${employee.company }">
							</td>
						</tr>
						<tr>
							<th>Rank</th>
							<td>
								<select class="form-control" name="employee.rank" id="rank">
									<option>Chairman</option>
									<option>Vice Chairman</option>
									<option>CEO</option>
									<option>Executive Vice President</option>
									<option>Managing Director</option>
									<option>Director</option>
									<option>Deputy General Manager</option>
									<option>Manager</option>
									<option>Assistant Manager</option>
									<option>Chief</option>
									<option>Associate</option>
									<option>Staff</option>
									<option>Intern</option>
								</select>
							</td>
							<th>Position/Work</th>
							<td><input type="text" class="form-control" id="position" name="employee.position" value="${employee.position }"></td>
						</tr>
						<tr>
							<th>
								Join Company Date
							</th>
							<td>
								<input type="text" name="employee.join" class="form-control" readonly="readonly" id="joincompany" value="${employee.join }">
							</td>
							<th>
								Out Company Date
							</th>
							<td>
								<input type="text" name="employee.out" class="form-control" readonly="readonly" id="outcompany" value="${employee.out }">
							</td>
						</tr>
						<tr>
							<th>
								Work
							</th>
							<td>
								<select class="form-control" name="employee.isnew" id="isnew">
									<option value="New">New</option>
									<option value="Career">Career</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>
								Have Skills
							</th>
							<td colspan="3">
								<input type="text" name="employee.haveskill" class="form-control" id="skills" placeholder="JAVA, SPRING, ..." value="${employee.haveskill }">
							</td>
							
						</tr>
						<tr>
							<th>
								ID Number
							</th>
							<td colspan="3">
								<input type="text" name="employee.idnumber1" class="form-control" maxlength="6" id="idnumber1" placeholder="123456" value="${employee.idnumber1 }">&nbsp;-
								<input type="text" name="employee.idnumber2" class="form-control" maxlength="7" id="idnumber2" placeholder="1234567" value="${employee.idnumber2 }">
							</td>
							
						</tr>
						<tr>
							<th>Address</th>
							<td colspan="3">
								<input type="text" name="employee.zipcode" id="zipcode" class="form-control" readonly="readonly" value="${employee.zipcode }">
								<input type="text" name="employee.address" id="address" class="form-control" readonly="readonly" value="${employee.address }">
								<input type="text" name="employee.address_detail" id="address_detail" class="form-control" value="${employee.address_detail }">
								<input type="button" class="btn btn-default" value="Search" onclick="address_search()" id="search">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12 form-inline">
							<div class="form-group"><h3>Experience</h3></div>
							<div class="form-group" style="float: right;">
								<a class="btn btn-default" id="addCareer">
									<span class="glyphicon glyphicon-plus"></span>
								</a>
							</div>
						</div>
					</div>
					<div class="row" id="period_box">
						<c:if test="${empty careerList }">
						</c:if>
						<c:if test="${not empty careerList }">
						<c:forEach items="${careerList }" var="idx" varStatus="status">
						<c:if test="${status.index eq 0 }">
							<div class="col-md-12 form-inline" id="period_line">
							<div class="form-group">
								<label>Period</label>
								<input type="text" class="form-control" style="width:100px" readonly="readonly" value="${idx.period_start }" name="base_start">&nbsp;~
								<input type="text" class="form-control" style="width:100px" readonly="readonly" value="${idx.period_end }" name="base_end">
							</div>
							<div class="form-group">
								<label>Company</label>
								<input type="text" class="form-control" id="period_company" value="${idx.period_company }" readonly="readonly" name="base_company">
							</div>
							<div class="form-group">
								<label>Rank</label>
								<input type="hidden" name="base_rank" value="${idx.period_rank }">
								<select class="form-control" id="period_rank" disabled="disabled" style="width: 150px" name="base_rank">
									<option value=""></option>
									<option value="Chairman">Chairman</option>
									<option value="Vice Chairman">Vice Chairman</option>
									<option value="CEO">CEO</option>
									<option value="Executive Vice President">Executive Vice President</option>
									<option value="Managing Director">Managing Director</option>
									<option value="Director">Director</option>
									<option value="Deputy General Manager">Deputy General Manager</option>
									<option value="Manager">Manager</option>
									<option value="Assistant Manager">Assistant Manager</option>
									<option value="Chief">Chief</option>
									<option value="Associate">Associate</option>
									<option value="Staff">Staff</option>
									<option value="Intern">Intern</option>
								</select>
							</div>
							<div class="form-group">
								<label>Position/Work</label>
								<input type="text" class="form-control" id="period_position" value="${idx.period_position }" readonly="readonly" name="base_position">
							</div>
							</div>
						</c:if>	
						<c:if test="${status.index ne 0 }">
							<div class="col-md-12 form-inline" id="period_line">
							<div class="form-group">
								<label>Period</label>
								<input type="text" class="form-control" name="career.period_start"style="width:100px" readonly="readonly" value="${idx.period_start }">&nbsp;~
								<input type="text" class="form-control" name="career.period_end" style="width:100px" readonly="readonly" value="${idx.period_end }">
							</div>
							<div class="form-group">
								<label>Company</label>
								<input type="text" class="form-control" name="career.period_company" id="period_company" value="${idx.period_company }">
							</div>
							<div class="form-group">
								<label>Rank</label>
								<select class="form-control" id="period_rank" name="career.period_rank" style="width: 150px">
									<option value=""></option>
									<option value="Chairman">Chairman</option>
									<option value="Vice Chairman">Vice Chairman</option>
									<option value="CEO">CEO</option>
									<option value="Executive Vice President">Executive Vice President</option>
									<option value="Managing Director">Managing Director</option>
									<option value="Director">Director</option>
									<option value="Deputy General Manager">Deputy General Manager</option>
									<option value="Manager">Manager</option>
									<option value="Assistant Manager">Assistant Manager</option>
									<option value="Chief">Chief</option>
									<option value="Associate">Associate</option>
									<option value="Staff">Staff</option>
									<option value="Intern">Intern</option>
								</select>
							</div>
							<div class="form-group">
								<label>Position/Work</label>
								<input type="text" class="form-control" id="period_position" value="${idx.period_position }" name="career.period_position">
								<span class="btn btn-default glyphicon glyphicon-minus career-minus"></span>
							</div>
							</div>
						</c:if>					
						</c:forEach>
						</c:if>
					</div>
				</div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12 form-inline">
							<div class="form-group"><h3>License</h3></div>
							<div class="form-group" style="float: right;">
								<a class="btn btn-default" id="addLicense">
									<span class="glyphicon glyphicon-plus"></span>
								</a>
							</div>
						</div>
					</div>
					<div class="row" id="license_box">
						<c:if test="${empty licenseList }">
						</c:if>
						<c:if test="${not empty licenseList }">
						<c:forEach items="${licenseList }" var="idx">
						<div class="col-md-12 form-inline" id="license_line">
						<input type="hidden" name="license_no" value="${idx.license_no }">
							<div class="form-group">
								<label>Name</label>
								<input type="text" class="form-control" id="license_name" name="license.license_name" value="${idx.license_name }">
							</div>
							<div class="form-group">
								<label>Level</label>
								<input type="text" class="form-control" id="license_level" name="license.license_level" value="${idx.license_level }">
							</div>
							<div class="form-group">
								<label>Get Date</label>
								<input type="text" class="form-control" name="license.license_date" readonly="readonly" value="${idx.license_date }">
							</div>
							<div class="form-group">
								<label>Publisher</label>
								<input type="text" class="form-control" id="license_Publisher" name="license.license_publisher" value="${idx.license_publisher }">
								<span class="btn btn-default glyphicon glyphicon-minus license-minus"></span>
							</div>
							</div>
						</c:forEach>
						</c:if>
					</div>
				</div>
				<div class="col-md-4 buttonBox">
					<input type="button" class="btn btn-default" value="Submit" id="submititem">
					<input type="button" class="btn btn-default" value="Cancel">
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>