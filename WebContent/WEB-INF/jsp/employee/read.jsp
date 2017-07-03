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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/script.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<script>
	$(document).ready(function(){
		var rank="${employee.rank}";
		
		$("#rank").val(rank).attr("selected","selected");
		
		$("#idnumber1, #idnumber2").attr("readonly", "readonly");
		var idnumber=$("#idnumber2").val()
		if(Number(idnumber.substring(0,1))%2==0){
			$("#gender").val("여");
		}else{
			$("#gender").val("남");
		}
	});
	function modifyMember(no){
		$(location).attr("href",'${pageContext.request.contextPath }/employee/modify.do?page=${cri.page}&perPageNum=${cri.perPageNum}&no='+no);
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
	function goList(){
		$(location).attr("href",'${pageContext.request.contextPath }/employee/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}');
	}
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
			<form class="form-inline">
				<table class="table table-hover" style="width: 100%;">
					<thead>
						<tr>
							<th colspan="4"><h3>Member Basic Info</h3></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th width="200px">Name</th>
							<td>
								<input type="text" placeholder="Please Write Name" class="form-control" value="${employee.name }" readonly="readonly">
							</td>
							<th>Gender</th>
							<td><input type="text" class="form-control" id="gender" readonly="readonly"></td>
						</tr>
						<tr>
							<th>Rank</th>
							<td>
								<select class="form-control" name="rank" id="rank" disabled="disabled">
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
							<th>Company</th>
							<td>
								<input type="text" name="company" class="form-control" value="${employee.company }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>
								Join Company Date
							</th>
							<td>
								<input type="text" name="joincompany" class="form-control" value="${employee.join }" readonly="readonly">
							</td>
							<th>
								Out Company Date
							</th>
							<td>
								<input type="text" name="outcompany" class="form-control" value="" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>
								Work
							</th>
							<td>
								<input type="text" class="form-control" value="${employee.isnew }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>
								Position
							</th>
							<td colspan="3">
								<input type="text" name="position" class="form-control" id="position" value="${employee.position }" readonly="readonly">
							</td>
							
						</tr>
						<tr>
							<th>
								Have Skills
							</th>
							<td colspan="3">
								<input type="text" name="haveskills" class="form-control" id="skills" value="${employee.haveskill }" readonly="readonly">
							</td>
							
						</tr>
						<tr>
							<th>
								ID Number
							</th>
							<td colspan="3">
								<input type="text" name="idnumber1" class="form-control" maxlength="6" id="idnumber1" value="${employee.idnumber1 }">&nbsp;-
								<input type="text" name="idnumber2" class="form-control" maxlength="7" id="idnumber2" value="${employee.idnumber2 }">
							</td>
							
						</tr>
						<tr>
							<th>Address</th>
							<td colspan="3">
								<input type="text" name="zipcode" id="zipcode" class="form-control" readonly="readonly" value='${employee.zipcode }'>
								<input type="text" name="address" id="address" class="form-control" readonly="readonly" value="${employee.address }">
								<input type="text" name="address_detail" id="address_detail" class="form-control" readonly="readonly" value="${employee.address_detail }">
							</td>
						</tr>
					</tbody>
				</table>
				<c:if test="${not empty careerList }">
					<table class="table table-default exp_line_box">
					<thead>
						<tr>
							<th colspan="12"><h3>Experience</h3></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${careerList }" var="idx">
							<tr>
								<th width="50px">Period Start</th>
								<td><input type="text" class="form-control" value="${idx.period_start }" readonly="readonly" style="width: 100px"></td>
								<th width="50px">Period End</th>
								<td><input type="text" class="form-control" value="${idx.period_end }" readonly="readonly" style="width: 100px"></td>
								<th width="100px">Career Date</th>
								<td>
									${idx.getDateDifference() }
								</td>
								<th width="80px">Company</th><td><input type="text" class="form-control" value="${idx.period_company }" readonly="readonly" style="width: 100px;"></td>
								<th width="100px">Rank</th><td><input type="text" class="form-control" value="${idx.period_rank }" readonly="readonly" style="width: 100px"></td>
								<th width="100px">Position</th><td><input type="text" class="form-control" value="${idx.period_position }" readonly="readonly" style="width: 100px;"></td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</c:if>
				<c:if test="${not empty licenseList}">
					<table class="table table-default license_line_box">
				<thead>
					<tr>
						<th colspan="6"><h3>License</h3></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${licenseList }" var="idx">
					<tr>
						<th width="100px">Name</th>
						<td><input type="text" class="form-control" value="${idx.license_name }" readonly="readonly"></td>
						<th width="100px">Level</th>
						<td><input type="text" class="form-control" value="${idx.license_level }" readonly="readonly"></td>
						<th width="100px">Get Date</th>
						<td><input type="text" class="form-control" value="${idx.license_date }" readonly="readonly"></td>
						<th width="200px">Publisher</th>
						<td><input type="text" class="form-control" value="${idx.license_publisher }" readonly="readonly"></td>
					</tr>
				</c:forEach>
				</tbody>
				</table>
				</c:if>
				<div class="col-md-4 buttonBox">
					<input type="button" class="btn btn-default" value="Modify" onclick="modifyMember(${employee.no})">
					<input type="button" class="btn btn-default" value="Delete" onclick="deleteMember(${employee.no})">
					<input type="button" class="btn btn-default" value="List" onclick="goList()">
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>