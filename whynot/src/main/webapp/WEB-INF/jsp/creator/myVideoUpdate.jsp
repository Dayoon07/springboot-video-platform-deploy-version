<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${ cl }/source/img/videoPlayer-icon.png" type="image/x-icon">
    <link rel="stylesheet" href="${ cl }/source/css/custom.css">
    <title>업로드 영상 수정 - whynot</title>
</head>
<body>
    <%@ include file="/common/header.jsp" %>
    
    <div class="max-w-6xl mx-auto mt-8 p-8 bg-white rounded-lg">
        <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">영상 수정</h1>
        <form action="${ cl }/updateVideo" method="post" enctype="multipart/form-data" class="space-y-8">
            <input type="hidden" name="videoId" value="${ updatingVideo.videoId }">
            <input type="hidden" name="currentImgPath" value="${ updatingVideo.imgPath }">
            <input type="hidden" name="currentVideoPath" value="${ updatingVideo.videoPath }">
            <input type="hidden" name="creatorName" value="${ updatingVideo.creator }">
            
            <div class="flex flex-wrap gap-6">	
	            <div class="space-y-6 w-full px-4">
	                <div>
					    <label for="imgPath" class="block text-lg font-semibold mb-2 text-gray-700">섬네일 이미지</label>
					    <div id="imgDropZone" class="w-full p-6 bg-gray-50 border-2 border-dashed border-gray-300 text-center rounded-lg cursor-pointer">
					        <p class="text-gray-600">이미지를 드래그 앤 드롭 <br> 하거나 클릭하여 선택하세요</p>
					        <input type="file" id="imgPath" name="imgPath" accept="image/*" class="hidden" value="${ fuck += updatingVideo.imgPath }">
					    </div>
					    <div id="thumbnailPreview" class="mt-4 flex justify-center items-center">
					        <img id="previewImg" class="hidden w-full object-cover border rounded-md">
					    </div>
					</div>
					
					<div>
					    <label for="videoPath" class="block text-lg font-semibold mb-2 text-gray-700">영상 파일</label>
					    <div id="videoDropZone" class="w-full p-6 bg-gray-50 border-2 border-dashed border-gray-300 text-center rounded-lg cursor-pointer">
					        <p class="text-gray-600">영상을 드래그 앤 드롭 <br> 하거나 클릭하여 선택하세요</p>
					        <input type="file" id="videoPath" name="videoPath" accept="video/*" class="hidden" value="${ fuck += updatingVideo.videoPath }" onchange="videoLen(event)">
					    </div>
					    <div id="videoPreview" class="mt-4 flex justify-center items-center">
					        <video id="previewVideo" class="hidden w-full border rounded-md" controls></video>
					    </div>
					</div>
					
					<div>
						<input type="hidden" name="videoLen" value="${ updatingVideo.videoLen }">
					</div>
	            </div>
	            
	            <div class="space-y-6 w-full px-4">
	                <div>
	                    <label for="title" class="block text-lg font-semibold mb-2 text-gray-700">영상 제목</label>
	                    <textarea class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400 resize-none" 
	                    	id="title" name="title" placeholder="영상 제목을 입력하세요" rows="3" required>${ updatingVideo.title }</textarea>
	                </div>
	                <div>
	                    <label for="tag" class="block text-lg font-semibold mb-2 text-gray-700">영상 태그</label>
	                    <input class="w-full p-3 bg-gray-50 rounded-lg border border-gray-300 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400" 
	                    	id="tag" name="tag" placeholder="태그를 입력하세요" value="${ updatingVideo.tag }">
	                </div>
	                <div>
	                    <label for="more" class="block text-lg font-semibold mb-2 text-gray-700">영상 설명</label>
	                    <textarea id="more" name="more" rows="15" placeholder="영상 설명을 입력하세요" class="resize-none w-full p-3 bg-gray-50 rounded-lg border border-gray-300 
	                    	text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400">${ updatingVideo.more }</textarea>
	                </div>
	            </div>
	        </div>

            <div class="text-right space-x-4">
                <button type="button" onclick="history.back()" class="bg-gray-500 hover:bg-gray-400 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300">
                    취소
                </button>
                <button type="submit" class="bg-red-600 hover:bg-red-400 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300">
                    수정하기
                </button>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.tailwindcss.com"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="${ cl }/source/js/upload.js"></script>
	<script src="${ cl }/source/js/script.js"></script>
	
	<script>
		document.addEventListener("DOMContentLoaded", function () {
		    const imgInput = document.getElementById("imgPath");
		    const videoInput = document.getElementById("videoPath");
		    const previewImg = document.getElementById("previewImg");
		    const previewVideo = document.getElementById("previewVideo");
	
		    // 기존 데이터 불러와서 미리보기 설정
		    const existingImg = imgInput.getAttribute("value");
		    const existingVideo = videoInput.getAttribute("value");
	
		    if (existingImg) {
		        previewImg.src = existingImg;
		        previewImg.classList.remove("hidden");
		    }
	
		    if (existingVideo) {
		        previewVideo.src = existingVideo;
		        previewVideo.classList.remove("hidden");
		    }
	
		    // 이미지 미리보기 업데이트
		    imgInput.addEventListener("change", function (event) {
		        const file = event.target.files[0];
		        if (file) {
		            const reader = new FileReader();
		            reader.onload = function (e) {
		                previewImg.src = e.target.result;
		                previewImg.classList.remove("hidden");
		            };
		            reader.readAsDataURL(file);
		        }
		    });
	
		    // 영상 미리보기 업데이트
		    videoInput.addEventListener("change", function (event) {
		        const file = event.target.files[0];
		        if (file) {
		            const url = URL.createObjectURL(file);
		            previewVideo.src = url;
		            previewVideo.classList.remove("hidden");
		        }
		    });
		});
	</script>
</body>
</html>