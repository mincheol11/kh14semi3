<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>


<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<style>
.reply-wrapper {
	display: flex;
}

.reply-wrapper>.image-wrapper {
	width: 100px;
	min-width: 100px;
	padding: 10px;
}

.reply-wrapper>.image-wrapper>img {
	width: 100%;
}

.reply-wrapper>.content-wrapper {
	flex-grow: 1;
	font-size: 16px;
}

.reply-wrapper>.content-wrapper>.reply-title {
	font-size: 1.25em;
}

.reply-wrapper>.content-wrapper>.reply-content {
	font-size: 0.95em;
	min-height: 50px;
}

.reply-wrapper>.content-wrapper>.reply-info {
	
}
</style>


<script type="text/javascript">
var editorOptions = {
		
		height:120,
		minheight:120,
		toolbar:[
			['font',['style','fontname','fontsize','forecolor','backcolor']]
			

		],
		disableDragAndDrop:true,
		callbacks:{
			onImageUpload:function(files) {},
			onKeydown:function(){},
			onKeyup:function(){
				console.log("111");
				var content = $(this).val();
				
				//입력값을 이용해서 byte 크기를 계산하는 코드
				var byteCount = getByteLength(content);
				console.log("바이트 : " + byteCount);
			}
		}
	};
	
	//GPT가 알려준 바이트 크기 계산 함수
	function getByteLength(str) {
	    let byteLength = 0;
	    for (let i = 0; i < str.length; i++) {
	        const charCode = str.charCodeAt(i);
	        if (charCode <= 0x7F) {
	            byteLength += 1;  // 1 byte for ASCII
	        } else if (charCode <= 0x7FF) {
	            byteLength += 2;  // 2 bytes for characters in the range U+0080 - U+07FF
	        } else if (charCode <= 0xFFFF) {
	            byteLength += 3;  // 3 bytes for characters in the range U+0800 - U+FFFF
	        } else {
	            byteLength += 4;  // 4 bytes for characters in the range U+10000 - U+10FFFF
	        }
	    }
	    return byteLength;
	}
				
	$(function() {

		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");

		var currentUser = "${sessionScope.createdUser}";

		$(".reply-add-btn").click(function() {
			var content = $(".reply-input").val();
			if (content.length == 0)
				return;

			$.ajax({
				url : "/rest/reply/write",
				method : "post",
				data : {
					replyContent : content,
					replyOrigin : boardNo
				},
				success : function(response) {
					//$(".reply-input").val("");
					$(".reply-input").summernote('code','');
					loadList();
				}

			});
		});
		loadList();
		function loadList(page=1) {

			$
					.ajax({

						url : "/rest/reply/list/paging",
						method : "post",
						data : {
							replyOrigin : boardNo,
							page : page
						},
						success : function(response) {
							
							var backup = null;
							if(page >= 2 ){
							backup = $(".reply-list-wrapper").html();
							
						}
						
							$(".reply-list-wrapper").empty();
							
							if(response.currentPage < response.totalPage){
								
							$("<button>").addClass("btn btn-positive w-100 btn-more")
							.text("이전 댓글 더보기 ("+(response.currentPage+1)+"/"+response.totalPage+")")
							.attr("data-page", page+1)
							.appendTo(".reply-list-wrapper");
							
								}
							
							
							var list = response.list;
							for (var i = 0; i < list.length; i++) {

								var template = $("#reply-template").text();

								var html = $.parseHTML(template);
								$(html).find(".image-wrapper").children("img")
								.attr("src", "/member/image?memberId="+list[i].replyWriter);
							$(html).find(".reply-title").text(list[i].replyWriter);
							$(html).find(".reply-content").text(list[i].replyContent);
								//var time = moment(response[i].replyWtime).fromNow();
								var time = moment(list[i].replyWtime)
										.format("YYYY-MM-DD dddd HH:mm:ss");
								$(html).find(".reply-info > .time").text(time);

								if (list[i].replyWriter == currentUser) {

									$(html)
											.find(
													".reply-edit-btn, .reply-delete-btn")
											.attr("data-reply-no",
													list[i].replyNo);

								} else {
									$(html)
											.find(
													".reply-edit-btn, .reply-delete-btn")
											.remove();

								}

								$(".reply-list-wrapper").append(html);

							}
							if(page >= 2){
								
								
							$(".reply-list-wrapper").append(backup);
							
								}
							}

						});
					}

		//$(".reply-delete-btn").click(function(e){
		$(document).on("click", ".reply-delete-btn", function(e) {

			e.preventDefault();

			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice == false)
				return;

			var replyNo = $(this).attr("data-reply-no");

			$.ajax({

				url : "/rest/reply/delete",
				method : "post",
				data : {
					replyNo : replyNo
				},
				success : function(response) {
					loadList();
				}

			});

		});

		$(document).on(
				"click",
				".reply-edit-btn",
				function(e) {

					e.preventDefault();

					$(".reply-wrapper").show();
					$(".reply-edit-wrapper").remove();

					var template = $("#reply-edit-template").text();
					var html = $.parseHTML(template);

					$(this).parents(".reply-wrapper").after(html);

					$(this).parents(".reply-wrapper").hide();

					var src = $(this).parents(".reply-wrapper").find(".image-wrapper > img").attr("src");
					$(html).find(".image-wrapper > img").attr("src", src);
					var replyWriter = $(this).parents(".reply-wrapper").find(".reply-title").text();
					$(html).find(".reply-title").text(replyWriter);
					var replyContent = $(this).parents(".reply-wrapper").find(".reply-content").text();
					$(html).find(".reply-edit-input").val(replyContent);
					

					var replyNo = $(this).attr("data-reply-no");
					$(html).find(".reply-done-btn").attr("data-reply-no",
							replyNo);
					
					$(html).find(".reply-edit-input").summernote(editorOptions);

				});

		$(document).on(
				"click",
				".reply-cancle-btn",
				function() {

					$(this).parents(".reply-edit-wrapper").prev(
							".reply-wrapper").show();

					$(this).parents(".reply-edit-wrapper").remove();
				});

		$(document).on("click",".reply-done-btn",
				function() {
					var replyContent = $(this).parents(".reply-edit-wrapper")
							.find(".reply-edit-input").val();
					var replyNo = $(this).attr("data-reply-no");

					if (replyContent.length == 0) {
						window.alert("댓글 내용은 반드시 작성해야합니다");
						return;
					}
					$.ajax({

						url:"/rest/reply/edit",
						method:"post",
						data: {

							replyNo : replyNo,
							replyContent : replyContent
						},
						success : function(response) {
							loadList();
						}

					});

				});
		
		$(document).on("click",".btn-more",function(){
			
			var page =$(this).attr("data-page");
			$(this).remove();
			loadList(parseInt(page));
			
			});
		
			
			
			$(".reply-input").summernote(editorOptions);
		

			});
</script>

<script type="text/template" id="reply-template">
	

	<div class="reply-wrapper">
		
		<div class="image-wrapper">
		<img src="https://picsum.photos/100">
		</div>
		
		<div class="content-wrapper">
			<div class="reply-title">댓글 작성자</div>
			<div class="reply-content">댓글 내용</div>
			<div class="reply-info">
			<span class="time">yyyy-MM-dd HH:mm:ss</span>
			<a href="#" class="link link-animation reply-edit-btn">수정</a>
			<a href="#" class="link link-animation reply-delete-btn">삭제</a>

				</div>
			</div>
		</div>
</script>

<script type="text/template" id="reply-edit-template">
	<!-- 댓글 수정 영역 -->
	<div class="reply-wrapper reply-edit-wrapper">
		<!-- 프로필 영역 -->
		<div class="image-wrapper">
			<img src="https://picsum.photos/100">
		</div>

		<!-- 내용 영역 -->
		<div class="content-wrapper">
			<div class="reply-title">댓글 작성자</div>
			<textarea class="field w-100 reply-edit-input"></textarea>
			<div class="right">
				<button class="btn btn-neutral reply-cancel-btn">취소</button>
				<button class="btn btn-positive reply-done-btn">완료</button>
			</div>
		</div>
	</div>
</script>




<script type="text/javascript">
	$(function() {

		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");

		$.ajax({
			url : "/rest/board/check",
			method : "post",
			data : {
				boardNo : boardNo
			},
			success : function(response) {
				if (response.checked) {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass(
							"fa-solid");
				} else {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass(
							"fa-regular");
				}
				$(".fa-heart").next("span").text(response.count);
			}
		});
	});
</script>

<c:if test="${sessionScope.createdUser != null }">
	<script type="text/javascript">
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");
		$(function() {
			$(".fa-heart").click(
					function() {
						$.ajax({
							url : "/rest/board/action",
							method : "post",
							data : {
								boardNo : boardNo
							},
							success : function(response) {
								if (response.checked)
									$(".fa-heart").removeClass(
											"fa-solid fa-regular").addClass(
											"fa-solid");

								else
									$(".fa-heart").removeClass(
											"fa-solid fa-regular").addClass(
											"fa-regular");
								$(".fa-heart").next("span")
										.text(response.count);
							}

						});
					});
		});
	</script>


</c:if>
<div class="container w-800">
	<!-- 제목 -->
	<div class="row">
		<h1>
			${boardDto.boardTitle}
			<c:if test="${boardDto.boardUtime != null}">
				(수정됨)
			</c:if>
		</h1>
	</div>

	<!-- 작성자 -->
	<div class="row">${boardDto.boardWriter}</div>
	<!-- 작성일 -->
	<div class="row right">
		<fmt:formatDate value="${boardDto.boardWtime}"
			pattern="y년 M월 d일 E a h시 m분 s초" />
	</div>
	<!-- 내용 -->
	<div class="row" style="min-height: 200px">
		<!-- pre 태그는 내용을 작성된 형태 그대로 출력한다
				Rich Text Editor를 쓸 경우는 할 필요가 없다 -->
		${boardDto.boardContent}
	</div>
	<!-- 정보 -->
	<div class="row">
		조회
		<fmt:formatNumber value="${boardDto.boardViews}" pattern="#,##0" />
		
		
		
	</div>

	

	<!-- 각종 이동버튼들 -->
	<div class="row right">
		
	<%-- 본인 글만 표시되도록 조건 설정 --%>
		  <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
        <c:set var="isLogin" value="${sessionScope.createdUser != null}" />
		
		  <c:if test="${isLogin && isAdmin}">
            <!-- 관리자만 수정 버튼을 볼 수 있음 -->
            <a class="btn btn-negative" href="edit?boardNo=${boardDto.boardNo}">수정</a>
            <!-- 관리자만 삭제 버튼을 볼 수 있음 -->
            <a class="btn btn-negative" href="delete?boardNo=${boardDto.boardNo}">삭제</a>
            <!-- 관리자만 등록 버튼을 볼 수 있음 -->
            <a class="btn btn-positive" href="write">등록</a>
        </c:if>

		<a class="btn btn-neutral" href="list">목록</a>
	</div>
</div>