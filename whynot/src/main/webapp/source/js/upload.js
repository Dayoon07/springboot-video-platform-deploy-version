function validateForm() {
	console.log("폼 검증 시작");

	if (document.getElementById("title").value.trim() === "") {
		alert("영상 제목을 입력하세요.");
		return false;
	}

	if (document.getElementById("tag").value.trim() === "") {
		alert("영상 태그를 입력하세요.");
		return false;
	}

	if (document.getElementById("more").value.trim() === "") {
		alert("영상 설명을 입력하세요.");
		return false;
	}

	// 이미지 프리뷰로 파일 존재 여부 확인 
	const previewImg = document.getElementById("previewImg");
	if (previewImg.classList.contains("hidden")) {
		alert("섬네일 이미지를 선택하세요.");
		return false;
	}

	// 비디오 프리뷰로 파일 존재 여부 확인
	const previewVideo = document.getElementById("previewVideo");
	if (previewVideo.classList.contains("hidden")) {
		alert("영상 파일을 선택하세요.");
		return false;
	}

	console.log("폼 검증 통과");
	return true;
}

/**
 * 파일 업로드 처리를 위한 통합 함수
 * @param {File} file - 처리할 파일 객체
 * @param {string} type - 파일 유형 ('image' 또는 'video')
 * @param {HTMLElement} previewElement - 미리보기를 표시할 요소
 * @param {HTMLInputElement} inputElement - 파일 입력 요소
 * @returns {boolean} - 파일 처리 성공 여부
 */
function handleFile(file, type, previewElement, inputElement) {
	// 1. 파일 존재 검사
	if (!file) {
		return false;
	}

	// 2. 파일 유형 및 확장자 검사
	const allowedExtensions = {
		image: ["jpg", "jpeg", "png", "webp", "svg", "heif", "heic"],
		video: ["mp4", "avi", "mov", "mkv", "wmv", "flv"]
	};

	const maxFileSize = {
		image: 3 * 1024 * 1024,    // 3MB
		video: 100 * 1024 * 1024   // 100MB
	};

	const extension = file.name.split(".").pop().toLowerCase();

	// 확장자 검사
	if (!allowedExtensions[type].includes(extension)) {
		alert(`지원되지 않는 ${type === "image" ? "이미지" : "영상"} 파일 형식입니다. (허용 확장자: ${allowedExtensions[type].join(", ")})`);
		inputElement.value = "";  // 입력 초기화
		return false;
	}

	// 크기 검사
	if (file.size > maxFileSize[type]) {
		alert(`${type === "image" ? "이미지" : "영상"} 파일 크기는 최대 ${type === "image" ? "3MB" : "100MB"}까지 가능합니다.`);
		inputElement.value = "";  // 입력 초기화
		return false;
	}

	// 3. 파일 미리보기 생성
	const reader = new FileReader();
	reader.onload = (e) => {
		if (type === "image") {
			previewElement.src = e.target.result;
			previewElement.classList.remove("hidden");
		} else if (type === "video") {
			previewElement.src = e.target.result;
			previewElement.classList.remove("hidden");

			// 비디오 길이 계산 (비디오인 경우에만)
			const video = document.createElement("video");
			video.preload = "metadata";
			video.onloadedmetadata = function() {
				window.URL.revokeObjectURL(video.src);

				const durationInSeconds = video.duration;
				const minutes = Math.floor(durationInSeconds / 60);
				const seconds = Math.floor(durationInSeconds % 60);
				const formattedTime = `${padZero(minutes)}:${padZero(seconds)}`;

				document.querySelector("input[name='videoLen']").value = formattedTime;
			};
			video.src = URL.createObjectURL(file);
		}
	};

	reader.readAsDataURL(file);
	return true;
}

/**
 * 한 자리 숫자 앞에 0을 붙여 두 자리로 만드는 함수
 */
function padZero(number) {
	return number < 10 ? `0${number}` : number;
}

// 페이지 로드 완료 후 실행
document.addEventListener("DOMContentLoaded", () => {
	// 요소 참조 가져오기
	const imgDropZone = document.getElementById("imgDropZone");
	const videoDropZone = document.getElementById("videoDropZone");
	const imgInput = document.getElementById("imgPath");
	const videoInput = document.getElementById("videoPath");
	const previewImg = document.getElementById("previewImg");
	const previewVideo = document.getElementById("previewVideo");

	// 드래그 이벤트 처리 함수
	const handleDrag = (event, isOver) => {
		event.preventDefault();
		event.currentTarget.classList.toggle("border-blue-500", isOver);
		event.currentTarget.classList.toggle("bg-blue-100", isOver);
	};

	// 드롭 이벤트 처리 함수
	const handleDrop = (event, input, type, previewElement) => {
		event.preventDefault();
		handleDrag(event, false);

		const file = event.dataTransfer.files[0];
		if (handleFile(file, type, previewElement, input)) {
			input.files = event.dataTransfer.files;
		}
	};

	// 이벤트 리스너 등록
	imgDropZone.addEventListener("click", () => imgInput.click());
	videoDropZone.addEventListener("click", () => videoInput.click());

	imgDropZone.addEventListener("dragover", (e) => handleDrag(e, true));
	videoDropZone.addEventListener("dragover", (e) => handleDrag(e, true));

	imgDropZone.addEventListener("dragleave", (e) => handleDrag(e, false));
	videoDropZone.addEventListener("dragleave", (e) => handleDrag(e, false));

	imgDropZone.addEventListener("drop", (e) => handleDrop(e, imgInput, "image", previewImg));
	videoDropZone.addEventListener("drop", (e) => handleDrop(e, videoInput, "video", previewVideo));

	// 파일 선택 이벤트 리스너
	imgInput.addEventListener("change", (e) => {
		const file = e.target.files[0];
		handleFile(file, "image", previewImg, imgInput);
	});

	videoInput.addEventListener("change", (e) => {
		const file = e.target.files[0];
		handleFile(file, "video", previewVideo, videoInput);
	});
});
