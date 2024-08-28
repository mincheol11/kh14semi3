<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>


    <script>
        $(document).ready(function() {
        	// 페이지 로드 시 모든 입력 필드를 비활성화
            $('input').prop('disabled', true);
        	
            // 점수 수정 버튼 클릭 이벤트
            $(document).on('click', '.grade-edit-btn', function() {
                var row = $(this).closest('tr');
        	
                // 입력 필드를 활성화
                row.find('input').prop('disabled', false);
                // 수정 버튼을 비활성화하여 중복 클릭 방지
                $(this).prop('disabled', true);
             	// 점수 입력 버튼 활성화
                row.find('.grade-save-btn').prop('disabled', false);
          	});

            // 점수 입력 버튼 클릭 이벤트
            $(document).on('click', '.grade-save-btn', function() {
                var row = $(this).closest('tr');
                var gradeCode = row.data('grade-code');
                var memberId = row.data('member-id');
                
             	// 필드 값을 가져옵니다.
                var gradeAttendance = row.find('.gradeAttendance-input').val();
                var gradeScore1 = row.find('.gradeScore1-input').val();
                var gradeScore2 = row.find('.gradeScore2-input').val();
                var gradeHomework = row.find('.gradeHomework-input').val();
                var gradeRank = row.find('.gradeRank-input').val();

                $.ajax({
                    url: '/rest/grade/edit',
                    type: 'post',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        gradeCode: gradeCode,
                        gradeStudent: memberId,
                        gradeLecture: '${lectureDto.lectureCode}',
                        gradeAttendance: gradeAttendance,
                        gradeScore1: gradeScore1,
                        gradeScore2: gradeScore2,
                        gradeHomework: gradeHomework,
                        gradeRank: calculateRank(gradeAttendance, gradeScore1, gradeScore2, gradeHomework)
                    }),
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: '성적이 성공적으로 수정되었습니다.',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    	 // 입력 필드를 비활성화
                        row.find('input').prop('disabled', true);
                        // 점수 입력 버튼 비활성화
                        $(this).prop('disabled', true);
                        // 수정 버튼 활성화
                        row.find('.grade-edit-btn').prop('disabled', false);
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: '문제가 발생했습니다.',
                            text: error,
                            showConfirmButton: true
                        });
                    }
                });
            });

            // 총점 계산 함수 (예시)
            function calculateRank(attendance, score1, score2, homework) {
                // 실제 총점 계산 로직을 구현하세요
                return Math.round((parseInt(attendance) + parseInt(score1) + parseInt(score2) + parseInt(homework)) / 4);
            }
        });
    </script>
    
    <div class="container w-1000 my-50">
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
                        <td>${lectureDto.lectureDepartment}</td>
                        <td>${lectureDto.lectureProfessor}</td>
                        <td>${lectureDto.lectureType}</td>
                        <td>${lectureDto.lectureName}</td>
                        <td>${lectureDto.lectureCode}</td>
                        <td>#</td>
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
                        <th>수정</th>
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
                            <td><button type="button" class="btn btn-positive grade-save-btn" disabled>점수입력</button></td>
                            <td><button type="button" class="btn btn-neutral grade-edit-btn">점수수정</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 점수 등록 -->
            <div class="row">
                <button type="button" class="btn btn-positive w-100 grade-insert-btn">
                    <i class="fa-solid fa-pen"></i> 점수 등록
                </button>
            </div>
        </form>
    </div>

