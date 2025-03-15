function previewImage(event) {
	const file = event.target.files[0];
	const preview = document.getElementById("profilePreview");
	const uploadText = document.getElementById("uploadText");
	let maxSize = 1024 * 1024;

	if (file) {
		if (file.size > maxSize) {
			alert("프로필 이미지 업로드 최대 용량은 1MB 입니다");
			event.target.value = '';
			return;
		}

		const reader = new FileReader();
		reader.onload = (e) => {
			preview.src = e.target.result;
			preview.classList.remove("hidden");
			uploadText.style.display = "none";
		};
		reader.readAsDataURL(file);
	}
}

$("#profileImgPath").on("change", previewImage);

const phoneInput = document.getElementById("tel");

phoneInput.addEventListener('input', function(e) {
	let inputValue = e.target.value.replace(/\D/g, ''); // 숫자만 남기기

	if (inputValue.length < 4) {
		inputValue = inputValue.replace(/(\d{3})(\d{1,})/, '$1$2'); // 첫 3자리까지만 입력
	} else if (inputValue.length < 7) {
		inputValue = inputValue.replace(/(\d{3})(\d{1,3})/, '$1-$2'); // 네번째 자리에서 하이픈 추가
	} else if (inputValue.length < 11) {
		inputValue = inputValue.replace(/(\d{3})(\d{3})(\d{1,})/, '$1-$2-$3'); // 7번째 자리에서 하이픈 추가
	} else {
		inputValue = inputValue.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'); // 10번째 자리에서 하이픈 추가
	}

	e.target.value = inputValue; // 입력값 업데이트
});