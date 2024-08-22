<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <script type="text/javascript">
        var departmentNameValid = false;
        function checkDemartmentName() {
            var taget = document.querySelector("[name=departmentName]");
        }
    </script>


 <form action="./expand" method="post" autocomplete="off">
        <div class="container w-400 my-50">
            <div class="row center">
                <h1>학과 증설</h1>
            </div>

            <div class="row">
                <label>학과코드</label>
                <div class="row">학과선택</div>
                <label>분류 <i class="fa-solid fa-asterisk"></i></label>
                <select name="departmentName" class="field w-100"
                                                    oninput="checkDemartmentName();">
                    <option value="">선택하세요</option>
                    <option value="기계공학과">기계공학과</option>
                    <option value="경영학과">경영학과</option>
                    <option value="철학과">철학과</option>
                    <option value="국어국문과">국어국문과</option>
                    <option value="수학과">수학과</option>
                    <option value="체육교육과">체육교육과</option>
                    <option value="교양">교양</option>
                    <option value="채플">채플</option>
                </select>
                <div class="success-feedback 00b894">선택 완료</div>
                <div class="fail-feedback d63031">선택하세요</div>
            </div>

            <div class="row">
                <button type="submit" class="btn btn-positive w-100">
                   <i class="fa-solid fa-landmark"></i>
                   학과개설
                </button>
            </div>
        </div>
    </form>

