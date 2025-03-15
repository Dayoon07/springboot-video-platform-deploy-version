async function myCommentFunc(value) {
    try {
        const res = await fetch(`${location.origin}/whynot/deleteButMyComment?commentId=${value}`, {
            method: "post"
        });
        const data = res.ok ? "삭제 성공" : "삭제 실패";
        console.log(`pk ${await res.text()} ${data}`);
		location.reload();
    } catch (error) {
        console.log(error);
    }
}