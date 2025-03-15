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
	<title>회원가입 - whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="mt-12 mx-auto bg-gray-200 p-8 rounded-lg shadow-lg w-96 text-black">
	    <h2 class="text-center text-2xl font-bold mb-4">회원가입</h2>
	    <form action="${ cl }/signupF" method="post" autocomplete="off" enctype="multipart/form-data">
	    	<div class="mb-4">
				<label for="profileImgPath" class="block text-sm mb-2">프로필 이미지</label>
	            <div class="relative bg-white rounded p-3 flex flex-col items-center justify-center border-2 border hover:border-black">
	            	<input type="file" id="profileImgPath" name="profileImgPath" class="absolute inset-0 opacity-0 w-full h-full cursor-pointer" accept="image/*" onchange="previewImage(event)">
	                <img id="profilePreview" src="#" alt="미리보기" class="hidden w-28 h-28 object-cover rounded-full" title="미리보기">
	                <p id="uploadText" class="text-sm text-gray-400">이미지를 업로드하려면 <br> 클릭하거나 드래그하세요</p>
				</div>
			</div>
	        <div class="mb-4">
	        	<label for="creatorName" class="block text-sm mb-2">사용자 이름</label>
	            <input type="text" id="creatorName" name="creatorName" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" required>
			</div>
	        <div class="mb-4">
	        	<label for="creatorEmail" class="block text-sm mb-2">이메일</label>
	            <input type="email" id="creatorEmail" name="creatorEmail" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" required>
			</div>
	        <div class="mb-4">
	        	<label for="creatorPassword" class="block text-sm mb-2">비밀번호</label>
	            <input type="text" id="creatorPassword" name="creatorPassword" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" required>
			</div>
	        <div class="mb-4">
	        	<label for="tel" class="block text-sm mb-2">전화번호</label>
	            <input type="tel" id="tel" name="tel" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" maxlength="13" required>
			</div>
	        <button type="submit" class="w-full bg-red-600 hover:bg-red-500 text-white py-2 rounded">회원가입</button>
	    </form>
	    <p class="mt-4 text-center text-sm">
	        이미 계정이 있으신가요? <a href="${ cl }/login" class="text-red-600 hover:underline">로그인</a>
	    </p>
	</div>
	
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="${ cl }/source/js/signupImgLoad.js"></script>
	<script src="${ cl }/source/js/script.js"></script>
</body>
</html>