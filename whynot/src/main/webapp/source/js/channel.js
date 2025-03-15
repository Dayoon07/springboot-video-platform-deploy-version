document.addEventListener('DOMContentLoaded', function() {
	document.getElementById('latest').classList.remove('hidden');
	document.querySelectorAll('.tab-button')[0].classList.add('border-red-500', 'text-red-500', 'border-b-2');
});
function showTab(tab, event) {
	document.querySelectorAll('.tab-con').forEach(el => el.classList.add('hidden'));
	document.getElementById(tab).classList.remove('hidden');

	document.querySelectorAll('.tab-button').forEach(btn => {
		btn.classList.remove('border-red-500', 'text-red-500');
		btn.classList.remove('border-b-2'); // 비활성 탭의 밑줄 제거
	});
	event.target.classList.add('border-red-500', 'text-red-500', 'border-b-2');
}

function openModal() {
	document.getElementById("modalOverlay").classList.remove("hidden");
	document.getElementById("modalContent").classList.remove("hidden");
}
function closeModal() {
	document.getElementById("modalOverlay").classList.add("hidden");
	document.getElementById("modalContent").classList.add("hidden");
}
document.addEventListener("DOMContentLoaded", function() {
	document.addEventListener("keydown", function(event) {
		if (event.key === "Escape") {
			closeModal();
		}
	});
});