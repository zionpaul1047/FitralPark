<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FITRALPARK</title>
<%@ include file="/WEB-INF/views/common/asset.jsp" %>
<script src="https://kit.fontawesome.com/7abd1088b7.js" crossorigin="anonymous"></script>
<style>
	body {
	background-color: rgb(218, 243, 211);
	
	}  
	.grid{
		display: grid;
		grid-template-rows: 125px auto 1fr;
		grid-template-columns: 1fr;
		min-height: 100%;
	}
	.grid_top{
		/* border: 1px solid black; */
		grid-row: 1;
	}
	.grid_center{
		/* border: 1px solid black; */
		grid-row: 2;
		display: grid;
		grid-template-columns: calc(50% - 424px) auto;
	}
	.grid_center_L{
	/* border: 1px solid black; */
	}
	.grid_center_R{
	/* border: 1px solid black; */
	}
	.grid_bottom{
	/* border: 1px solid black; */
		grid-row: 3;
	}
	
	main {
		display: flex;
		justify-content: flex-start;
		margin-bottom: 50px;
	}
	
	#mainbox {
		border-radius: 20px;
		background-color: #FFFFFF;
		border: 2px solid #000000;
	}

	body h1 {
		font-size: 30px;
		padding: 50px;
	}
	
	#smallbox {
		padding: 20px;
	}

	/* 게시글 상세 스타일 */
	#posttable {
		text-align: inherit;
		width: 1000px;  
		padding: 50px;
		border-radius: 20px;
		border-top: 2px solid #000000;
		border-bottom: 2px solid #000000;
	}

	#posttable td, th {
		text-align: left;
		padding: 15px 0;
		border-top: 1px solid #000000;
		border-bottom: 1px solid #000000;
		font-size: 12px;
	}

	/* 게시글 컬럼 너비 */
	#posttable th:nth-child(1) { width: 100px; }  /* 라벨 */
	#posttable th:nth-child(2) { width: auto; }   /* 내용 */

	/* 게시글 내용 영역 */
	#post_content {
		min-height: 300px;
		padding: 20px;
		white-space: pre-wrap;
	}

	/* 버튼 영역 */
	#button_area {
		display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-top: 20px;
	    padding: 0 10px;
	}

	#button_area button {
		padding: 10px 20px;
		border-radius: 20px;
		border: 2px solid #000000;
		cursor: pointer;
		transition: background-color 0.3s ease;
        margin: 0 5px;		
	}

	#button_area button:hover {
		background-color: #f5f5f5;
		border-color: #999;
	}

	/* 게시글 호버 효과 */
	#posttable td a {
		color: #333;
		text-decoration: none;
		transition: all 0.3s ease;
	}

	#posttable td a:hover {
		background-color: #f5f5f5;
		cursor: pointer;
		color: #666666;
	}

	/* 추천/비추천 버튼 스타일 */
	.recommend_area {
		padding-top: 10px;
		padding-bottom: 10px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}

	.recommend_container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
    }

    .recommend_button,
    .decommend_button,
	#comment_btn  {
        color: black;
        padding: 10px 20px;
		border: 2px solid #000000;
        cursor: pointer;
        margin: 0 10px;
        border-radius: 5px;
        
    }

	/* 댓글 영역 스타일 */
	#comment_area {
	    margin-top: 20px;
	    padding: 20px;
	    border-top: 1px solid #000;
	}

	.comment_item {
	    margin-bottom: 10px;
	    padding: 10px;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	}

	.comment_header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 5px;
	}

	.comment_nickname {
	    font-weight: bold;
	}

	/* 댓글 입력 스타일 */
	#comment_form {
	    margin-top: 20px;
	    padding: 20px;
	    border-top: 1px solid #000;
	    border-bottom: 1px solid #000;
	}

	#comment_textarea {
	    width: 100%;
	    height: 100px;
	    padding: 10px;
	    margin-bottom: 10px;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    resize: none; /* 크기 조절 불가능 */
	}
	
	.edit_area {
	    margin-top: 10px;
	}

	.edit_textarea {
	    width: 100%;
	    min-height: 60px;
	    margin-bottom: 10px;
	    padding: 8px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    resize: vertical;
	}

	.edit_buttons {
	    display: flex;
	    gap: 10px;
	    margin-top: 10px;
	}

	.edit_buttons button {
	    padding: 10px 20px;
	    border-radius: 20px;
	    border: 2px solid #000000;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	    background-color: #FFFFFF;
	    color: #000000;
	}

	.edit_buttons button:hover {
	    background-color: #f5f5f5;
	    border-color: #999;
	}

	.save-btn {
	    background-color: #FFFFFF !important;
	}

	.cancel-btn {
	    background-color: #FFFFFF !important;
	}

	.edit_buttons button:hover {
	    opacity: 0.9;
	}
	
</style>
</head>
<body>
	<div class="grid">
	
		<div class="grid_top">

				<!-- 메인메뉴 -->
			    <%@ include file="/WEB-INF/views/common/header.jsp" %>
			    <!-- 오른쪽메뉴 -->
			    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
			    <!-- 왼쪽메뉴 -->
			    <%@ include file="/WEB-INF/views/common/left_menu_community.jsp" %>
		</div>
		
		<div class="grid_center">
		
			<div class="grid_center_L"></div>
			
			<div class="grid_center_R">
				
				<main>
				
				<div id="mainbox">
				<div id="smallbox">
				<h1>
					<strong>공지사항</strong>
				</h1>
				<table id="posttable">
					<tr>
						<th>제목</th>
						<td>[${post.header_name}] ${post.post_subject}</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${post.nickname}(${post.creator_id})</td>
						<th>작성일</th>
						<td>${post.regdate}</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${post.views}</td>
						<th>추천수</th>
						<td>${post.post_recommend}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td id="post_content">${post.post_content}</td>
					</tr>
				</table>
				
				<!-- 추천, 비추천 -->
				<div class="recommend_area">
					<button type="button" id="btn_recommend" class="recommend_button" data-post_no="${post.post_no}"><i class="fa-regular fa-thumbs-up"></i>추천</button>
					<span id="recommend_count" class="recommend_count" >${post.post_recommend}</span>
					<button type="button" id="btn_decommend" class="decommend_button" data-post_no="${post.post_no}"><i class="fa-regular fa-thumbs-down"></i>비추천</button>
					<span id="decommend_count" class="decommend_count">${post.post_decommend}</span>
				</div>
				
				<div id="comment_form">
					<form action="/fitralpark/announcementPostOK.do" method="post">
						<input type="hidden" name="post_no" value="${post.post_no}">
						<textarea id="comment_textarea" name="comment_content" placeholder="댓글을 입력하세요."></textarea>
						<div>
							<button id="comment_btn" type="submit">댓글 작성</button>
						</div>
					</form>
				</div>

				<!-- 댓글 띄우기 -->
				<div id="comment_area">
				<c:forEach items="${Comment_list}" var="commentDto">
					<div class="comment_item" data-comment-no="${commentDto.comment_no}">
						<div class="comment_header">
							<div class="comment_nickname">
								<a href="">${commentDto.nickname}(${commentDto.creator_id})</a>
                                
								<c:if test="${loginUser.memberId eq commentDto.creator_id}">
									<button type="button" class="edit-btn" onclick="toggleEdit(this, '${commentDto.comment_no}', '${commentDto.creator_id}')">
										<i class="fa-regular fa-pen-to-square"></i>
									</button>
									<button type="button" onclick="deleteComment('${commentDto.comment_no}', '${commentDto.creator_id}')">
										<i class="fa-solid fa-xmark"></i>
									</button>
								</c:if>
							</div>
							<div class="comment_regdate">
								${commentDto.regdate}
							</div>
						</div>
						<div class="comment_content" id="content_${commentDto.comment_no}">
							${commentDto.comment_content}
						</div>
						<div class="edit_area" id="edit_${commentDto.comment_no}" style="display: none;">
							<textarea class="edit_textarea">${commentDto.comment_content}</textarea>
							<div class="edit_buttons">
								<button type="button" class="save-btn" onclick="saveComment('${commentDto.comment_no}')">저장</button>
								<button type="button" class="cancel-btn" onclick="cancelEdit('${commentDto.comment_no}')">취소</button>
							</div>
						</div>
					</div>
				</c:forEach>
				</div>
			
				<div id="button_area">
					<div class="left_button">
						<button type="button" onclick="location.href='announcementList.do'">목록</button>
					</div>
					<div class="right_button">
						<button type="button" onclick="location.href='announcementPostEdit.do?post_no=${post.post_no}'">수정</button>
						<button type="button" onclick="window.open('announcementPostDel.do?post_no=${post.post_no}', 'deletePopup', 'width=500,height=300,resizable=no,scrollbars=no')">삭제</button>
					</div>
				</div>
				</div>
				</div>
				</main>
				
			</div>
			
		</div>
		
		<div class="grid_bottom">
				<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
		
	</div>


   
</body>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(document).ready(function() {
		
		// 추천 버튼 클릭 이벤트
		$("#btn_recommend").click(function() {
			var postNo = $(this).data("post_no");
			updateRecommend(postNo, "0");
		});

		// 비추천 버튼 클릭 이벤트
		$("#btn_decommend").click(function() {
			var postNo = $(this).data("post_no");
			updateRecommend(postNo, "1");
		});

		// 추천/비추천 업데이트 함수
		function updateRecommend(post_no, vote_check) {
			$.ajax({
				url: "${pageContext.request.contextPath}/announcementPostOK.do",
				type: "POST",
				data: {
					post_no: post_no,
					vote_check: vote_check
				},
				success: function(data) {
					if (data.success) {
						$("#recommend_count").text(data.post_recommend);
						$("#decommend_count").text(data.post_decommend);
						window.location.reload();
					} else {
						window.location.reload();
					}
				},
				error: function(error) {
					console.error("Error:", error);
					alert("추천/비추천 처리 중 오류가 발생했습니다.");
				}
			});
		}
	});

	//댓글 수정
	function toggleEdit(button, commentNo, creatorId) {
		const contentDiv = document.getElementById('content_' + commentNo);
		const editDiv = document.getElementById('edit_' + commentNo);
		
		if (!contentDiv || !editDiv) {
			console.error('Required elements not found');
			return;
		}
		
		const textarea = editDiv.querySelector('.edit_textarea');
		if (!textarea) {
			console.error('Textarea not found');
			return;
		}
		
		contentDiv.style.display = 'none';
		editDiv.style.display = 'block';
		textarea.value = contentDiv.textContent.trim();
		textarea.focus();
	}

	function cancelEdit(commentNo) {
		const contentDiv = document.getElementById('content_' + commentNo);
		const editDiv = document.getElementById('edit_' + commentNo);
		
		contentDiv.style.display = 'block';
		editDiv.style.display = 'none';
	}

	function saveComment(commentNo) {
		const editDiv = document.getElementById('edit_' + commentNo);
		const textarea = editDiv.querySelector('.edit_textarea');
		const commentContent = textarea.value.trim();
		const commentItem = editDiv.closest('.comment_item');
		const creatorId = commentItem.querySelector('.comment_nickname').textContent.match(/\((.*?)\)/)[1];
		const postNo = '${post.post_no}';

		if (commentContent === '') {
			alert('댓글 내용을 입력해주세요.');
			return;
		}

		$.ajax({
			url: '/fitralpark/announcementCommentEditOK.do',
			type: 'POST',
			data: {
				comment_no: commentNo,
				comment_content: commentContent,
				comment_creator_id: creatorId,
				post_no: postNo
			},
			dataType: 'json',
			success: function(response) {
				if (response.status === 'success') {
					const contentDiv = document.getElementById('content_' + commentNo);
					contentDiv.textContent = commentContent;
					cancelEdit(commentNo);
				} else {
					alert(response.message);
				}
			},
			error: function() {
				alert('댓글 수정 중 오류가 발생했습니다.');
			}
		});
	}

	function deleteComment(commentNo, creatorId) {
		if(confirm('댓글을 삭제하시겠습니까?')) {
			var form = document.createElement('form');
			form.method = 'POST';
			form.action = 'announcementCommentDelOK.do';
			
			var commentNoInput = document.createElement('input');
			commentNoInput.type = 'hidden';
			commentNoInput.name = 'comment_no';
			commentNoInput.value = commentNo;
			
			var creatorIdInput = document.createElement('input');
			creatorIdInput.type = 'hidden';
			creatorIdInput.name = 'comment_creator_id';
			creatorIdInput.value = creatorId;

			var postNoInput = document.createElement('input');
			postNoInput.type = 'hidden';
			postNoInput.name = 'post_no';
			postNoInput.value = '${post.post_no}';
			
			form.appendChild(commentNoInput);
			form.appendChild(creatorIdInput);
			form.appendChild(postNoInput);
			document.body.appendChild(form);
			form.submit();
		}
	}

</script>
	

</html> 