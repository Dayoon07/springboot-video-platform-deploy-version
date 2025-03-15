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
    <title>whynot - 대시보드</title>
</head>
<body class="flex flex-col h-screen">
    <%@ include file="/common/header.jsp" %>

    <main class="flex flex-grow border-t" style="height: calc(100% - 76px);">
	    <div class="hidden md:block w-64 bg-gray-200">
            <ul>
            	<li><a href="${ cl }/myVideo" class="block p-4 bg-gray-200 hover:bg-white transition">콘텐츠</a></li>
	            <li><a href="${ cl }/myVideo/dashboard" class="block p-4 bg-white hover:bg-white transition">대시보드</a></li>
	            <li><a href="${ cl }/myVideo/comment" class="block p-4 bg-gray-200 hover:bg-white transition">영상 피드백</a></li>
	            <li><a href="${ cl }/myVideo/myComment" class="block p-4 bg-gray-200 hover:bg-white transition">나의 댓글</a></li>
	            <li><a href="${ cl }/myVideo/subscribe" class="block p-4 bg-gray-200 hover:bg-white transition">구독자 조회</a></li>
            </ul>
        </div>
	
	    <div class="flex-grow bg-white p-6 overflow-y-scroll" style="width: calc(100% - 256px);">
	        <h2 class="text-3xl font-bold mb-6 text-gray-900">📊 대시보드</h2>
	
	        <div class="text-center p-6 border border-gray-300 rounded-lg bg-white">
	            <h4 class="text-lg font-semibold text-gray-700">구독자 수</h4>
	            <p id="subscribeCount" class="text-4xl font-bold">
					<fmt:formatNumber value="${ sessionScope.creatorSession.subscribe }" />
				</p>
	        </div>
	
	        <div class="bg-white p-6 rounded-lg shadow-lg mt-6">
	            <h3 class="text-2xl font-semibold mb-6 text-gray-800">📈 영상 통계</h3>
	
	            <div class="grid grid-cols-1 sm:grid-cols-1 lg:grid-cols-2 gap-6">
	                <div class="text-center p-6 border border-gray-300 rounded-lg bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">업로드된 영상</h4>
	                    <p class="text-4xl font-bold text-indigo-600">
	                    	<fmt:formatNumber value="${ countMyVideos != null && countMyVideos != 0 ? countMyVideos : 0 }" type="number" />
	                    </p>
	                </div>
	                <div class="text-center p-6 border border-gray-300 rounded-lg bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">총 조회수</h4>
	                    <p class="text-4xl font-bold text-green-600">
	                    	<fmt:formatNumber value="${ sumMyVideosViews != null && sumMyVideosViews != 0 ? sumMyVideosViews : 0 }" type="number" />
	                    </p>
	                </div>
	            </div>
	
	            <div class="grid grid-cols-1 sm:grid-cols-1 lg:grid-cols-2 gap-6 mt-6">
	                <div class="text-center p-6 border border-gray-300 rounded-lg bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">모든 좋아요</h4>
	                    <p class="text-4xl font-bold text-red-500">
	                    	<fmt:formatNumber value="${ sumMyVideosLikes != null && sumMyVideosLikes != 0 ? sumMyVideosLikes : 0 }" type="number" />
	                    </p>
	                </div>
	                <div class="text-center p-6 border border-gray-300 rounded-lg bg-gray-50">
	                    <h4 class="text-lg font-semibold text-gray-700">모든 댓글 수</h4>
	                    <p class="text-4xl font-bold text-yellow-500">
	                    	<fmt:formatNumber value="${ commentCntMyVideos != null && commentCntMyVideos != 0 ? commentCntMyVideos : 0 }" type="number" />
	                    </p>
	                </div>
	            </div>
	        </div>
	    </div>
	</main>
	
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="${ cl }/source/js/script.js"></script>
	<script src="${ cl }/source/js/dashboardLiveChangeSubscri.js"></script>
	<script src="${ cl }/source/js/myVideoTab.js"></script>
</body>
</html>