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
	<title>정보 수정 확인 - whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>

	<div class="mt-24 flex items-center justify-center text-black">
	    <div class="bg-gray-200 p-8 rounded-lg shadow-lg w-96">
	        <h2 class="text-center text-2xl font-bold mb-4">비밀번호확인</h2>
	        <form action="${ cl }/confirmPassword" method="post">
	            <div class="mb-4">
	                <label for="creatorPassword" class="block text-sm mb-2">비밀번호를 입력해주세요</label>
	                <input type="password" id="creatorPassword" name="creatorPassword" class="w-full p-2 rounded bg-white text-black focus:outline-none focus:ring-2 focus:ring-black" required>
	            </div>
	            <button type="submit" class="w-full bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded">확인</button>
	        </form>
	        <p class="mt-4 text-center text-sm">
	            계정을 삭제 하시겠습니까? <span class="text-red-600 hover:underline cursor-pointer" onclick="openDeleteAccountModal()">계정삭제</span>
	        </p>
	    </div>
	</div>
	
	<div class="fixed top-0 left-0 w-full h-full z-70 bg-black opacity-50 hidden" id="deleteMyAccountBg"></div>
	<div style="position: fixed; top: 25%; left: 50%; transform: translate(-50%, 0%); z-index: 80;" class="hidden" id="deleteMyAccount">
	    <div class="bg-white rounded-lg shadow-lg p-8 md:max-w-md md:w-full w-80">
	        <h2 class="text-center text-xl font-semibold text-red-600 mb-4">정말로 계정을 <br class="md:hidden"> 삭제하시겠습니까?</h2>
	        <p class="text-center text-sm text-gray-700 mb-6">계정을 삭제하면 모든 데이터가 영구적으로 사라집니다. 이 작업은 되돌릴 수 없습니다.</p>
	        <form action="${ cl }/deleteAccount" method="post" autocomplete="off">
	            <input type="text" name="creatorId" value="${ sessionScope.creatorSession.creatorId }" class="hidden" required readonly>
				<button type="submit" class="w-full bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-500 focus:outline-none focus:ring-2 focus:ring-red-600">
	            	삭제
	            </button>
	            <button type="button" class="w-full mt-2 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-400"
	            	onclick="closeDeleteAccountModal()">
	            	취소
	            </button>
	        </form>
	    </div>
	</div>

	<script src="https://cdn.tailwindcss.com"></script>
	<script src="${ cl }/source/js/script.js"></script>
</body>
</html>