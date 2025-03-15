function autoResize(textarea) {
	textarea.style.height = "auto";
	textarea.style.height = textarea.scrollHeight + "px";
}
const modal = document.getElementById("qwertyuiop");
const fuck = document.getElementById("createBioModalFuck");
function bioModal() {
	modal.classList.remove("hidden");
	fuck.classList.remove("hidden");
}
function bioEditModal() {
	modal.classList.remove("hidden");
	fuck.classList.remove("hidden");
}
function bioModalCloseFuck() {
	modal.classList.add("hidden");
	fuck.classList.add("hidden");

	document.querySelector("textarea[name='bio']").value = "";
	document.querySelector("textarea[name='bio']").style.height = "auto";
}
document.addEventListener("keydown", (e) => {
	if (e.key === "Escape") bioModalCloseFuck();
});
async function createBio() {
	const val = document.querySelector("textarea[name='bio']");

	try {
		const formData = new URLSearchParams();
		formData.append("bio", val.value);

		const res = await fetch(`${location.origin}/whynot/createBio`, {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded" },
			body: formData
		});

		if (!res.ok) {
			throw new Error(`Server error: ${res.status}`);
		}

		const data = await res.text();
		console.log(`res: ${data} \n data: ${data}`);
		document.getElementById("myBio").innerText = data;
	} catch (error) {
		console.error("Request failed:", error);
	}

	bioModalCloseFuck();
}

























