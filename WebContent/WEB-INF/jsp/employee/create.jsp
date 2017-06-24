<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="${pageContext.request.contextPath }/js/script.js"></script>
<script src="${pageContext.request.contextPath }/js/memberValidate.js"></script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<script>
	function address_search(){
		new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address_detail').focus();
            }
        }).open();
	}
</script>
<script>
	regNumber=/^[0-9]*$/;
	regBigAlphabet=/^[A-Z,\s]*$/;
	$(function(){
		$("input[name='career.period_start']").datepicker({
			dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
		$("input[name='career.period_end']").datepicker({
			dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
		$("input[name='career.license_date']").datepicker({
			dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
		$("input[name='employee.join']").datepicker({
			dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
		$("input[name='employee.out']").datepicker({
			dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
	});
	
	$(document).ready(function(){
		$("#career-group").css("display","none");
		$("#testbtn").on("click",function(){
			testChecker($("#frm"));
		});
		$("#isnew").on("change", function(){
			if($("#isnew option:selected").val()=="New" || $("#isnew option:selected").val()==""){
				$("#career-group").hide();
			}else{
				$("#career-group").show();
			}
		});
		$("#skills").on("keyup",function(event){
			var val=$("#skills").val();
			if(!regBigAlphabet.test(val)){
				alert("영문 대문자만 입력해 주십시오.");
				return;
			}
			if(event.keyCode==32){
				if(val.substring(val.length-2).charCodeAt(0)!=44){
					alert("스킬 구분은 ','로 해주십시오.");
					return;
				}
			}
		});
		
		$("#idnumber1, #idnumber2").on("keyup",function(){		
			var val1=$("#idnumber1").val();
			var val2=$("#idnumber2").val();
			if(!regNumber.test(val1) || !regNumber.test(val2)){
				alert('숫자만 입력해주십시오.');
				return;
			}
		});
		
		$("#addCareer").on("click",function(){
			addCareerItem();
			$("input[name='career.period_start']").datepicker({
				dateFormat:'yy-mm-dd',
				changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달' });
				
			$("input[name='career.period_end']").datepicker({
				dateFormat:'yy-mm-dd',
				changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달' 
			});
			
		});	
		
		$("#addLicense").on("click",function(){
			addLicenseItem();
			$("input[name='license.license_date']").datepicker({
				dateFormat:'yy-mm-dd',
				changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달' });
		});	
		$("#isnew").on("change", function(){
			if($("#rank option:selected").val()=="Intern" && $("#isnew option:selected").val()=="Career"){
				alert("인턴일 경우 경력 사항을 입력하실 수 없습니다.");
				$("#isnew option:eq(0)").attr("selected", "selected");
				$("#career-group").hide();
			}
			if($("#rank option:selected").val()==""){
				alert("직급이 없으면 선택하실 수 없습니다.");
				$("#isnew option:eq(0)").attr("selected", "selected");
				$("#career-group").hide();
			}
		});
		$("#submititem").on("click", function(){
			$("#frm").attr("action","${pageContext.request.contextPath }/employee/registerDone.do");
			$("#frm").attr("method", "post");
			$("#frm").submit();
			/* var checkCareer=$("#isnew option:selected").val();
			
			if(!checkBaseInfo($("#frm"))){
				return;
			}else{
				if(!checkCareerBox(checkCareer)){
					return;
				}else{
					completeInput('${cri.page}', '${cri.perPageNum}');	
					if(!checkDateCareer()){
						return;
					}else if(!checkLicenseBox()){
						return;
					}else{
						
					}
				}			
			} */
		});
	});
	
	$(document).on("click",".license-minus",function(){
		$(this).parent().parent().remove();
	});
	$(document).on("click",".career-minus", function(){
		$(this).parent().parent().remove();
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
   				<li><a href="${pageContext.request.contextPath }/member/list.do?page=${cri.page}&perPageNum=${cri.perPageNum}">Member</a></li>   
   				<li class="active">Member Create</li>     
  			</ul>
			</div>
			<div class="col-md-12 borderBox" >
			<form class="form-inline" id="frm">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
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
								<input type="text" placeholder="Please Write Name" class="form-control" name="employee.name" id="name">
							</td>
							<th>Company</th>
							<td>
								<input type="text" name="employee.company" class="form-control" id="company">
							</td>
						</tr>
						<tr>
							<th>Rank</th>
							<td>
								<select class="form-control" name="employee.rank" id="rank">
									<option></option>
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
							</td>
							<th>Position/Work</th>
							<td><input type="text" class="form-control" id="position" name="employee.position"></td>
						</tr>
						<tr>
							<th>
								Join Company Date
							</th>
							<td>
								<input type="text" name="employee.join" class="form-control" readonly="readonly" id="joincompany">
							</td>
							<th>
								Out Company Date
							</th>
							<td>
								<input type="text" name="employee.out" class="form-control" readonly="readonly" id="outcompany">
							</td>
						</tr>
						<tr>
							<th>
								Work
							</th>
							<td colspan="3">
								<select class="form-control" name="employee.isnew" id="isnew">
									<option></option>
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
								<input type="text" name="employee.haveskill" class="form-control" id="skills" placeholder="JAVA, SPRING, ...">
							</td>
							
						</tr>
						<tr>
							<th>
								ID Number
							</th>
							<td colspan="3">
								<input type="text" name="employee.idnumber1" class="form-control" maxlength="6" id="idnumber1" placeholder="123456">&nbsp;-
								<input type="password" name="employee.idnumber2" class="form-control" maxlength="7" id="idnumber2" placeholder="1234567">
							</td>
							
						</tr>
						<tr>
							<th>Address</th>
							<td colspan="3">
								<input type="text" name="employee.zipcode" id="zipcode" class="form-control" readonly="readonly">
								<input type="text" name="employee.address" id="address" class="form-control" readonly="readonly">
								<input type="text" name="employee.address_detail" id="address_detail" class="form-control">
								<input type="button" class="btn btn-default" value="Search" onclick="address_search()" id="search">
							</td>
						</tr>
						<tr>
							<td><input type="button" class="btn btn-default" value="test" id="testbtn"></td>
						</tr>
					</tbody>
				</table>
				<div class="col-md-12" id="career-group">
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
						<div class="col-md-12 form-inline" id="period_line">
						</div>
					</div>
				</div>
				<div class="col-md-12" id="license-group">
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
					</div>
				</div>
				<div class="col-md-4 buttonBox">
					<input type="button" class="btn btn-default" value="Submit" id="submititem">
					<input type="reset" class="btn btn-default" value="Reset">
					<input type="button" class="btn btn-default" value="Cancel">
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>