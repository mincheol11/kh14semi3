<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
<style>
[name$='-input'] {
	max-width: 70px;
}
	
.grade-input-btn,
.grade-save-btn {
	font-size: 14px;
	padding: 0.3em 0.3em;
}
.swal2-icon.swal2-success {
  border-color: #6695C4;
  color: #6695C4;
}

</style>

    <script type="text/javascript">
        $(document).ready(function() {
        	// 페이지 로드 시 모든 입력 필드를 비활성화
            $('input').prop('disabled', true);
        	
            // 점수 입력 버튼 클릭 이벤트
            $(document).on('click', '.grade-input-btn', function() {
                var row = $(this).closest('tr');
                // 입력 필드를 활성화
                row.find('input').not('[name=gradeRank-input]').prop('disabled', false);
                // 입력 버튼을 비활성화하여 중복 클릭 방지
                $(this).prop('disabled', true);
             	// 점수 저장 버튼 활성화
                row.find('.grade-save-btn').prop('disabled', false);
             	
             	// 점수 최대치 제한
             	$('[name=gradeAttendance-input]').on("input",function(){
             		if($(this).val() >= 20) {
             			$(this).val('20');
             		}
             	});
             	$('[name=gradeScore1-input]').on("input",function(){
             		if($(this).val() >= 35) {
             			$(this).val('35');
             		}
             	});
             	$('[name=gradeScore2-input]').on("input",function(){
             		if($(this).val() >= 35) {
             			$(this).val('35');
             		}
             	});
             	$('[name=gradeHomework-input]').on("input",function(){
             		if($(this).val() >= 10) {
             			$(this).val('10');
             		}
             	});

            // 점수 저장 버튼 클릭 이벤트
            $(document).on('click', '.grade-save-btn', function() {
                var row = $(this).closest('tr');
                var gradeCode = row.data('grade-code');
                var memberId = row.data('member-id');
                
             	// 필드 값을 가져옵니다.
                var gradeAttendance = row.find('[name=gradeAttendance-input]').val();
                var gradeScore1 = row.find('[name=gradeScore1-input]').val();
                var gradeScore2 = row.find('[name=gradeScore2-input]').val();
                var gradeHomework = row.find('[name=gradeHomework-input]').val();
                var gradeRank = calculateRank(gradeAttendance, gradeScore1, gradeScore2, gradeHomework);
        	
		        $.ajax({
		            url: '/rest/grade/update',
		            type: 'post',
		            data: {
		                gradeCode: gradeCode,
		                gradeStudent: memberId,
		                gradeLecture: '${lectureDto.lectureCode}',
		                gradeAttendance: gradeAttendance,
		                gradeScore1: gradeScore1,
		                gradeScore2: gradeScore2,
		                gradeHomework: gradeHomework,
		                gradeRank: gradeRank,
		            },
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            iconColor: "#6695C4",
                            title: '성적 입력 완료.',
                            showConfirmButton: false,
                            timer: 1500
                            
                    });
                        // 총점 업데이트
                        row.find('[name=gradeRank-input]').attr("value", gradeRank);
                        row.find('.gradeRank-input').val(response.gradeRank);
                     	// 입력 필드를 비활성화
                        row.find('input').prop('disabled', true);
                        // 점수 입력 버튼 비활성화
                        row.find('.grade-input-btn').prop('disabled', false);
                        // 점수 저장 버튼 비활성화
                        $(this).prop('disabled', true);
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: '올바른 값을 입력해주세요.',
                            text: error,
                            showConfirmButton: true
                        });
                    }
                });
            });
            }); 

            // 총점 계산 함수 (예시)
            function calculateRank(gradeAttendance, gradeScore1, gradeScore2, gradeHomework) {
               	// 실제 총점 계산 로직을 구현하세요
                return Math.round((parseInt(gradeAttendance) + parseInt(gradeScore1) + parseInt(gradeScore2) + parseInt(gradeHomework)));
            }
        });
    </script>
    
    <div class="container w-900 my-50">
        <div class="row center">
            <h1>성적입력</h1>
        </div>

        <form id="gradeForm" action="gradeInsert" method="post" autocomplete="off">
            <table class="table table-horizontal w-100">
                <thead>
                    <tr>
                        <th>전공(학과)</th>
                        <th>교수명</th>
                        <th>분류</th>
                        <th>강의명</th>
                        <th>강의코드</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody class="center">
                    <tr>
                        <td>${departmentDto.departmentName}</td>
                        <td>${memberDto.memberName}</td>
                        <td>${lectureDto.lectureType}</td>
                        <td>${lectureDto.lectureName}</td>
                        <td>${lectureDto.lectureCode}</td>
                        <td>#</td>
                    </tr>
                </tbody>
            </table>
            
            <table class="table table-horizontal w-100 my-10">
                <thead>
                    <tr>
                        <th>평가배점</th>
                        <th>출석</th>
                        <th>중간평가</th>
                        <th>기말평가</th>
                        <th>과제</th>
                        <th>총점</th>
                    </tr>
                </thead>
                <tbody class="center">
                    <tr>
                        <td>기준</td>
                        <td>20</td>
                        <td>35</td>
                        <td>35</td>
                        <td>10</td>
                        <td>100</td>
                    </tr>
                </tbody>
            </table>

            <!-- 결과 화면 -->
            <table class="table table-horizontal w-100">
                <thead>
                    <tr>
                        <th>학번</th>
                        <th>성명</th>
                        <th>출석</th>
                        <th>중간평가</th>
                        <th>기말평가</th>
                        <th>과제</th>
                        <th>총점</th>
                        <th>입력</th>
                        <th>저장</th>
                    </tr>
                </thead>
                <!-- 학생 목록 -->
                <tbody align="center">
                    <c:forEach var="gradeStudentVO" items="${studentList}">
                        <tr data-grade-code="${gradeStudentVO.gradeCode}" data-member-id="${gradeStudentVO.memberId}">
                            <td>${gradeStudentVO.memberId}</td>
                            <td>${gradeStudentVO.memberName}</td>
                            <td><input type="number" name="gradeAttendance-input" value="${gradeStudentVO.gradeAttendance}" disabled /></td>
                            <td><input type="number" name="gradeScore1-input" value="${gradeStudentVO.gradeScore1}" disabled /></td>
                            <td><input type="number" name="gradeScore2-input" value="${gradeStudentVO.gradeScore2}" disabled /></td>
                            <td><input type="number" name="gradeHomework-input" value="${gradeStudentVO.gradeHomework}" disabled /></td>
                            <td><input type="number" name="gradeRank-input" value="${gradeStudentVO.gradeRank}" disabled /></td>
                            <td><button type="button" class="btn btn-neutral grade-input-btn"><i class="fa-solid fa-pen fa-xs"></i> 입력</button></td>
                            <td><button type="button" class="btn btn-positive grade-save-btn" disabled><i class="fa-solid fa-floppy-disk fa-xs"></i> 저장</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 점수 등록 -->
            <div class="row mt-30">
                <a type="button" href="/lecture/list" class="btn btn-positive w-100 grade-insert-btn">
                    <i class="fa-solid fa-check"></i> 성적 입력 완료
                </a>
            </div>
            <div class="row">
                <a href="/lecture/list" class="btn btn-neutral w-100" >
					<i class="fa-solid fa-arrow-rotate-left"></i> 뒤로가기</a>
            </div>
        </form>
    </div>

	
<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

