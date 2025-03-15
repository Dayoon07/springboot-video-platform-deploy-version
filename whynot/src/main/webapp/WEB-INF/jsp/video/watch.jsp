<%@page import="java.util.Arrays"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
    <title>${ watchTheVideo.title } - whynot</title>
</head>
<body>
    <%@ include file="/common/header.jsp" %>
    
    <div class="container mx-auto py-5 px-3 md:px-5 flex flex-col lg:flex-row lg:justify-between">
        <div class="w-full lg:w-10/12 lg:px-4">
            <div class="aspect-video bg-black rounded-lg overflow-hidden shadow-lg">
                <video controls autoplay poster="${ watchTheVideo.imgPath }" class="w-full h-full">
                    <source src="${ fuck += watchTheVideo.videoPath }" 
                    	type="video/${ watchTheVideo.videoPath.substring(watchTheVideo.videoPath.lastIndexOf('.') + 1) }">
                </video>
            </div>

            <div class="mt-4 space-y-4">
                <h1 class="text-xl md:text-2xl font-bold break-words">${ watchTheVideo.title }</h1>
                
                <div class="flex flex-wrap items-center gap-4">
                    <div class="flex items-center gap-3">
                        <a href="${ cl }/channel/${ videoCreatorProfileInfo.creatorName }">
                            <img src="${ fuck += videoCreatorProfileInfo.profileImgPath }" alt="${ videoCreatorProfileInfo.creatorName } 프로필" 
                            	title="${ videoCreatorProfileInfo.creatorName } 프로필" 
                                class="w-10 h-10 rounded-full border-2 border-gray-300">
                        </a>
                        <div class="text-sm">
                            <a href="${ cl }/channel/${ videoCreatorProfileInfo.creatorName }" 
                                class="font-semibold hover:underline text-gray-900 block">
                                ${ videoCreatorProfileInfo.creatorName }
                            </a>
                            <p class="text-gray-600">구독자 <fmt:formatNumber value="${ videoCreatorProfileInfo.subscribe }" type="number" />명</p>
                        </div>
                    </div>

                    <div class="flex flex-wrap gap-2 items-center mt-2 w-full md:w-auto">
                    	<c:if test="${ likeuser eq true }">
                    		<form action="${ cl }/delLike"	method="post" autocomplete="off">
		                        <button type="submit" class="px-4 py-2 bg-black text-white rounded-full hover:opacity-70 transition text-sm">
			                        <span id="watchTheVideoLikeVal">${ watchTheVideo.likes }</span>
			                    	좋아요 취소 
			                	</button>
			                    <input type="hidden" name="likeId" value="${ delLikeBtn }" required readonly>
							</form>
                    	</c:if>
                    	<c:if test="${ likeuser eq false }">
                    		<form action="${ cl }/like"	method="post" autocomplete="off" id="likeAddForm">
		                        <button type="submit" class="px-4 py-2 bg-gray-200 rounded-full hover:bg-gray-300 transition text-sm" onclick="addLike()">
			                	    좋아요 <span id="watchTheVideoLikeVal">${ watchTheVideo.likes }</span>
			                    </button>
			                    <input type="hidden" name="likeVdoId" value="${ watchTheVideo.videoId }" required readonly>
			                    <input type="hidden" name="likeVdoName" value="${ watchTheVideo.title }" required readonly>
							</form>
                    	</c:if>
                    	<c:if test="${ empty sessionScope.creatorSession }">
                    		<button type="button" class="px-4 py-2 border-gray-200 border rounded-full hover:bg-gray-300 transition text-sm">
			                	좋아요 ${ watchTheVideo.likes }
							</button>
                    	</c:if>
                        
                        <input type="hidden" id="likeCount" value="${ likeCount }">
                        <input type="hidden" id="likeCountButVideoId" value="${ watchTheVideo.videoId }">
                        
                        <c:if test="${ thisIsSubscribed }">
                            <div class="flex items-center gap-2">
                                <span class="text-sm">구독중</span>
                                <form action="${ cl }/deleteSubscri" method="post" autocomplete="off">
                                    <input type="hidden" name="subscriberId" value="${ videoCreatorProfileInfo.creatorId }">
                                    <button type="submit" class="px-3 py-1.5 bg-red-500 hover:bg-red-400 rounded-lg text-white text-sm">
                                        구독 취소
                                    </button>
                                </form>
                            </div>
                        </c:if>
                        <c:if test="${ sessionScope.creatorSession != null && !thisIsSubscribed }">
                            <form action="${ cl }/watchPageSubscri?subscriberId=${ watchTheVideo.creatorVal }&subscribingId=${ sessionScope.creatorSession.creatorId }&videoUrl=${ watchTheVideo.videoUrl }" method="post" autocomplete="off">
                                <button type="submit" class="px-4 py-2 bg-black text-white rounded-full hover:bg-gray-800 text-sm">
                                    구독
                                </button>
                            </form>
                        </c:if>
                    </div>
                </div>

                <div class="p-4 bg-gray-100 rounded-lg space-y-2">
                    <div class="text-sm text-gray-500 flex flex-wrap gap-3">
                        <span>
							<c:choose>
	                        	<c:when test="${ watchTheVideo.views == 0 }">
	                        		조회수 없음
	                        	</c:when>
	                        	<c:otherwise>
	                        		조회수 <fmt:formatNumber type="number" value="${ watchTheVideo.views }" />회
	                        	</c:otherwise>
	                        </c:choose>
						</span>
                        <span>업로드: ${ watchTheVideo.createAt.substring(0, 13) }</span>
                    </div>
                    <div class="text-sm">
                    	<c:if test="${ not empty watchTheVideo.tag }">
                    		<span class="font-semibold">태그: </span>
                    		<c:forEach var="t" items="${ fn:split(watchTheVideo.tag, ' ') }">
                    			<a href="${ cl }/tag/${ t }" class="text-blue-600 hover:underline">
		                            #${ t }
		                        </a>
                    		</c:forEach>
                    	</c:if>
                    </div>
                    <c:if test="${ not empty watchTheVideo.more and watchTheVideo.more.length() > 10 }">
                        <details class="text-sm text-gray-700">
                            <summary class="cursor-pointer hover:text-blue-600">더보기...</summary>
                            <p class="mt-2 whitespace-pre-wrap">${ watchTheVideo.more }</p>
                        </details>
                    </c:if>
                    <c:if test="${ not empty watchTheVideo.more and watchTheVideo.more.length() < 10 }">
                        <p class="text-sm whitespace-pre-wrap">${ watchTheVideo.more }</p>
                    </c:if>
                </div>

                <div style="margin-bottom: 300px;" class="mt-6 space-y-4">
                    <h2 class="text-lg font-bold">
                        댓글 
                        <c:if test="${ empty watchTheVideoCommentList }">없음</c:if>
                        <c:if test="${ not empty watchTheVideoCommentList }">${ watchTheVideoCommentList.size() }개</c:if>
                    </h2>

                    <c:if test="${ not empty sessionScope.creatorSession }">
                        <form action="${ cl }/commentAdd" method="post" autocomplete="off" class="space-y-3">
                            <div class="flex gap-3">
                                <img src="${ fuck += sessionScope.creatorSession.profileImgPath }" class="w-8 h-8 rounded-full flex-shrink-0">
                                <input type="hidden" name="commentVideo" value="${ watchTheVideo.videoId }">
                                <textarea rows="1" name="commentContent" id="commentContent" placeholder="댓글을 입력하세요..." title="댓글을 입력하세요..." oninput="autoResize(this)"  
                                    class="w-full resize-none border-b p-2 focus:border-gray-400 focus:outline-none text-sm overflow-y-hidden" required></textarea>
                            </div>
                            <div class="flex justify-end">
                            	<div id="commentContentLength" class="w-auto h-auto"></div>
                                <div class="flex justify-end">
                                	<button type="submit" id="commentWriteBtn" class="px-4 py-2 text-md text-white bg-blue-500 rounded-lg hover:bg-blue-600 mx-5">
	                                    댓글 작성
	                                </button>
	                                <button type="reset" class="px-4 py-2 text-md text-gray-500 bg-gray-100 rounded-lg hover:bg-gray-200">
	                                    취소
	                                </button>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${ empty sessionScope.creatorSession }">
                        <p class="text-sm text-gray-500">댓글은 로그인 후 작성할 수 있습니다.</p>
                    </c:if>

                    <div class="space-y-4">
                        <c:if test="${ not empty watchTheVideoCommentList }">
                            <c:forEach var="comment" items="${ watchTheVideoCommentList }">
                                <div class="p-3 hover:bg-gray-50 flex gap-3">
                                    <a href="${ cl }/channel/${ comment.commenter }">
                                        <img src="${ fuck += comment.commenterProfilepath }" class="w-8 h-8 rounded-full flex-shrink-0">
                                    </a>
                                    <div class="flex-1 min-w-0">
                                        <div class="flex justify-between items-center flex-wrap gap-2">
                                            <div>
                                            	<a href="${ cl }/channel/${ comment.commenter }" 
	                                                class="${ comment.commenter.equals(videoCreatorProfileInfo.creatorName) ? 
	                                                'bg-gray-400 rounded-full text-white text-sm pl-3 pr-2 pb-1 mr-2' : 'font-semibold text-sm' }">
	                                                ${ comment.commenter }
	                                            </a>
	                                            <span class="text-xs text-gray-400">${ comment.datetime.substring(0, 10) }</span>
                                            </div>
                                            <div class="flex items-center justify-between">
                                            	<c:if test="${ comment.commenterUserid eq sessionScope.creatorSession.creatorId }">
                                            		<button type="button" class="hover:underline hover:text-blue-500 px-5" onclick="openUpdateCommentComponent(${ comment.commentId })">댓글 수정</button>
                                            	</c:if>
                                            	<!-- 현재 사용자가 업로더 이거나 댓글을 작성한 사람이라면 삭제 버튼 출력 -->
                                            	<c:if test="${ comment.commentUserid eq sessionScope.creatorSession.creatorId or comment.commenterUserid eq sessionScope.creatorSession.creatorId }">
	                                            	<form action="${ cl }/deleteComment" method="post" autocomplete="off">
	                                            		<input type="hidden" name="commentId" id="commentId" value="${ comment.commentId }" required readonly>
	                                            		<input type="hidden" name="videoId" id="videoId" value="${ watchTheVideo.videoId }" required readonly>
	                                            		<button type="submit" class="hover:underline hover:text-red-500">댓글 삭제</button>
	                                            	</form>
	                                            </c:if>
                                            </div>
                                        </div>
                                        <div>
										    <c:choose>
										        <c:when test="${ comment.commentContent.length() > 120 }">
										        	<pre style="word-wrap: break-word; white-space: pre-wrap;" onclick="moreBtn(event, ${ comment.commentId })" class="mt-1 text-sm short-text cursor-pointer">${ comment.commentContent.substring(0, 120) }...</pre>
										        </c:when>
										        <c:otherwise>
										        	<pre style="word-wrap: break-word; white-space: pre-wrap;" class="w-[500px] ">${ comment.commentContent }</pre>
										        </c:otherwise>
										    </c:choose>
										</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="w-full lg:w-96 mt-6 lg:mt-0">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-4">
                <c:forEach var="rec" items="${ recentVideo }" varStatus="recentStatus">
                    <c:if test="${ recentStatus.index < 20 && rec.videoId != watchTheVideo.videoId }">
                        <div class="flex flex-col sm:flex-row lg:flex-col gap-3 p-3 hover:bg-gray-100 rounded-lg">
                            <div class="w-full sm:w-40 lg:w-full">
                                <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
                                    <a href="${ cl }/watch?v=${ rec.videoUrl }">
                                        <img src="${ fuck += rec.imgPath }" alt="썸네일" class="w-full h-full object-cover">
                                    </a>
                                </div>
                            </div>
                            <div class="flex-1 min-w-0">
                                <a href="${ cl }/watch?v=${ fuck += rec.videoUrl }" class="font-medium text-sm line-clamp-2 hover:underline">
                                    ${ rec.title }
                                </a>
                                <a href="${ cl }/channel/${ rec.creator }" class="text-sm text-gray-600 hover:underline block mt-1">
                                    ${ rec.creator }
                                </a>
                                <div class="text-xs text-gray-500 mt-1">
                                    <c:choose>
									    <c:when test="${ rec.views == 0 }">
									        조회수 없음
									    </c:when>
									    <c:when test="${ rec.views >= 10000 }">
									        조회수 <fmt:formatNumber value="${ rec.views / 10000 }" pattern="#"/>만회
									    </c:when>
									    <c:otherwise>
									        조회수 <fmt:formatNumber value="${ rec.views }" type="number" />회
									    </c:otherwise>
									</c:choose> • 
		                            ${ rec.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                            ? rec.createAt.substring(6, 13) : rec.createAt.substring(0, 13) }
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %>
    <script src="${ cl }/source/js/watch.js"></script>
    <script src="${ cl }/source/js/likeCount.js"></script>
    <script src="${ cl }/source/js/commentEdit.js"></script>
    <script src="${ cl }/source/js/commentContentExpansion.js"></script>
    
    <script>
	    document.addEventListener("DOMContentLoaded", function () {
	        const textareas = document.querySelectorAll(".dynamicTextarea");
	
	        function adjustHeight(textarea) {
	            textarea.style.height = "auto"; // 높이를 초기화하여 올바른 계산 수행
	            textarea.style.height = textarea.scrollHeight + "px"; // 스크롤 높이만큼 조절
	        }
	
	        textareas.forEach(textarea => {
	            textarea.addEventListener("input", () => adjustHeight(textarea)); // 사용자가 입력할 때 자동 조절
	        });
	
	        fetchData(); // 페이지 로드 시 데이터 가져오기
	    });
    </script>
    
</body>
</html>