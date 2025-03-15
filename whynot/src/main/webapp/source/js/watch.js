document.addEventListener("keydown", (e) => {
	const video = document.querySelector("video");

	if (e.key === "l") {
		video.currentTime += 10;
	} else if (e.key === "j") {
		video.currentTime -= 10;
	} else if (e.key === "k") {
		if (video.paused) {
			video.play();
		} else {
			video.pause();
		}
	}
});

function autoResize(textarea) {
	textarea.style.height = "auto";
	textarea.style.height = textarea.scrollHeight + "px";

	document.getElementById("commentContentLength").textContent = document.getElementById("commentContent").value.length;
}