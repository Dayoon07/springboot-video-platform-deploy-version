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
    <title>whynot - 구독자 조회</title>
</head>
<body class="flex flex-col h-screen">
    <%@ include file="/common/header.jsp" %>

    <main class="flex flex-grow border-t" style="height: calc(100% - 76px);">
        <div class="hidden md:block w-64 bg-gray-200">
            <ul>
            	<li><a href="${ cl }/myVideo" class="block p-4 bg-gray-200 hover:bg-white transition">콘텐츠</a></li>
	            <li><a href="${ cl }/myVideo/dashboard" class="block p-4 bg-gray-200 hover:bg-white transition">대시보드</a></li>
	            <li><a href="${ cl }/myVideo/comment" class="block p-4 bg-gray-200 hover:bg-white transition">영상 피드백</a></li>
	            <li><a href="${ cl }/myVideo/myComment" class="block p-4 bg-gray-200 hover:bg-white transition">나의 댓글</a></li>
	            <li><a href="${ cl }/myVideo/subscribe" class="block p-4 bg-white hover:bg-white transition">구독자 조회</a></li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6 overflow-y-scroll" style="width: calc(100% - 256px);">
            <div class="border-b border-gray-200">
                <nav class="flex space-x-4" id="tabs">
                    <button class="py-2 px-4 text-gray-600 border-b-2 border-blue-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('comments')">구독한 유저</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('commentSearch')">구독 유저 검색</button>
                </nav>
            </div>

            <div id="comments" class="mt-6">
                <h1 class="text-2xl font-bold mb-4">모든 구독자 <fmt:formatNumber value="${ mySubscribeLists.size() }" type="number" />명</h1>
				<c:if test="${ empty mySubscribeLists }">
					<h2 class="text-lg text-gray-500">구독한 사람이 없습니다.</h2>
				</c:if>
				    
				<c:if test="${ not empty mySubscribeLists }">
					<c:forEach var="msl" items="${ mySubscribeLists }">
				    	<div class="w-full p-4 flex items-center gap-6 bg-white hover:bg-gray-100 transition">
							<div class="shrink-0">
								<c:if test="${ not empty msl.profileImgPath }">
							    	<a href="${ cl }/channel/${ msl.creatorName }">
							        	<img src="${ fuck += msl.profileImgPath }" alt="${ msl.creatorName }'s profile" class="w-20 h-20 rounded-full object-cover border-2 border-gray-200">
							        </a>
								</c:if>
							</div>
							<div class="flex flex-col gap-2">
								<h1 class="text-xl font-bold text-gray-800">
							        <a href="${ cl }/channel/${ msl.creatorName }">
							        	${ msl.creatorName }
							    	</a>
							    </h1>
							    <p class="text-gray-600">구독자 ${ msl.subscribe }명</p>
								<p class="text-sm text-gray-500">${ msl.bio }</p>
							</div>
						</div>
					</c:forEach>
				</c:if>
            </div>
            
            <div id="commentSearch" class="mt-6 hidden">
                <h1 class="text-2xl font-bold mb-4">구독한 유저 이름 검색</h1>
                <div class="flex items-center my-4">
					<input type="text" id="subscribingName" placeholder="검색할 유저의 이름을 입력하세요" class="w-96 px-4 py-2 text-md border h-10 border-gray-300 border focus:outline-none focus:border-black" required>
					<button onclick="searchSubscrubeingUsername()" class="w-20 h-10 border-gray-300 border-r border-t border-b hover:bg-gray-200 transition">검색</button>
				</div>
				
				<div id="subscribingUserSearchResults"></div>
            </div>
            
        </div>
    </main>
    
	<script src="https://cdn.tailwindcss.com"></script>
    <script src="${ cl }/source/js/searchCommentFetch.js"></script>
	<script src="${ cl }/source/js/script.js"></script>
	<script src="${ cl }/source/js/myVideoTab.js"></script>
	<script src="${ cl }/source/js/main.js"></script>
</body>
</html>