$(document).ready(function(){
	/*$(".container").css("height", $(window).height());*/
	$(".w3-sidebar > *").css("margin-left", $(".w3-sidebar").width()/2 - $(".glyphicon").width()/2);
	$(".container").css("margin-top", $(".navbar").height());
	$(window).resize(function(){
		$(".container").css("margin-top", $(".navbar").height());
		$(".w3-sidebar > *").css("margin-left", $(".w3-sidebar").width()/2 - $(".glyphicon").width()/2);
		/*$(".container").css("padding-top", ($(window).height()/2)-$(".row").height()/2);*/
	});
});
function removeLicenseItem(event){
	var classname=event.target.className;
	var id=event.target.parentNode.parentNode.id;
	var index=event.target.nodeName;
}

function addLicenseItem(){
	var str="<div class='col-md-12 form-inline' id='license_line'><div class='form-group'><label>Name</label>"
			+"<input type='text' class='form-control' id='license_name' name='license.license_name'></div><div class='form-group'>"
			+"<label>Level</label><input type='text' class='form-control' id='license_level' name='license.license_level'>"
			+"</div><div class='form-group'><label>Get Date</label>"
			+"<input type='text' class='form-control' name='license.license_date' readonly='readonly'></div>"
			+"<div class='form-group'><label>Publisher</label>"
			+"<input type='text' class='form-control' id='license_Publisher' name='license.license_publisher'>"
			+"<span class='btn btn-default glyphicon glyphicon-minus license-minus'></span></div></div>"
			$("#license_box").append(str);
}

function addCareerItem(){
	var str="<div class='col-md-12 form-inline' id='period_line'><div class='form-group'><label>Period</label>"
			+"<input type='text' class='form-control' name='career.period_start' style='width:100px' readonly='readonly'>&nbsp;~"
			+"<input type='text' class='form-control' name='career.period_end' style='width:100px' readonly='readonly'>"
			+"</div><div class='form-group'><label>Company</label>"
			+"<input type='text' class='form-control' name='career.period_company' id='period_company'></div>"
			+"<div class='form-group'><label>Rank</label>"
			+"<select class='form-control' name='career.period_rank' id='period_rank'><option value=''></option>"
			+"<option value='Chairman'>Chairman</option><option value='Vice Chairman'>Vice Chairman</option>" 
			+"<option value='CEO'>CEO</option><option value='Executive Vice President'>Executive Vice President</option>"
			+"<option value='Managing'>Managing Director</option><option value='Director'>Director</option>"
			+"<option value='Deputy General Manager'>Deputy General Manager</option>"
			+"<option value='Manager'>Manager</option><option value='Assistant Manager'>Assistant Manager</option>"
			+"<option value='Chief'>Chief</option>"
			+"<option value='Associate'>Associate</option><option value='Staff'>Staff</option>"
			+"<option value='Intern'>Intern</option></select></div>"
			+"<div class='form-group'><label>Position/Work</label>"
			+"<input type='text' class='form-control' name='career.period_position' id='period_position'>"
			+"<span class='btn btn-default glyphicon glyphicon-minus career-minus'></span></div></div>"
			$("#period_box").append(str);
}

function testChecker(frm){
	var frmDate=frm;
	var result;
	var textName;
	var inputname=new Array();
	var inputlength=new Array();
	for(var idx=0; idx<frmDate.find(":input").length;idx++){
		var inputVal=frmDate.find(":input").eq(idx).val();
		var inputName=frmDate.find(":input").eq(idx).attr("name");
		inputVal=inputVal.trim();
		inputname.push(frmDate.find(":input").eq(idx).attr("name"));
		inputlength.push(frmDate.find(":input").eq(idx).val().length);
		
		if((inputName!="outcompany" && inputName!="period_start" && inputName!="period_end" && inputName!="period_company"
			&& inputName!="period_rank" && inputName!="period_position" && inputName!="license_name" &&inputName!="license_leven"
				&& inputName!="license_date" && inputName!="license_publisher")&& inputVal==""){
			frmDate.find(":input").eq(idx).css("border","1px solid red");
			textName=frmDate.find(":input").eq(idx).attr("name");
			result=false;
		}else if(inputVal!=""){
			frmDate.find(":input").eq(idx).css("border","1px solid #E4E4E4");
		}else{
			result=true;
		}
	}
	if(!result){
		alert("입력 값이 없는 란이 존재 합니다.");
	}else if(checkInputValLength(inputname, inputlength)){
		checkCareer();
	}else{		
		//checkCareer();
	}
}

function checkInputValLength(inputname, inputlength){
	var result;
	for(var idx=0;idx<inputname.length;idx++){
		if(inputname[idx]=="name" && inputlength[idx]<3){
			alert("이름은 2자 이상 적어주십시오.");
			result=false;
			return;
		}else if(inputname[idx]=="idnumber1" && inputlength[idx]<6){
			alert("생년월일 6자를 적어주십시오.");
			result=false;
			return;
		}else if(inputname[idx]=="idnumber2" && inputlength[idx]<7){
			alert("주민번호 7자를 적어주십시오.");
			result=false;
			return;
		}else{
			result=true;
		}
	}
	return result;
}
