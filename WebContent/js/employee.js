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
		
	});

regNumber=/^[0-9]*$/;
regBigAlphabet=/^[A-Z,\s]*$/;
$(function(){
	$("input[name='career.period_start']").datepicker({
		dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
	$("input[name='career.period_end']").datepicker({
		dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
	$("input[name='license.license_date']").datepicker({
		dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
	$("input[name='employee.join']").datepicker({
		dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
	$("input[name='employee.out']").datepicker({
		dateFormat:'yy-mm-dd', changeMonth: true, changeYear: true, nextText: '다음 달', prevText: '이전 달'});
});

$(document).on("click",".license-minus",function(){
	$(this).parent().parent().remove();
});
$(document).on("click",".career-minus", function(){
	$(this).parent().parent().remove();
});