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
	<title>로그인 - whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="mt-6 flex items-center justify-center text-black">
	    <div class="bg-gray-200 p-8 rounded-lg shadow-lg w-96">
	        <h2 class="text-center text-2xl font-bold mb-4">로그인</h2>
	        <form action="${ cl }/loginF" method="post">
	            <div class="mb-4">
	                <label for="creatorName" class="block text-sm mb-2">사용자 이름</label>
	                <input type="text" id="creatorName" name="creatorName" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" required>
	            </div>
	            <div class="mb-4">
	                <label for="creatorPassword" class="block text-sm mb-2">비밀번호</label>
	                <input type="password" id="creatorPassword" name="creatorPassword" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" required>
	            </div>
	            <button type="submit" class="w-full bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded">로그인</button>
	        </form>
	        <p class="mt-4 text-center text-sm">
	            아직 계정이 없으신가요? <a href="${ cl }/signup" class="text-red-600 hover:underline">회원가입</a>
	        </p>
	    </div>
	</div>
	
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="${ cl }/source/js/script.js"></script>
	
</body>
</html>