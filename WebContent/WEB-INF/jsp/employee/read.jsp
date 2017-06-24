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
		var rank="${readMember.member_rank}";
		$("#rank").val(rank).attr("selected","selected");
		
		var idnumber="${readMember.member_idnumber}".split("-");
		$("#idnumber1").val(idnumber[0]);
		$("#idnumber2").val(idnumber[1]);
		$("#idnumber1, #idnumber2").attr("readonly", "readonly");
		
		if(idnumber[1].substring(0,1)=='1' || idnumber[1].substring(0,1)=='3'){
			$("#gender").val("남");
		}else if(idnumber[1].substring(0,1)=='2' || idnumber[1].substring(0,1)=='4'){
			$("#gender").val("여");
		}
	});
	function modifyMember(no){
		$(location).attr("href",'${pageContext.request.contextPath }/member/modifyForm.do?page=${cri.page}&perPageNum=${cri.perPageNum}&mno='+no);
	}
	function deleteMember(no){
		if(confirm("정말 삭제하시겠습니까?")){
			if(confirm("삭제 하시면 되돌릴 수 없습니다.\n정말 삭제하시겠습니까?")){
				$(location).attr('href','${pageContext.request.contextPath }/member/remove.do?page=${cri.page}&perPageNum=${cri.perPageNum}&mno='+no);
			}else{
				
			}
		}else{
			
		}
	}
	function goList(){
		$(location).attr("href",'${pageContext.request.contextPath }/member/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}');
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
   				<li><a href="${pageContext.request.contextPath }/member/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}">Member</a></li>   
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
								<input type="text" placeholder="Please Write Name" class="form-control" value="${readMember.member_name }" readonly="readonly">
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
								<input type="text" name="company" class="form-control" value="${readMember.member_company }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>
								Join Company Date
							</th>
							<td>
								<input type="text" name="joincompany" class="form-control" value="${readMember.member_join }" readonly="readonly">
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
								<input type="text" class="form-control" value="${readMember.member_isnew }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>
								Position
							</th>
							<td colspan="3">
								<input type="text" name="position" class="form-control" id="position" value="${readMember.member_position }" readonly="readonly">
							</td>
							
						</tr>
						<tr>
							<th>
								Have Skills
							</th>
							<td colspan="3">
								<input type="text" name="haveskills" class="form-control" id="skills" value="${readMember.member_haveskill }" readonly="readonly">
							</td>
							
						</tr>
						<tr>
							<th>
								ID Number
							</th>
							<td colspan="3">
								<input type="text" name="idnumber1" class="form-control" maxlength="6" id="idnumber1">&nbsp;-
								<input type="text" name="idnumber2" class="form-control" maxlength="7" id="idnumber2">
							</td>
							
						</tr>
						<tr>
							<th>Address</th>
							<td colspan="3">
								<input type="text" name="zipcode" id="zipcode" class="form-control" readonly="readonly" value='${readMember.member_zipcode }'>
								<input type="text" name="address" id="address" class="form-control" readonly="readonly" value="${readMember.member_address }">
								<input type="text" name="address_detail" id="address_detail" class="form-control" readonly="readonly" value="${readMember.member_address_detail }">
							</td>
						</tr>
					</tbody>
				</table>
				<c:if test="${not empty readCareer }">
					<table class="table table-default exp_line_box">
					<thead>
						<tr>
							<th colspan="12"><h3>Experience</h3></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${readCareer }" var="idx">
							<tr>
								<th width="50px">Period Start</th>
								<td><input type="text" class="form-control" value="${idx.period_start }" readonly="readonly" style="width: 100px"></td>
								<th width="50px">Period End</th>
								<td><input type="text" class="form-control" value="${idx.period_end }" readonly="readonly" style="width: 100px"></td>
								<th width="50px">Career Date</th>
								<td>
									<fmt:parseNumber value="${idx.period_start.time / (1000 * 60 * 60 * 24) }" integerOnly="true" var="start"/>
									<fmt:parseNumber value="${idx.period_end.time / (1000 * 60 * 60 * 24) }" integerOnly="true" var="end"/>
									<fmt:parseNumber integerOnly="true" value="${(end - start) / 365 }" var="year" />
									<fmt:parseNumber integerOnly="true" value="${((end - start) / 30)%12}" var="month" />
									<input type="text" value='${year > 0 ? year:"" }<c:out value="${year > 0 ? '년':'' }" />${month > 0 ? month:"" }<c:out value="${month > 0 ? '개월':'경력없음' }" />'
									 class="form-control" readonly="readonly" style="width: 100px">
								</td>
								<th width="100px">Company</th><td><input type="text" class="form-control" value="${idx.company }" readonly="readonly"></td>
								<th width="100px">Rank</th><td><input type="text" class="form-control" value="${idx.rank }" readonly="readonly" style="width: 100px"></td>
								<th width="100px">Position</th><td><input type="text" class="form-control" value="${idx.position }" readonly="readonly"></td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</c:if>
				<c:if test="${not empty readLicense}">
					<table class="table table-default license_line_box">
				<thead>
					<tr>
						<th colspan="6"><h3>License</h3></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${readLicense }" var="idx">
					<tr>
						<th width="100px">Name</th>
						<td><input type="text" class="form-control" value="${idx.name }" readonly="readonly"></td>
						<th width="100px">Level</th>
						<td><input type="text" class="form-control" value="${idx.level }" readonly="readonly"></td>
						<th width="100px">Get Date</th>
						<td><input type="text" class="form-control" value="${idx.getdate }" readonly="readonly"></td>
						<th width="200px">Publisher</th>
						<td><input type="text" class="form-control" value="${idx.publisher }" readonly="readonly"></td>
					</tr>
				</c:forEach>
				</tbody>
				</table>
				</c:if>
				<div class="col-md-4 buttonBox">
					<input type="button" class="btn btn-default" value="Modify" onclick="modifyMember(${readMember.member_no})">
					<input type="button" class="btn btn-default" value="Delete" onclick="deleteMember(${readMember.member_no})">
					<input type="button" class="btn btn-default" value="List" onclick="goList()">
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>