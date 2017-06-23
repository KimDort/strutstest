function checkBaseInfo(frm){
	var result;
	if($("#name").val()=="" || $("#name").val()==null){
		alert("이름을 입력해 주십시오.");
		$("#name").focus();
		result=false;
		return;
	}else if($("#name").val().length < 3){
		alert("이름은 최소 3자 이상 적어주십시오.");
		$("#name").focus();
		result=false;
		return;
	}else if($("#company").val()=="" || $("#company").val()==null){
		alert("소속회사를 입력해 주십시오.");
		$("#company").focus();
		result=false;
		return;
	}else if($("#rank").val()=="" || $("#rank").val()==null){
		alert("직급을 입력해 주십시오.");
		$("#rank").focus();
		result=false;
		return;
	}else if($("#position").val()=="" || $("#position").val()==null){
		alert("역활 및 직무를 입력해 주십시오.");
		$("#position").focus();
		result=false;
		return;
	}else if($("#joincompany").val()=="" || $("#rank").val()==null){
		alert("입사일을 입력해 주십시오.");
		$("#joincompany").focus();
		result=false;
		return;
	}else if($("#isnew").val()=="" || $("#isnew").val()==null){
		alert("신입 및 경력을 선택해 주십시오.");
		$("#isnew").focus();
		result=false;
		return;
	}else if($("#skills").val()=="" || $("#skills").val()==null){
		alert("스킬은 하나 이상 입력하셔야 합니다.");
		$("#skills").focus();
		result=false;
		return;
	}else if($("#idnumber1").val()=="" || $("#idnumber1").val()==null){
		alert("생년월일을 입력해 주십시오.");
		$("#idnumber1").focus();
		return;
	}else if($("#idnumber1").val().length<6){
		alert("생년월일 6자리를 적어 주십시오.");
		$("#idnumber1").focus();
		result=false;
		return;
	}else if($("#idnumber2").val()=="" || $("#idnumber2").val()==null){
		alert("주민번호를 입력해 주십시오");
		$("#idnumber2").focus();
		result=false;
		return;
	}else if($("#idnumber2").val().length < 7 ){
		alert("주민번호 7자리를 입력해 주십시오");
		$("#idnumber2").focus();
		result=false;
		return;
	}else if($("#zipcode").val()=="" || $("#zipcode").val()==null || $("#address").val()=="" || $("#address").val()==null){
		alert("주소를 입력해 주십시오.");
		$("#search").trigger("click");
		result=false;
		return;
	}else if($("#address_detail").val()==null || $("#address_detail").val()==""){
		alert("상세 주소를 입력해 주십시오.");
		$("#address_detail").focus();
		result=false;
		return;
	}else if($("#position").val()=="" || $("#position").val()==null){
		alert("역활을 입력해 주십시오.");
		$("#position").focus();
		result=false;
		return;
	} else{
		result=true;
	}
	return result;
}

function completeInput(page, perPageNum){
	if(confirm("작성을 완료하시겠습니까?")){
		$("#frm").submit();
	}else{
		if(confirm("작성을 취소하고 리스트 페이지로 이동하시겠습니까?")){
			var str="http://localhost:9090/ProjectManagementSystem/member/list.do?page="+page+"&perPageNum="+perPageNum;
			$(location).attr("href",str);
		}
	}
}

function careerThisBoxRemove(idx){
	if(confirm("작성이 완료되지 않았습니다.\r\n해당 경력란을 지우시겠습니까?")){
		$("input[name='period_start']").eq(idx).parent().parent().remove();
	}else{
		alert("모두 다 작성하거나 또는 작성하지 않아야 합니다.");
	}
}
function checkCareerBox(isnewVal){
	var result;
	if(isnewVal=="Career"){
		if(typeof $("input[name='period_start']").val() == "undefined"){
			alert("경력을 하나 이상 입력하셔야 합니다.");
			result=false;
			return;
		}else{
			result=checkCareer();
		}
	}else if(isnewVal=="New"){
		/*$("#career-group").remove();*/
		result=true;
	}
	return result;
}
function checkLicenseBox(){
	var result;
	if($("input[name='license_name']").length <= 0){
		result=true;
	}else{
		result=checkLicense();
	}
	return result;
}
function checkCareer(){
	var result=true;
		for(var idx=0;idx<$("input[name='period_start']").length;idx++){
			if($("input[name='period_start']").eq(idx).val()=="" ||
					$("input[name='period_start']").eq(idx).val()==null){
				if(confirm("경력 사항 입력 중 [경력 시작일]이 입력되지 않았습니다.\r\n입력하시겠습니까?")){
					$("input[name='period_start']").eq(idx).focus();
					result=false;
					return;
				}else{
					careerThisBoxRemove(idx);
					return;
				}						
			}else if($("input[name='period_end']").eq(idx).val()=="" ||
					$("input[name='period_end']").eq(idx).val()==null){
				if(confirm("경력 사항 입력 중 [경력 종료일]이 입력되지 않았습니다.\r\n입력하시겠습니까?.")){
					$("input[name='period_end']").eq(idx).focus();
					result=false;
					return;
				}else{
					careerThisBoxRemove(idx);
					return;
				}					
			}else if($("input[id='period_company']").eq(idx).val()=="" ||
					$("input[id='period_company']").eq(idx).val()==null){
				if(confirm("경력 사항 입력 중 [근무지]가 입력되지 않았습니다.\r\n입력하시겠습니까?.")){
					$("input[name='period_company']").eq(idx).focus();
					result=false;
					return;
				}else{
					careerThisBoxRemove(idx);
					return;
				}				
			}else if($("select[name='period_rank'] option:selected").eq(idx).val()=="" ||
					$("select[name='period_rank'] option:selected").eq(idx).val()==null){
				if(confirm("경력 사항 입력 중 [직급]이 선택되지 않았습니다.\r\n선택하시겠습니까?.")){
					$("select[name='period_rank']").eq(idx).focus();
					result=false;
					return;
				}else{
					careerThisBoxRemove(idx);
					return;
				}
			}else if($("input[id='period_position']").eq(idx).val()=="" ||
					$("input[id='period_position']").eq(idx).val()==null){
				if(confirm("경력 사항 입력 중 [역활 및 직무]이 입력되지 않았습니다.\r\n입력하시겠습니까?.")){
					$("input[name='period_position']").eq(idx).focus();
					result=false;
					return;
				}else{
					careerThisBoxRemove(idx);
					return;
				}
			}else{
				result=true;
			}
		}
		return result;
	}	

function checkLicense(){
	var result;
	for(var idx=0;idx<$("input[name='license_name']").length;idx++){
		var licenseNameVal=$("input[name='license_name']").eq(idx).val();
		var licenseLevelVal=$("input[name='license_level']").eq(idx).val();
		var licenseDateVal=$("input[name='license_date']").eq(idx).val();
		var licensePublisherlVal=$("input[name='license_publisher']").eq(idx).val();
		if(licenseNameVal=="" || licenseNameVal==null){		
			result=false;
			if(confirm("자격증 이름이 없습니다.\r\n작성하시겠습니까?")){
				$("input[name='license_name']").eq(idx).focus();		
				return;
			}else{
				if(confirm("작성이 완료되지 않았습니다.\r\n 해당 자격증란을 지우시겠습니까?")){
					$("input[id='license_name']").eq(idx).parent().parent().remove();
				}else{
					alert("자격증란은 다 작성하거나 또는 없어야 합니다.");
				}
				return;
			}
		}else if(licenseLevelVal=="" || licenseLevelVal==null){
			result=false;
			if(confirm("자격증 레벨이 없습니다.\r\n작성하시겠습니까?")){
				$("input[name='license_level']").eq(idx).focus();
				return;
			}else{
				if(confirm("작성이 완료되지 않았습니다.\r\n 해당 자격증란을 지우시겠습니까?")){
					$("input[id='license_name']").eq(idx).parent().parent().remove();
				}else{
					alert("자격증란은 다 작성하거나 또는 없어야 합니다.");
				}
				return;
			}
		}else if(licenseDateVal=="" || licenseDateVal==null){
			result=false;
			if(confirm("자격증 취득일이 없습니다.\r\n선택하시겠습니까??")){
				$("input[name='license_date']").eq(idx).focus();
				return;
			}else{
				if(confirm("작성이 완료되지 않았습니다.\r\n 해당 자격증란을 지우시겠습니까?")){
					$("input[id='license_name']").eq(idx).parent().parent().remove();
				}else{
					alert("자격증란은 다 작성하거나 또는 없어야 합니다.");
				}
				return;
			}
		}else if(licensePublisherlVal=="" || licensePublisherlVal==null){
			result=false;
			if(confirm("자격증 발행처가 없습니다.\r\n선택하시겠습니까??")){
				$("input[name='license_publisher']").eq(idx).focus();
				return;
			}else{
				if(confirm("작성이 완료되지 않았습니다.\r\n 해당 자격증란을 지우시겠습니까?")){
					$("input[id='license_name']").eq(idx).parent().parent().remove();
				}else{
					alert("모두 다 작성하거나 또는 작성하지 않아야 합니다.");
				}
				return;
			}
		}else if(!checkDateLicense()){
			result=false;
			return;
		}else{
			result=true;
		}
	}
	return result;
}
function checkDateLicense(){
	var result;
	var licenseGetDateArray;
	var licenseGetDate=new Array();
	
	//자격증 취득일 가져오기
	for(var idx=0;idx<$("input[name='license_date']").length;idx++){
		licenseGetDateArray=$("input[name='license_date']").eq(idx).val().split("-");
		licenseGetDate.push(new Date(licenseGetDateArray[0], licenseGetDateArray[1]-1, licenseGetDateArray[2]));
	}
	
	if(!checkLicenseNow(getNowDate(), licenseGetDate)){
		result=false;
	}else{
		result=true;
	}
	return result;
}
function checkDateCareer(){
	var result;
	
	var joinCompanyDateVal=$("#joincompany").val();
	var joinCompanyDateArray=joinCompanyDateVal.split("-");
	var joinCompanyDate= new Date(joinCompanyDateArray[0], joinCompanyDateArray[1]-1,joinCompanyDateArray[2]);
	
	var careerStartDateArray;
	var careerEndDateArray;
		
	var careerStartDate = new Array();
	var careerEndDate = new Array();
	
	//경력 시작일 가져오기
	for(var idx=0;idx<$("input[name='period_start']").length;idx++){
		careerStartDateArray=$("input[name='period_start']").eq(idx).val().split("-");
		careerStartDate.push(new Date(careerStartDateArray[0], careerStartDateArray[1]-1, careerStartDateArray[2]));
	}
	//경력 종료일 가져오기
	for(var idx=0;idx<$("input[name='period_end']").length;idx++){
		careerEndDateArray=$("input[name='period_end']").eq(idx).val().split("-");
		careerEndDate.push(new Date(careerEndDateArray[0], careerEndDateArray[1]-1, careerEndDateArray[2]));
	}
	
	if(!checkCompareJoinComLater(joinCompanyDate, careerStartDate, careerEndDate)){
		result=false;
		console.log("경력 입사일 이후 체크 완료"+ result);
	}else if(!checkOverLap(careerStartDate, careerEndDate)){		
		result=false;
		console.log("경력 중복 체크 완료"+ result);
	}else if(!checkStartEndSize(careerStartDate, careerEndDate)){
		result=false;
		console.log("시작일 종료일 체크 완료"+ result);
	}else{
		result=true;
	}
	console.log("최종 리절트 값:"+result);
	/*result=true;*/
	return result;
}

function checkCompareJoinComLater(joinCompanyDate, careerStartDate, careerEndDate){
	//경력 입사일 이후 날짜 비교 검사
	var result;
	for(var idx=0; idx<careerStartDate.length;idx++){
		if(joinCompanyDate.getTime()<=careerStartDate[idx].getTime()){
			alert("입사일 이후 날은 선택하실 수 없습니다.");
			$("input[name='period_start']").eq(idx).val("");
			$("input[name='period_start']").eq(idx).focus();
			result=false;
			return;
		}else if(joinCompanyDate.getTime()<=careerEndDate[idx].getTime()){
			alert("입사일 이후 날은 선택하실 수 없습니다.");
			$("input[name='period_end']").eq(idx).val("");
			$("input[name='period_end']").eq(idx).focus();
			result=false;
			return;
		}else{
			result=true;
		}
	}
	return result;
}

function checkOverLap(careerStartDate, careerEndDate){
	var result;
	//경력 중복 체크
	for(var idx=0; idx<careerStartDate.length;idx++){
		for(var jdx=idx+1; jdx<careerStartDate.length;jdx++){
			if(careerStartDate[idx].getTime() <= careerStartDate[jdx].getTime() &&
					careerEndDate[idx].getTime() >= careerStartDate[jdx].getTime()){
				alert("중복된 경력 사항이 있습니다.");
				$("input[name='period_start']").eq(jdx).focus();	
				result=false;
				return;
			}else if(careerStartDate[idx].getTime() <= careerEndDate[jdx].getTime() &&
					careerEndDate[idx].getTime() >= careerEndDate[jdx].getTime()){
				alert("중복된 경력 사항이 있습니다.");
				$("input[name='period_end']").eq(jdx).focus();
				result=false;
				return;
			}else{
				result=true;
			}
		}
	}
	return result;
}

function checkStartEndSize(careerStartDate, careerEndDate){
	var result;
	//경력 시작일 종료일 크기 검사
	for(var idx=0; idx<careerStartDate.length;idx++){
		if(careerStartDate[idx].getTime() >= careerEndDate[idx].getTime()){
			alert("종료일이 시작일 보다 같거나 빠릅니다.");
			$("input[name='period_end']").eq(idx).focus();
			result=false;
			return;
		}else{
			result=true;
		}
	}
	return result;
}

function checkLicenseNow(nowDate, licenseGetDate){
	var result;
	//자격증 현재 날짜 이후 검사 
	for(var idx=0; idx<licenseGetDate.length;idx++){
		if(nowDate.getTime() <= licenseGetDate[idx].getTime()){
			alert("자격증 취득일은 현재 날짜 이후 날은 선택 하실 수 없습니다.");
			$("input[name='license_date']").eq(idx).focus();
			result=false;
		}else{
			result= true;
		}
	}
	return result;
}

function getNowDate(){
	var nowGetDate= new Date();
	var getYear=nowGetDate.getFullYear();
	var getMonth=nowGetDate.getMonth();
	var getDay=nowGetDate.getDate();
	var nowDate=new Date(getYear, getMonth, getDay);
	return nowDate;
}