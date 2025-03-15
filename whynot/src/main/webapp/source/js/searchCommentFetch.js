function searchComments() {
	let keyword = document.getElementById("keywordInput").value;

	fetch(`${location.origin}/whynot/searchComments?keyword=${keyword}`)
		.then(response => response.json())
		.then(data => {
			let resultDiv = document.getElementById('searchResults');
			resultDiv.innerHTML = "";

			if (data.length === 0) {
				resultDiv.innerHTML = "<p class='text-gray-500 mt-5'>검색 결과가 없습니다.</p>";
				return;
			}

			data.forEach(comment => {
				console.log(comment);
				resultDiv.innerHTML += `
					<div class="border-b border-gray-300 py-4">
                    	<div class="flex items-start space-x-4">
                        	<a href="${location.origin}/whynot/channel/${comment.commenter}">
                            	<img src="${location.origin + "/whynot/" + comment.commenterProfilepath}" class="w-10 h-10 rounded-full">
                            </a>
							<div class="flex-1">
                            	<p class="text-sm text-gray-500">${comment.datetime}</p>
                                <span class="font-semibold">${comment.commenter}</span>
                                <p class="mt-1 text-gray-700">${comment.commentContent}</p>
							</div>
							<div>
		                        <form action="${location.origin}/whynot/deleteCommentButAdminAccount" method="post" autocomplete="off">
		                        	<input type="hidden" name="commentId" id="commentId" value="${comment.commentId}" required readonly>
		                            <button type="submit" class="hover:underline hover:text-red-500 mr-5">댓글 삭제</button>
								</form>
	                        </div>
                        </div>
					</div>
				`;
			});
		});
}
function searchSubscrubeingUsername() {
	let name = document.getElementById("subscribingName").value;

	fetch(`${location.origin}/selectByMySubscribingUsername?name=${name}`)
		.then(response => response.json())
		.then(data => {
			let resultDiv = document.getElementById('subscribingUserSearchResults');
			resultDiv.innerHTML = "";

			if (!Array.isArray(data) || data.length === 0) {
				resultDiv.innerHTML = "<p class='text-gray-500'>검색 결과가 없습니다.</p>";
				return;
			}

			console.log("데이터 :", data);

			data.forEach(user => {
				resultDiv.innerHTML += `
					<div class="border-b border-gray-300 py-4">
					    <div class="flex items-start space-x-6">
					        <a href="${location.origin}/channel/${user.subscription.subscribingName || '알 수 없음'}">
					            <img src="${user.creator.profileImgPath || '/default-profile.png'}" class="w-16 h-16 rounded-full object-cover">
					        </a>
	
					        <div class="flex-1">
								<a href="${location.origin}/channel/${user.creator.creatorName || '알 수 없음'}" class="font-semibold text-xl">
					            	${user.creator.creatorName || '알 수 없음'}
					            </a>
	
					            <div class="mt-2 text-gray-600">
									<p class="text-gray-500 text-sm">구독자 수 : ${user.creator.subscribe || 0}</p>
					                <p class="text-sm">이메일 : ${user.creator.creatorEmail || '알 수 없음'}</p>
					                <p class="text-sm">구독일 : ${user.subscription.subscribedAt || '알 수 없음'}</p>
					            </div>
	
					            <div class="mt-4 text-gray-700">
					                <p class="text-sm">소개말 : ${user.creator.bio || '없음' }</p>
					            </div>
					        </div>
					    </div>
					</div>
			    `;
			});
		})
		.catch(error => console.error("데이터 전송 중 오류 : ", error));
}