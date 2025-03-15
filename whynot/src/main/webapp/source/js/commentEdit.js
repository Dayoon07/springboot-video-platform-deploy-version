function openUpdateCommentComponent(commentId) {
    fetch(`${location.origin}/whynot/updateCommentFind`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ val: commentId })
    })
    .then(async (res) => await res.json())
    .then((data) => {
		console.log(data);
        const body = document.querySelector("body");
        const $div = document.createElement("div");
        $div.classList.add("fixed", "top-0", "right-0", "w-96", "h-full", "p-4", "bg-white", "border-l", "z-20", "shadow-lg");
		
        $div.innerHTML = `
            <div class="w-full flex justify-between items-center">
                <h2 class="text-md font-semibold">댓글 수정</h2>
                <p onclick="closeUpdateCommentComponent()" class="text-4xl pr-1 pl-1 pb-1 cursor-pointer hover:bg-gray-200 transition">&times;</p>
            </div>
			<div class="w-full flex items-center my-2">
				<img src="${location.origin + "/whynot/" + data.commenterProfilepath}" class="w-10 h-10 rounded-full object-cover border-0">
				<span class="block text-xl cursor-pointer mx-2 h-full">${data.commenter}</span>
			</div>
            <form action="${location.origin}/whynot/commentEdit" method="post" autocomplete="off" class="flex flex-col">
				<input type="hidden" name="commentId" value="${data.commentId}" required readonly>
				<input type="hidden" name="commentVideo" value="${data.commentVideo}" required readonly>
                <textarea name="commentContent" rows="7" class="w-full p-3 border focus:ring-2 focus:ring-black focus:outline-none resize-none overflow-y-scroll"
                    placeholder="수정할 댓글을 입력하세요">${data.commentContent}</textarea>
                <div class="mt-3 flex justify-end">
                    <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">수정</button>
                </div>
            </form>
        `;
        body.append($div);
    })
    .catch((err) => console.log(err));
}

function closeUpdateCommentComponent() {
    document.querySelector(".fixed.top-0.right-0").remove();
}
