<%@page import="com.e.d.model.entity.CreatorEntity"%>
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
    <title>whynot - 마이페이지</title>
</head>
<body>
    <%@ include file="/common/header.jsp" %>
    
    <div class="max-w-5xl mx-auto p-6 bg-white rounded-xl">
        <c:choose>
            <c:when test="${ empty sessionScope.creatorSession }">
                <div class="text-center py-12">
                    <h1 class="text-2xl font-semibold text-gray-800">로그인이 필요합니다</h1>
                    <p class="text-gray-600 mt-2">마이페이지를 이용하려면 로그인하세요.</p>
                    <a href="${ cl }/login" class="mt-4 inline-block bg-blue-500 text-white px-5 py-2 rounded-lg hover:bg-blue-600">
                        로그인
                    </a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="flex items-center space-x-8">
                	<img src="${ fuck += sessionScope.creatorSession.profileImgPath }" alt="Profile Image"
                    	class="w-32 h-32 overflow-hidden rounded-full border-4 border-gray-300 object-cover">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">${ sessionScope.creatorSession.creatorName }</h1>
                        <p class="text-gray-500 mt-1">${ sessionScope.creatorSession.creatorEmail }</p>
						<p class="text-gray-500 text-md my-2">구독자 : ${ sessionScope.creatorSession.subscribe }명</p>
						<p class="text-gray-400 text-sm">가입일 : <br class="md:hidden"> ${ sessionScope.creatorSession.createAt }</p>
                    </div>
                </div>

                <div class="mt-8 p-6 bg-gray-50 border-gray-200 border rounded-lg">
                    <h2 class="text-xl font-semibold text-gray-800">자기소개말</h2>
                    <textarea class="text-gray-700 my-2 w-full resize-none bg-gray-50 focus:outline-none" id="myBio" readonly>${ empty you.bio ? "아직 자기소개말이 없습니다." : you.bio }</textarea>
	                <c:if test="${ empty you.bio }">
						<span class="px-6 py-2 bg-black text-white rounded-md hover:opacity-70 cursor-pointer transition" onclick="bioModal()">자기소개말 만들기</span>
                    </c:if>
                    <c:if test="${ not empty you.bio }">
                    	<span class="px-6 py-2 bg-black text-white rounded-md hover:opacity-70 cursor-pointer transition" onclick="bioEditModal()">자기소개말 수정하기</span>
                    </c:if>
                </div>

                <div class="mt-6 bg-white p-6">
                    <h2 class="text-xl font-semibold text-gray-800">내 정보</h2>
                    <ul class="mt-4 space-y-3 text-gray-700">
                        <li>
                        	<span class="font-semibold">고유 ID:</span>
                        	${ sessionScope.creatorSession.creatorId }
                        </li>
                        <li>
                        	<span class="font-semibold">전화번호:</span>
                        	${ sessionScope.creatorSession.tel }
                        </li>
                    </ul>
                </div>
                
                <c:if test="${ not empty myViewStoryButMyPageData }">
                	<div class="p-6">
	                	<div class="flex justify-between items-center">
	                		<h2 class="text-xl font-semibold text-gray-800"><a href="${ cl }/you/viewstory">시청 기록</a></h2>
	                		<a href="${ cl }/you/viewstory" class="px-4 py-2 text-sm border-gray-300 border cursor-pointer rounded-full hover:bg-gray-200">모두 보기</a>
	                	</div>
                		<div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-2">
						    <c:forEach var="mvsbmpd" items="${ myViewStoryButMyPageData }" varStatus="mvsbmpdStatus">
						    	<c:if test="${ mvsbmpdStatus.index < 4 }">
							        <div class="bg-white shadow-md rounded-lg overflow-hidden">
							            <div class="relative h-60">
							                <a href="${ cl }/watch?v=${ mvsbmpd.videosVo.videoUrl }">
							                	<img src="${ fuck += mvsbmpd.videosVo.imgPath }" alt="영상 썸네일" class="w-full h-full object-cover">
							                </a>
							                <span class="absolute bottom-2 right-2 bg-black text-white text-xs px-2 py-1 rounded">${ mvsbmpd.videosVo.videoLen }</span>
							            </div>
							            <div class="p-3">
							                <div class="flex space-x-3">
							                    <div class="flex-1">
							                        <h3 class="text-sm font-semibold text-gray-800 line-clamp-2">
							                        	<a href="${ cl }/watch?v=${ mvsbmpd.videosVo.videoUrl }">${ mvsbmpd.videosVo.title }</a>
							                        </h3>
							                        <p class="text-xs text-gray-500 my-1"><a href="${ cl }/channel/${ mvsbmpd.videosVo.creator }">${ mvsbmpd.videosVo.creator }</a></p>
							                        <p class="text-xs text-gray-400">
							                        	조회수 ${ mvsbmpd.videosVo.views == 0 ? '없음' : mvsbmpd.videosVo.views += '회'} 
							                        	• ${ mvsbmpd.videosVo.createAt.substring(0, 13) }
							                        </p>
							                    </div>
							                </div>
							            </div>
							        </div>
						        </c:if>
						    </c:forEach>
						</div>
                	</div>
				</c:if>
                
                <c:if test="${ not empty myLikeVideoButMyPageData }">
                	<div class="p-6 mb-96">
	                	<div class="flex justify-between items-center">
	                		<h2 class="text-xl font-semibold text-gray-800"><a href="${ cl }/you/viewstory">좋아요 표시한 영상</a></h2>
	                		<a href="${ cl }/you/like" class="px-4 py-2 text-sm border-gray-300 border cursor-pointer rounded-full hover:bg-gray-200">모두 보기</a>
	                	</div>
                		<div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-2">
						    <c:forEach var="mlvbmpd" items="${ myLikeVideoButMyPageData }" varStatus="mlvbmpdStatus">
						    	<c:if test="${ mlvbmpdStatus.index < 4 }">
							        <div class="bg-white shadow-md rounded-lg overflow-hidden">
							            <div class="relative h-60">
							                <a href="${ cl }/watch?v=${ mlvbmpd.videos.videoUrl }">
							                	<img src="${ fuck += mlvbmpd.videos.imgPath }" alt="영상 썸네일" class="w-full h-full object-cover">
							                </a>
							                <span class="absolute bottom-2 right-2 bg-black text-white text-xs px-2 py-1 rounded">${ mlvbmpd.videos.videoLen }</span>
							            </div>
							            <div class="p-3">
							                <div class="flex space-x-3">
							                    <div class="flex-1">
							                        <h3 class="text-sm font-semibold text-gray-800 line-clamp-2">
							                        	<a href="${ cl }/watch?v=${ mlvbmpd.videos.videoUrl }">${ mlvbmpd.videos.title }</a>
							                        </h3>
							                        <p class="text-xs text-gray-500 my-1"><a href="${ cl }/channel/${ mlvbmpd.videos.creator }">${ mlvbmpd.videos.creator }</a></p>
							                        <p class="text-xs text-gray-400">
							                        	조회수 ${ mlvbmpd.videos.views == 0 ? '없음' : mlvbmpd.videos.views += '회'} 
							                        	• ${ mlvbmpd.videos.createAt.substring(0, 13) }
							                        </p>
							                    </div>
							                </div>
							            </div>
							        </div>
						        </c:if>
						    </c:forEach>
						</div>
                	</div>
				</c:if>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div id="qwertyuiop" class="hidden fixed top-0 left-0 w-full h-full bg-white z-90">
    	<p class="text-4xl p-4 m-4 cursor-pointer" onclick="bioModalCloseFuck()">&times;</p>
    </div>
    <div id="createBioModalFuck" class="hidden">
    	<textarea rows="5" name="bio" oninput="autoResize(this)" style="width: 380px;" class="p-3 border focus:ring-2 focus:ring-black 
    		focus:outline-none resize-none overflow-y-hidden" required>${ not empty you.bio ? you.bio : '' }</textarea>
    	<div class="text-right mb-20 mt-4">
    		<span onclick="createBio()" class="px-6 py-2 bg-black text-white rounded hover:opacity-70 cursor-pointer">만들기</span>
    	</div>
    </div>
    
    <%@ include file="/common/footer.jsp" %>
    <script src="${ cl }/source/js/you.js"></script>
    
    <script>
    	function autoResizeTextarea() {
    		const t = document.getElementById("myBio");
    		t.style.height = "auto";
    		t.style.height = t.scrollHeight + "px";
    	}
    	window.onload = function() {
    		autoResizeTextarea();
    	}
    </script>
</body>
</html>
