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
    <title>whynot - 나의 댓글</title>
</head>
<body class="flex flex-col h-screen">
    <%@ include file="/common/header.jsp" %>

    <main class="flex flex-grow border-t" style="height: calc(100% - 76px);">
        <div class="hidden md:block w-64 bg-gray-200">
            <ul>
            	<li><a href="${ cl }/myVideo" class="block p-4 bg-gray-200 hover:bg-white transition">콘텐츠</a></li>
	            <li><a href="${ cl }/myVideo/dashboard" class="block p-4 bg-gray-200 hover:bg-white transition">대시보드</a></li>
	            <li><a href="${ cl }/myVideo/comment" class="block p-4 bg-gray-200 hover:bg-white transition">영상 피드백</a></li>
	            <li><a href="${ cl }/myVideo/myComment" class="block p-4 bg-white hover:bg-white transition">나의 댓글</a></li>
	            <li><a href="${ cl }/myVideo/subscribe" class="block p-4 bg-gray-200 hover:bg-white transition">구독자 조회</a></li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6 overflow-y-scroll" style="width: calc(100% - 256px);">
			<h1 class="text-2xl font-bold mb-4">작성한 댓글 ${ myAllComment.size() }개</h1>
            <c:if test="${ empty myAllComment }">
				<h2 class="text-lg text-gray-500">작성한 댓글이 없습니다.</h2>
			</c:if>
            <c:if test="${ not empty myAllComment }">
            	<c:forEach var="mac" items="${ myAllComment }">
            		<div class="p-4">
					    <h2 class="text-xl font-bold text-gray-800">영상 제목 : 
					    	<a href="${ cl }/watch?v=${ mac.videosVo.videoUrl }" class="hover:underline">${ mac.videosVo.title }</a>
					    </h2>
					    <button onclick="myCommentFunc(${ mac.commentVo.commentId })" class="px-4 py-1 mt-1 bg-black text-white text-md rounded-full cursor-pointer hover:opacity-70">댓글 삭제</button>
					    <div class="mt-4 p-3 bg-gray-100 rounded-lg border-l-4 border-blue-500">
					        <p class="text-gray-700"><span class="font-semibold">작성 댓글:</span></p>
					        <pre style="word-wrap: break-word; white-space: pre-wrap;">${ mac.commentVo.commentContent }</pre>
					    </div>
					</div>
            	</c:forEach>
			</c:if>
        </div>
    </main>
    
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="${ cl }/source/js/script.js"></script>
	<script src="${ cl }/source/js/myComment.js"></script>
</body>
</html>