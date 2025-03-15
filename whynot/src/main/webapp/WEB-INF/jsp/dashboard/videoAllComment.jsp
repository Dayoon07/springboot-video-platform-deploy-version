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
    <title>whynot - 영상 피드백</title>
</head>
<body class="flex flex-col h-screen">
    <%@ include file="/common/header.jsp" %>

    <main class="flex flex-grow border-t" style="height: calc(100% - 76px);">
        <div class="hidden md:block w-64 bg-gray-200">
            <ul>
            	<li><a href="${ cl }/myVideo" class="block p-4 bg-gray-200 hover:bg-white transition">콘텐츠</a></li>
	            <li><a href="${ cl }/myVideo/dashboard" class="block p-4 bg-gray-200 hover:bg-white transition">대시보드</a></li>
	            <li><a href="${ cl }/myVideo/comment" class="block p-4 bg-white hover:bg-white transition">영상 피드백</a></li>
	            <li><a href="${ cl }/myVideo/myComment" class="block p-4 bg-gray-200 hover:bg-white transition">나의 댓글</a></li>
	            <li><a href="${ cl }/myVideo/subscribe" class="block p-4 bg-gray-200 hover:bg-white transition">구독자 조회</a></li>
            </ul>
        </div>

        <div class="flex-grow bg-white p-6 overflow-y-scroll" style="width: calc(100% - 256px);">
            <div class="border-b border-gray-200">
                <nav class="flex space-x-4" id="tabs">
                    <button class="py-2 px-4 text-gray-600 border-b-2 border-blue-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('comments')">모든 댓글</button>
                    <button class="py-2 px-4 text-gray-600 hover:text-blue-600 hover:border-blue-600 transition" onclick="showTab('commentSearch')">댓글 검색</button>
                </nav>
            </div>

            <div id="comments" class="mt-6">
                <h1 class="text-2xl font-bold mb-4">모든 댓글 ${ myVideoCommentList.size() }개</h1>
                <c:if test="${ empty myVideoCommentList }">
					<h2 class="text-lg text-gray-500">영상에 달린 댓글이 없습니다.</h2>
				</c:if>
                <c:if test="${ not empty myVideoCommentList }">
                	<c:forEach var="mvcl" items="${ myVideoCommentList }">
						<div class="p-4 hover:bg-gray-100 transition">
							<div class="flex items-start space-x-4">
						    	<img src="${ fuck += mvcl.commentVo.commenterProfilepath }" class="w-10 h-10 rounded-full">
						
						        <div class="w-full flex justify-between">
					            	<div>
					                	<span class="text-sm text-gray-500">
					                		${ mvcl.commentVo.datetime }
					                		<c:if test="${ mvcl.videosVo.title.length() < 9 }"> • </c:if>
					                		<c:if test="${ mvcl.videosVo.title.length() > 9 }"><br></c:if>
					                		<a href="${ cl }/watch?v=${ mvcl.videosVo.videoUrl }" class="hover:text-black">${ mvcl.videosVo.title }</a>
					                	</span><br>
							            <span class="font-semibold text-md">${ mvcl.commentVo.commenter }</span>
								        <p class="mt-1 text-gray-700 whitespace-pre-wrap w-4/5">${ mvcl.commentVo.commentContent }</p>
					                </div>
									<div>
					                	<form action="${ cl }/deleteCommentButAdminAccount" method="post" autocomplete="off">
											<input type="hidden" name="commentId" id="commentId" value="${ mvcl.commentVo.commentId }" required readonly>
			                        		<button type="submit" class="hover:underline hover:text-red-500 mr-5">댓글 삭제</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
            </div>
            
            <div id="commentSearch" class="mt-6 hidden">
                <h1 class="text-2xl font-bold mb-4">댓글 검색</h1>
                <div class="flex items-center">
                	<input type="text" id="keywordInput" placeholder="검색할 키워드를 입력하세요" class="w-96 px-4 py-2 text-md border h-10 border-gray-300 border focus:outline-none focus:border-black" required>
			    	<button onclick="searchComments()" class="w-20 h-10 border-gray-300 border-r border-t border-b hover:bg-gray-200 transition">검색</button>
				</div>
				
				<div id="searchResults"></div>
            </div>
            
        </div>
    </main>
    
	<script src="https://cdn.tailwindcss.com"></script>
    <script src="${ cl }/source/js/searchCommentFetch.js"></script>
	<script src="${ cl }/source/js/script.js"></script>
	<script src="${ cl }/source/js/myVideoTab.js"></script>
</body>
</html>