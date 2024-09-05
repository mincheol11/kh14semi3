<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>
$(function(){
	var status = {
			studentDepartmentValid : false,
			studentLevelValid : false,
			professorDepartmentValid : false,
			ok : function(){
				return this.studentDepartmentValid 
					&& this.studentLevelValid
					&& this.professorDepartmentValid
			},
	};
	
	$("[name=studentDepartment]").blur(function(){
        var isValid = $(this).val().length > 0;
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        if(isValid){
  			$("[name=studentDepartment]").parent().find("label").find("i").removeClass("red fa-bounce");
  			$("[name=studentDepartment]").parent().find("label").find("i").addClass("green fa-beat");
		}
  		 else{
  			$("[name=studentDepartment]").parent().find("label").find("i").removeClass("green fa-beat");
  			$("[name=studentDepartment]").parent().find("label").find("i").addClass("red fa-bounce");
		}
        status.studentDepartmentValid = isValid;
    });
	
	$("[name=studentLevel]").on("click", function(){
		var str = "^(1|2|3|4)$";
		var regex = new RegExp(str);
		var isValid = regex.test($(this).val());
		$(this).removeClass("success fail")
        .addClass(isValid ? "success" : "fail");
		if(isValid){
  			$("[name=studentLevel]").parent().find("label").find("i").removeClass("red fa-bounce");
  			$("[name=studentLevel]").parent().find("label").find("i").addClass("green fa-beat");
		}
  		 else{
  			$("[name=studentLevel]").parent().find("label").find("i").removeClass("green fa-beat");
  			$("[name=studentLevel]").parent().find("label").find("i").addClass("red fa-bounce");
		}
        status.studentLevelValid = isValid;
	});
	
	$("[name=professorDepartment]").blur(function(){
        var isValid = $(this).val().length > 0;
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        if(isValid){
  			$("[name=professorDepartment]").parent().find("label").find("i").removeClass("red fa-bounce");
  			$("[name=professorDepartment]").parent().find("label").find("i").addClass("green fa-beat");
		}
  		 else{
  			$("[name=professorDepartment]").parent().find("label").find("i").removeClass("green fa-beat");
  			$("[name=professorDepartment]").parent().find("label").find("i").addClass("red fa-bounce");
		}
        status.professorDepartmentValid = isValid;
    });
	
	//체크폼
	//학생
    $(".check-form1").submit(function(){
        $("[name]").trigger("input").trigger("blur").trigger("click");
        status.professorDepartmentValid=true;
        return status.ok();
    });
	
	//교수
    $(".check-form2").submit(function(){
        $("[name]").trigger("input").trigger("blur").trigger("click");
        status.studentDepartmentValid=true;
        status.studentLevelValid=true;
        return status.ok();
    });
	
	//관리자
    $(".check-form3").submit(function(){
        $("[name]").trigger("input").trigger("blur").trigger("click");
        status.studentDepartmentValid=true;
        status.studentLevelValid=true;
        status.professorDepartmentValid=true;
        return status.ok();
    });
    
	
	
});
</script>


<div class="container w-600 my-50">
	<c:choose>
		<c:when test="${memberDto.memberRank == '학생'}">
		<form class="check-form1" action="joinR" method="post" autocomplete="on">
				<div class="row">
					<input name="memberId" value="${memberDto.memberId}" type="hidden"
						class="field w-100">
					<input name="studentId" value="${memberDto.memberId}" type="hidden"
						class="field w-100">
				</div>
				<div class="row">
					<label>학과코드</label>
				</div>
				<div class="row">
					<input name="studentDepartment" class="field w-100" placeholder="학과코드: KH + 고유코드(D) + 캠퍼스(01~03) + 순번(001~999)">
					<div class="fail-feedback">필수 선택사항 입니다.</div>
				</div>
				<div class="row">
					<label>학년</label>
				</div>
				<div class="row">
					<select name="studentLevel" class="field w-100">
						<option value="">분류</option>
						<option value="1">1 학년</option>
						<option value="2">2 학년</option>
						<option value="3">3 학년</option>
						<option value="4">4 학년</option>
					</select>
					<div class="success-feedback"></div>
					<div class="fail-feedback">필수 선택사항 입니다.</div>
				</div>
				<div class="right">
					<button class="btn btn-positive" type="submit">
						<i class="fa-solid fa-right-to-bracket"></i> 등록완료
					</button>
				</div>
		</form>
		</c:when>
		<c:when test="${memberDto.memberRank == '교수'}">
		<form class="check-form" action="joinR" method="post" autocomplete="off">
				<div class="row">
				<input name="memberId" value="${memberDto.memberId}" type="hidden"
						class="field w-100">
					<input name="professorId" value="${memberDto.memberId}"
						type="hidden" class="field w-100">
				</div>
				<div class="row">
					<label>학과코드</label>
				</div>
				<div class="row">
					<input name="professorDepartment" class="field w-100" placeholder="학과코드: KH + 고유코드(D) + 캠퍼스(01~03) + 순번(001~999)">
					<div class="fail-feedback">필수 선택사항 입니다.</div>
				</div>
				<div class="right">
					<button class="btn btn-positive" type="submit">
						<i class="fa-solid fa-right-to-bracket"></i> 등록완료
					</button>
				</div>
		</form>
		</c:when>
		<c:when test="${memberDto.memberRank == '관리자'}">
		<form class="check-form" action="joinR" method="post" autocomplete="off">
				<div class="row">
				<input name="memberId" value="${memberDto.memberId}" type="hidden"
						class="field w-100">
					<input name="adminId" value="${memberDto.memberId}" type="hidden"
						class="field w-100">
				</div>
			<div class="center">
				<h3>등록완료 버튼을 누르시고 나가시면 됩니다.</h3>
			</div>
			<div class="right">
				<button class="btn btn-positive" type="submit">
				<i class="fa-solid fa-right-to-bracket"></i> 등록완료
				</button>
			</div>
		</form>
		</c:when>
	</c:choose>
</div>



<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
