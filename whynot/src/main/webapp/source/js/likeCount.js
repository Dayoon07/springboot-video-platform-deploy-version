const likeVal = document.getElementById("likeCount").value;
const id = document.getElementById("likeCountButVideoId").value;

document.addEventListener("DOMContentLoaded", () => {
	"use strict";
	
	writeLikeValue();
	setTimeout(writeLikeValue, 1500);
});

function writeLikeValue() {
	fetch(`${location.origin}/whynot/likeCount?param=${likeVal}&id=${id}`, {
			method: "post"})
			.then(res => res.json())
			.then((data) => {
				if (document.getElementById("watchTheVideoLikeVal") != null) {
					console.log(data);
					document.getElementById("watchTheVideoLikeVal").textContent = data;
				} else {
					console.log(data);	
				}
			})
			.catch((err) => {
				console.log(err);
			});
}

function addLike() {	
	fetch(`${location.origin}/whynot/likeCount?param=${likeVal}&id=${id}`, {method: "post"})
		.then(res => res.json())
		.then((data) => {
			document.getElementById("watchTheVideoLikeVal").textContent = data;
			console.log(data);
		})
		.catch((err) => {
			console.log(err);
		});
}
