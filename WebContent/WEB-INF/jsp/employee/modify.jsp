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
		$("input[name='period_start']").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' 
		});
		$("input[name='period_end']").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' });
		$("input[name='license_date']").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' 	
		});
		$("input[name='joincompany']").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' 
		});
		$("input[name='outcompany']").datepicker({
			dateFormat:'yy-mm-dd',
			changeMonth: true, 
	        changeYear: true,
	        nextText: '다음 달',
	        prevText: '이전 달' 
		});
	});
	
	$(document).ready(function(){
		$("#addCareer").on("click",function(){
			addCareerItem();
			$("input[name='period_start']").datepicker({
				dateFormat:'yy-mm-dd',
				changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달' });
				
			$("input[name='period_end']").datepicker({
				dateFormat:'yy-mm-dd',
				changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달' 
			});
		});	
		
		$("#addLicense").on("click",function(){
			addLicenseItem();
			$("input[name='license_date']").datepicker({
				dateFormat:'yy-mm-dd',
				changeMonth: true, 
		        changeYear: true,
		        nextText: '다음 달',
		        prevText: '이전 달' });
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
		
		$(".career-minus").on("click",function(){
			if($(".career-minus").index(this)!=0){
				$(this).parent().parent().remove();
			}
		});
		
		$(".license-minus").on("click",function(){
			if($(".license-minus").index(this)!=0){
				$(this).parent().parent().remove();
			}
		});
		rankSelect();
		
		$("#submititem").on("click", function(){
			$("#frm").attr("action","${pageContext.request.contextPath }/member/register.do");
			$("#frm").attr("method", "post");
			
			var checkCareer=$("#isnew option:selected").val();
			
			if(!checkBaseInfo($("#frm"))){
				return;
			}else{
				if(!checkCareerBox(checkCareer)){
					return;
				}else{
					if(!checkDateCareer()){
						return;
					}else if(!checkLicenseBox()){
						return;
					}else{
						completeInput('${cri.page}', '${cri.perPageNum}');	
					}
				}			
			}
		});
	});
	$(document).on("click",".license-minus",function(){
		$(this).parent().parent().remove();
	});
	$(document).on("click",".career-minus", function(){
		$(this).parent().parent().remove();
	});
	function removeCareer(){
		var id=event.target.parentNode.parentNode.id;
		var index=event.target.nodeName;
		$(this).remove();
		
		/* alert($("div[id='"+id+"']").index()); */
		//$("div[id='"+id+"']").eq(2).remove();
	}
	
	function rankSelect(){
		var rankSelected="${member.member_rank}";
		var workSelected="${member.member_isnew}";
		$("#rank").val(rankSelected).attr("selected", "selected");
		$("#isnew").val(workSelected).attr("selected", "selected");
		
		var careerRank= new Array;
		<c:forEach items="${career}" var="car">
			careerRank.push("${car.rank}");
		</c:forEach>
		for(var idx=0;idx<careerRank.length;idx++){
			$("select[id='period_rank']").eq(idx).val(careerRank[idx]).attr("selected","selected");
		}
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
			<form class="form-inline" id="frm">
			<input type="hidden" name="page" value="${cri.page }">
			<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
			<input type="hidden" name="mno" value="${member.member_no }">
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
								<input type="text" placeholder="Please Write Name" class="form-control" name="name" id="name" value="${member.member_name }">
							</td>
							<th>Company</th>
							<td>
								<input type="text" name="company" class="form-control" id="company" value="${member.member_company }">
							</td>
						</tr>
						<tr>
							<th>Rank</th>
							<td>
								<select class="form-control" name="rank" id="rank">
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
							<td><input type="text" class="form-control" id="position" name="position" value="${member.member_position }"></td>
						</tr>
						<tr>
							<th>
								Join Company Date
							</th>
							<td>
								<input type="text" name="joincompany" class="form-control" readonly="readonly" id="joincompany" value="${member.member_join }">
							</td>
							<th>
								Out Company Date
							</th>
							<td>
								<input type="text" name="outcompany" class="form-control" readonly="readonly" id="outcompany" value="${member.member_out }">
							</td>
						</tr>
						<tr>
							<th>
								Work
							</th>
							<td>
								<select class="form-control" name="isnew" id="isnew">
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
								<input type="text" name="haveskills" class="form-control" id="skills" placeholder="JAVA, SPRING, ..." value="${member.member_haveskill }">
							</td>
							
						</tr>
						<tr>
							<th>
								ID Number
							</th>
							<td colspan="3">
							<c:set var="idnumber" value="${fn:split(member.member_idnumber,'-') }"></c:set>
								<input type="text" name="idnumber1" class="form-control" maxlength="6" id="idnumber1" placeholder="123456" value=${idnumber[0] }>&nbsp;-
								<input type="text" name="idnumber2" class="form-control" maxlength="7" id="idnumber2" placeholder="1234567" value=${idnumber[1] }>
							</td>
							
						</tr>
						<tr>
							<th>Address</th>
							<td colspan="3">
								<input type="text" name="zipcode" id="zipcode" class="form-control" readonly="readonly" value="${member.member_zipcode }">
								<input type="text" name="address" id="address" class="form-control" readonly="readonly" value="${member.member_address }">
								<input type="text" name="address_detail" id="address_detail" class="form-control" value="${member.member_address_detail }">
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
						<c:if test="${empty career }">
						</c:if>
						<c:if test="${not empty career }">
						<c:forEach items="${career }" var="idx" varStatus="status">
						<c:if test="${status.index eq 0 }">
							<div class="col-md-12 form-inline" id="period_line">
							<div class="form-group">
								<label>Period</label>
								<input type="text" class="form-control" style="width:100px" readonly="readonly" value="${idx.period_start }">&nbsp;~
								<input type="text" class="form-control" style="width:100px" readonly="readonly" value="${idx.period_end }">
							</div>
							<div class="form-group">
								<label>Company</label>
								<input type="text" class="form-control" id="period_company" value="${idx.company }" readonly="readonly">
							</div>
							<div class="form-group">
								<label>Rank</label>
								<select class="form-control" id="period_rank" disabled="disabled">
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
							</div>
							<div class="form-group">
								<label>Position/Work</label>
								<input type="text" class="form-control" id="period_position" value="${idx.position }" readonly="readonly">
							</div>
							</div>
						</c:if>	
						<c:if test="${status.index ne 0 }">
							<div class="col-md-12 form-inline" id="period_line">
							<div class="form-group">
								<label>Period</label>
								<input type="text" class="form-control" name="period_start"style="width:100px" readonly="readonly" value="${idx.period_start }">&nbsp;~
								<input type="text" class="form-control" name="period_end" style="width:100px" readonly="readonly" value="${idx.period_end }">
							</div>
							<div class="form-group">
								<label>Company</label>
								<input type="text" class="form-control" name="period_company" id="period_company" value="${idx.company }">
							</div>
							<div class="form-group">
								<label>Rank</label>
								<select class="form-control" id="period_rank" name="period_rank" style="width: 150px">
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
							</div>
							<div class="form-group">
								<label>Position/Work</label>
								<input type="text" class="form-control" id="period_position" value="${idx.position }" name="period_position">
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
						<c:if test="${empty license }">
						</c:if>
						<c:if test="${not empty license }">
						<c:forEach items="${license }" var="idx">
						<div class="col-md-12 form-inline" id="license_line">
						<input type="hidden" name="license_no" value="${idx.no }">
							<div class="form-group">
								<label>Name</label>
								<input type="text" class="form-control" id="license_name" name="license_name" value="${idx.name }">
							</div>
							<div class="form-group">
								<label>Level</label>
								<input type="text" class="form-control" id="license_level" name="license_level" value="${idx.level }">
							</div>
							<div class="form-group">
								<label>Get Date</label>
								<input type="text" class="form-control" name="license_date" readonly="readonly" value="${idx.getdate }">
							</div>
							<div class="form-group">
								<label>Publisher</label>
								<input type="text" class="form-control" id="license_Publisher" name="license_Publisher" value="${idx.publisher }">
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