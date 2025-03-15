<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
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
	<title>${ creator.creatorName } - whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="flex max-w-4xl py-10 mx-auto">
		<div class="pl-2">
			<img src="${ fuck += creator.profileImgPath }" alt="Profile Image" class="w-28 h-28 md:w-40 md:h-40 rounded-full object-cover" loading="lazy">
        </div>
        <div class="ml-5"> 
            <h1 class="text-3xl font-semibold">${ creator.creatorName }</h1>
            <h1 class="text-xl py-1">구독자 <fmt:formatNumber value="${ creator.subscribe }" type="number" />명</h1>
            <p class="text-lg py-1 text-gray-700 truncate max-w-xl cursor-pointer" onclick="openModal()">
            	<c:choose>
            		<c:when test="${ creator.bio.length() >= 15 }">
            			${ creator.bio.substring(0, 15) }...더보기
            		</c:when>
            		<c:otherwise>
            			${ creator.bio }
            		</c:otherwise>
            	</c:choose>
            </p>

            <c:if test="${ isSubscribed }">
			    <div class="flex items-center">
			    	<p>구독중</p>
			    	<div class="px-4">
			    		<form action="${ cl }/deleteSubscri" method="post" autocomplete="off">
				    		<input type="hidden" name="subscriberId" id="subscriberId" value="${ creator.creatorId }" readonly readonly>
				    		<button type="submit" class="btn px-4 py-2 bg-red-500 hover:bg-red-300 rounded-lg text-white">구독 취소</button>
				    	</form>
			    	</div>
			    </div>
			</c:if>
			<c:if test="${ sessionScope.creatorSession != null }">
				<c:if test="${ !isSubscribed }">
				    <form action="${ cl }/subscri?subscriberId=${ creator.creatorId }&subscribingId=${ sessionScope.creatorSession.creatorId }" method="post" autocomplete="off">
				        <button type="submit" class="px-6 py-2 mt-3 bg-black text-white rounded-full hover:bg-white hover:shadow-xl hover:text-black transition duration-300">
				            구독
				        </button>
				    </form>
				</c:if> 
			</c:if>
			<c:if test="${ sessionScope.creatorSession == null }">
				<h1>구독은 로그인 후 사용 하실 수 있습니다</h1>
			</c:if>
        </div>
    </div>
    
    <div class="max-w-7xl mx-auto p-4">
	    <!-- 탭 버튼 -->
	    <div class="flex space-x-4 border-b mb-4">
	        <button class="tab-button px-4 py-2 border-b-2 border-red-500 text-red-500" onclick="showTab('latest', event)">최신 영상</button>
			<button class="tab-button px-4 py-2 text-gray-500" onclick="showTab('all', event)">모든 영상</button>
	    </div>
	
	    <!-- 최신 영상 -->
	    <div id="latest" class="tab-con">
	        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
	            <c:forEach var="cvl" items="${ creatorVideosList }" varStatus="cvlStatus">
	                <c:if test="${ cvlStatus.index < 20 }">
	                	<div class="flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
			                <div class="relative group">
			                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
			                        <a href="${ cl }/watch?v=${ cvl.videoUrl }">
			                        	<img src="${ fuck += cvl.imgPath }" alt="Video thumbnail" class="w-full h-full object-cover" loading="lazy">
			                        </a>
			                    </div>
			                </div>
			                <div class="flex gap-2">
			                    <a href="${ cl }/channel/${ cvl.creator }">
			                    	<img src="${ fuck += cvl.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
			                    </a>
			                    <div class="flex-1 min-w-0">
			                        <a href="${ cl }/watch?v=${ cvl.videoUrl }" class="font-medium text-sm line-clamp-2 hover:underline">
			                        	${ cvl.title }
			                        </a>
			                        <a href="${ cl }/channel/${ cvl.creator }" class="text-sm text-gray-600 hover:underline">
				                        ${ cvl.creator }
									</a>
			                        <div class="text-sm text-gray-600">
			                        	조회수 ${ cvl.views == 0 ? "없음" : cvl.views += "회" } | ${ cvl.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
			                        	 ? cvl.createAt.substring(6, 13) : cvl.createAt.substring(0, 13) }
			                        </div>
			                    </div>
			                </div>
			            </div>
	                </c:if>
	            </c:forEach>
	        </div>
	    </div>
	
	    <!-- 모든 영상 -->
	    <div id="all" class="tab-con hidden">
	        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
	            <c:forEach var="cvl" items="${ creatorVideosList }">
	            	<div class="flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
		                <div class="relative group">
		                    <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
		                        <a href="${ cl }/watch?v=${ cvl.videoUrl }">
		                        	<img src="${ fuck += cvl.imgPath }" alt="Video thumbnail" class="w-full h-full object-cover" loading="lazy">
		                        </a>
		                    </div>
		                </div>
		                <div class="flex gap-2">
		                    <a href="${ cl }/channel/${ cvl.creator }">
		                    	<img src="${ fuck += cvl.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
		                    </a>
		                    <div class="flex-1 min-w-0">
		                        <a href="${ cl }/watch?v=${ cvl.videoUrl }" class="font-medium text-sm line-clamp-2 hover:underline">
		                        	${ cvl.title }
		                        </a>
		                        <a href="${ cl }/channel/${ cvl.creator }" class="text-sm text-gray-600 hover:underline">
			                        ${ cvl.creator }
								</a>
		                        <div class="text-sm text-gray-600">
		                        	조회수 ${ cvl.views == 0 ? "없음" : cvl.views += "회" } | ${ cvl.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
		                        	 ? cvl.createAt.substring(6, 13) : cvl.createAt.substring(0, 13) }
		                        </div>
		                    </div>
		                </div>
		            </div>
	            </c:forEach>
	        </div>
	    </div>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
	
	<div id="modalOverlay" class="hidden fixed inset-0 bg-black/70 z-50 transition-opacity" onclick="closeModal()"></div>
	<div id="modalContent" class="hidden fixed inset-0 flex items-center justify-center z-50">
	    <div class="w-[350px] md:w-[500px] bg-white rounded-lg shadow-xl p-4 relative">
	        <h1 class="text-xl font-semibold mb-2">정보</h1>
	        <button type="button" onclick="closeModal()" class="text-4xl absolute top-1 right-4 hover:bg-gray-200 rounded-full px-2 pb-1">&times;</button>
	        <textarea style="height: 300px;" class="w-full resize-none focus:outline-none overflow-y-scroll" readonly>${ creator.bio }</textarea><br>
	        <h1 class="text-xl font-semibold mb-2">채널 세부정보</h1>
	        <ul class="space-y-1">
	            <li><span class="font-semibold">구독자</span> &nbsp; <fmt:formatNumber value="${ creator.subscribe }" type="number" />명</li>
	            <li><span class="font-semibold">가입일</span> &nbsp; ${ creator.createAt }</li>
	        </ul>
	    </div>
	</div>
	
	<script src="${ cl }/source/js/channel.js"></script>
	
</body>
</html>