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
	<title>whynot</title>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="max-w-7xl mx-auto p-4">
	    <h1 class="text-2xl font-bold mb-6">좋아요 표시한 동영상</h1>
	    
	    <c:forEach var="mlv" items="${ myLikeVideo }">
	    	<div class="hidden md:flex hover:bg-gray-200 cursor-pointer transition">
	    		<div class="relative py-4">
	    			<a href="${ cl }/watch?v=${ mlv.videos.videoUrl }">
	    				<img src="${ fuck += mlv.videos.imgPath }" alt="poster 쓰고 싶다" width="300" class="max-h-40 px-4 object-contain rounded-md cursor-pointer">
	    			</a>
		    		<span class="absolute bottom-4 right-4 bg-black text-white text-xs px-2 py-1 rounded">${ mlv.videos.videoLen }</span>
	    		</div>
	    		<div class="mx-4 py-4">
	    			<h1 class="font-semibold text-xl"><a href="${ cl }/watch?v=${ mlv.videos.videoUrl }">${ mlv.videos.title }</a></h1>
	    			<span class="block pt-2">
	    				<a href="${ cl }/channel/${ mlv.videos.creator }">${ mlv.videos.creator }</a> 
	    				• 조회수 ${ mlv.videos.views == 0 ? '없음' : mlv.videos.views += '회' } 
	    				• ${ mlv.videos.createAt }
	    			</span>
	    		</div>
	    	</div>
	    	<div class="md:hidden video-item flex flex-col gap-2 p-2 rounded-lg hover:bg-gray-200">
			    <div class="relative">
			        <div class="aspect-video bg-gray-200 rounded-lg overflow-hidden">
			            <a href="${ cl }/watch?v=${ mlv.videos.videoUrl }">
			                <img src="${ fuck += mlv.videos.imgPath }" class="w-full h-full object-cover" loading="lazy">
			            </a>
			        </div>
			        <span class="absolute bottom-2 right-2 bg-black text-white text-xs px-2 py-1 rounded">${ mlv.videos.videoLen }</span>
			    </div>
			    <div class="flex gap-2">
			        <a href="${ cl }/channel/${ mlv.videos.creator }">
			            <img src="${ fuck += mlv.videos.frontProfileImg }" class="w-10 h-10 rounded-full bg-gray-200 flex-shrink-0">
			        </a>
			        <div class="flex-1 min-w-0">
			            <a href="${ cl }/watch?v=${ mlv.videos.videoUrl }" class="font-medium text-sm line-clamp-2 hover:underline">
			                ${ mlv.videos.title }
			            </a>
			            <a href="${ cl }/channel/${ mlv.videos.creator }" class="text-sm text-gray-600 hover:underline">
			                ${ mlv.videos.creator }
			            </a>
			            <div class="text-sm text-gray-600">
			                <c:choose>
			                    <c:when test="${ mlv.videos.views == 0 }">
			                        조회수 없음
			                    </c:when>
			                    <c:when test="${ mlv.videos.views >= 10000 }">
			                        조회수 <fmt:formatNumber value="${ mlv.videos.views / 10000 }" pattern="#"/>만회
			                    </c:when>
			                    <c:otherwise>
			                        조회수 <fmt:formatNumber value="${ mlv.videos.views }" type="number" />회
			                    </c:otherwise>
			                </c:choose> • 
			                ${ mlv.videos.createAt.substring(0, 4).equals(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy")))
			                ? mlv.videos.createAt.substring(6, 13) : mlv.videos.createAt.substring(0, 13) }
			            </div>
			        </div>
			    </div>
			</div>
	    </c:forEach>
	</div>
	
	<%@ include file="/common/footer.jsp" %>
</body>
</html>